# Plano de Implementação de Controllers da API (CRUD)

Este plano detalha a criação dos controllers da API Rails, seguindo as melhores práticas para serviços backend que servem a um frontend.

## Estratégia Geral

1.  **Namespace:** Todos os controllers residirão em `app/controllers/api/v1/` para versionamento da API.
2.  **Controller Base:** Criaremos um `Api::V1::BaseController` para centralizar o tratamento de erros e outras lógicas comuns.
3.  **Herança:** Todos os controllers de recursos herdarão do `BaseController`.
4.  **Respostas JSON:** As ações CRUD (`index`, `show`, `create`, `update`, `destroy`) retornarão respostas em formato JSON, incluindo mensagens de erro padronizadas.

---

## Passo 1: Criar o Controller Base

Este é o primeiro e mais importante passo para garantir consistência e um bom tratamento de erros.

**Arquivo:** `app/controllers/api/v1/base_controller.rb`

**Objetivo:**
- Herdar de `ActionController::API`.
- Implementar `rescue_from` para tratar exceções comuns de forma centralizada.

**Exemplo de Implementação:**
```ruby
# app/controllers/api/v1/base_controller.rb
class Api::V1::BaseController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  private

  def render_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def render_unprocessable_entity(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
```

---

## Passo 2: Implementar os Controllers de Recursos (CRUD)

Para cada modelo gerado no plano de migração, crie o controller correspondente.

### Etapa 1: Estrutura Fundamental (Usuários e Organização)

1.  **`Api::V1::UnidadesController`**
    - `index`: Lista todas as unidades (com paginação).
    - `show`: Exibe uma unidade específica.
    - `create`: Cria uma nova unidade.
    - `update`: Atualiza uma unidade.
    - `destroy`: Remove uma unidade.

2.  **`Api::V1::SetoresController`**
    - `index`: Lista todos os setores (pode ser aninhado sob uma unidade: `/api/v1/unidades/:unidade_id/setores`).
    - `show`: Exibe um setor específico.
    - `create`: Cria um novo setor.
    - `update`: Atualiza um setor.
    - `destroy`: Remove um setor.

3.  **`Api::V1::CelulasController`** (similar ao de Setores, aninhado em Setor)
4.  **`Api::V1::EquipesController`** (similar ao de Setores, aninhado em Célula)
5.  **`Api::V1::UsuariosController`** (CRUD completo)
6.  **`Api::V1::MembrosDaEquipeController`** (CRUD completo, para associar/desassociar usuários de equipes)

### Etapa 2: Gerenciamento de Projetos (Kanban)

1.  **`Api::V1::QuadroKanbanController`**
    - `index`: Lista todos os quadros/projetos.
    - `show`: Exibe um quadro/projeto e talvez suas tarefas associadas.
    - `create`: Cria um novo quadro.
    - `update`: Atualiza um quadro.
    - `destroy`: Remove um quadro.

### Etapa 3: Tarefas e Sprints

1.  **`Api::V1::TasksController`**
    - `index`: Lista tarefas (pode ser aninhado sob um projeto: `/api/v1/quadro_kanban/:quadro_kanban_id/tasks`).
    - `show`: Exibe uma tarefa.
    - `create`: Cria uma nova tarefa.
    - `update`: Atualiza uma tarefa (ex: mudança de status, responsável).
    - `destroy`: Remove uma tarefa.

2.  **`Api::V1::SprintsController`** (CRUD completo)

### Etapas Subsequentes (4 a 7)

O padrão se repete para todos os outros controllers definidos no plano de migração. Para cada um, implemente as cinco ações CRUD padrão (`index`, `show`, `create`, `update`, `destroy`), sempre pensando em como os recursos se aninham.

**Exemplo de um controller:**

```ruby
# app/controllers/api/v1/unidades_controller.rb
class Api::V1::UnidadesController < Api::V1::BaseController
  before_action :set_unidade, only: [:show, :update, :destroy]

  # GET /api/v1/unidades
  def index
    @unidades = Unidade.all
    render json: @unidades
  end

  # GET /api/v1/unidades/:id
  def show
    render json: @unidade
  end

  # POST /api/v1/unidades
  def create
    @unidade = Unidade.new(unidade_params)
    if @unidade.save
      render json: @unidade, status: :created
    else
      render_unprocessable_entity(@unidade)
    end
  end

  # PATCH/PUT /api/v1/unidades/:id
  def update
    if @unidade.update(unidade_params)
      render json: @unidade
    else
      render_unprocessable_entity(@unidade)
    end
  end

  # DELETE /api/v1/unidades/:id
  def destroy
    @unidade.destroy
    head :no_content
  end

  private

  def set_unidade
    @unidade = Unidade.find(params[:id])
  end

  def unidade_params
    params.require(:unidade).permit(:nome_unidade)
  end
end
```

Este plano fornece uma estrutura clara para desenvolver sua API de forma organizada e robusta.
