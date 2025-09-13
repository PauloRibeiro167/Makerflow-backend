Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Etapa 1: Estrutura Fundamental
      resources :unidades, only: [:index, :show, :create, :update, :destroy] do
        resources :setores, shallow: true
      end
      resources :setores, only: [:index, :show, :create, :update, :destroy] do
        resources :celulas, shallow: true
      end
      resources :celulas, only: [:index, :show, :create, :update, :destroy] do
        resources :equipes, shallow: true
      end
      resources :equipes, only: [:index, :show, :create, :update, :destroy] do
        resources :membros_da_equipe, shallow: true
      end
      resources :usuarios
      resources :membros_da_equipe, only: [:index, :show, :create, :update, :destroy]

      # Etapa 2: Gerenciamento de Projetos (Kanban)
      resources :quadro_kanban do
        resources :tasks, shallow: true
        resources :documentos_projeto, shallow: true
        resources :ativos_projeto, shallow: true
        resources :diagramas, shallow: true
        resources :pauta_reuniao, shallow: true
        resources :itens_de_acao, shallow: true
        resources :riscos, shallow: true
        resources :documents, shallow: true
      end
      resources :documentos_projeto, only: [:index, :show, :create, :update, :destroy]
      resources :ativos_projeto, only: [:index, :show, :create, :update, :destroy]
      resources :diagramas, only: [:index, :show, :create, :update, :destroy]

      # Etapa 3: Tarefas e Sprints
      resources :tasks, only: [:index, :show, :create, :update, :destroy] do
        resources :time_logs, shallow: true
        resources :attachments, shallow: true
      end
      resources :sprints do
        resources :relatorios_diarios, shallow: true
      end

      # Etapa 5: Relatórios e Acompanhamento
      resources :relatorios_diarios, only: [:index, :create] do
        resources :entradas_trabalho, shallow: true
      end
      resources :entradas_trabalho, only: [:index, :create] do
        resources :impedimentos, shallow: true
      end
      resources :impedimentos, only: [:index, :show, :create, :update, :destroy]

      # Etapa 6: Reuniões
      resources :reunioes do
        resources :participantes_reuniao, shallow: true
        resources :pauta_reuniao, shallow: true
        resources :itens_de_acao, shallow: true
      end
      resources :participantes_reuniao, only: [:index, :show, :create, :update, :destroy]
      resources :pauta_reuniao, only: [:index, :show, :create, :update, :destroy]
      resources :itens_de_acao, only: [:index, :show, :create, :update, :destroy]

      # Etapa 7: Métricas, Notificações e Outros
      resources :metricas_projeto, only: [:index, :show, :create, :update, :destroy]
      resources :notificacoes, only: [:index, :show, :create, :update, :destroy]
      resources :riscos, only: [:index, :show, :create, :update, :destroy]
      resources :historico_atividades, only: [:index, :show]
      resources :time_logs, only: [:index, :show, :create, :update, :destroy]
      resources :automations, only: [:index, :show, :create, :update, :destroy]
      resources :documents, only: [:index, :show, :create, :update, :destroy] do
        resources :attachments, shallow: true
      end
      resources :attachments, only: [:index, :show, :create, :update, :destroy]
    end
  end
end