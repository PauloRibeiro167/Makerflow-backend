# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_09_03_021118) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "ativo_projetos", force: :cascade do |t|
    t.bigint "quadro_kanban_id", null: false
    t.string "tipo_ativo"
    t.string "caminho_ativo"
    t.text "descricao_ativo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quadro_kanban_id"], name: "index_ativo_projetos_on_quadro_kanban_id"
  end

  create_table "attachments", force: :cascade do |t|
    t.bigint "document_id", null: false
    t.bigint "task_id", null: false
    t.string "file_name"
    t.string "file_path"
    t.integer "file_size"
    t.bigint "uploaded_by_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_attachments_on_document_id"
    t.index ["task_id"], name: "index_attachments_on_task_id"
    t.index ["uploaded_by_user_id"], name: "index_attachments_on_uploaded_by_user_id"
  end

  create_table "automations", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "trigger_event"
    t.json "trigger_data"
    t.string "action_type"
    t.json "action_data"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "celulas", force: :cascade do |t|
    t.string "nome_celula"
    t.bigint "setor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["setor_id"], name: "index_celulas_on_setor_id"
  end

  create_table "diagramas", force: :cascade do |t|
    t.bigint "quadro_kanban_id", null: false
    t.string "nome_arquivo"
    t.string "caminho_arquivo"
    t.string "tipo_diagrama"
    t.date "data_criacao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quadro_kanban_id"], name: "index_diagramas_on_quadro_kanban_id"
  end

  create_table "documento_projetos", force: :cascade do |t|
    t.bigint "quadro_kanban_id", null: false
    t.string "tipo_documento"
    t.string "caminho_documento"
    t.text "anotacoes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quadro_kanban_id"], name: "index_documento_projetos_on_quadro_kanban_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.bigint "quadro_kanban_id", null: false
    t.bigint "parent_document_id"
    t.bigint "created_by_user_id", null: false
    t.bigint "last_edited_by_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_user_id"], name: "index_documents_on_created_by_user_id"
    t.index ["last_edited_by_user_id"], name: "index_documents_on_last_edited_by_user_id"
    t.index ["parent_document_id"], name: "index_documents_on_parent_document_id"
    t.index ["quadro_kanban_id"], name: "index_documents_on_quadro_kanban_id"
  end

  create_table "entrada_trabalhos", force: :cascade do |t|
    t.bigint "relatorio_diario_id", null: false
    t.bigint "quadro_kanban_id", null: false
    t.string "reportado_por"
    t.text "o_que_foi_feito"
    t.text "o_que_sera_feito"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quadro_kanban_id"], name: "index_entrada_trabalhos_on_quadro_kanban_id"
    t.index ["relatorio_diario_id"], name: "index_entrada_trabalhos_on_relatorio_diario_id"
  end

  create_table "equipes", force: :cascade do |t|
    t.string "nome_equipe"
    t.bigint "celula_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["celula_id"], name: "index_equipes_on_celula_id"
  end

  create_table "historico_atividades", force: :cascade do |t|
    t.bigint "usuario_id", null: false
    t.string "tipo_acao"
    t.string "tipo_entidade"
    t.integer "id_entidade"
    t.text "descricao"
    t.json "alteracoes_antes"
    t.json "alteracoes_depois"
    t.datetime "data_criacao", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_id"], name: "index_historico_atividades_on_usuario_id"
  end

  create_table "impedimentos", force: :cascade do |t|
    t.bigint "entrada_trabalho_id", null: false
    t.text "descricao_impedimento"
    t.string "status_impedimento"
    t.string "categoria_impedimento"
    t.string "responsavel_impedimento"
    t.text "notas_resolucao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entrada_trabalho_id"], name: "index_impedimentos_on_entrada_trabalho_id"
  end

  create_table "item_de_acaos", force: :cascade do |t|
    t.bigint "reuniao_id", null: false
    t.bigint "quadro_kanban_id", null: false
    t.text "descricao_acao"
    t.string "responsavel"
    t.date "data_prazo"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quadro_kanban_id"], name: "index_item_de_acaos_on_quadro_kanban_id"
    t.index ["reuniao_id"], name: "index_item_de_acaos_on_reuniao_id"
  end

  create_table "membro_da_equipes", force: :cascade do |t|
    t.bigint "usuario_id", null: false
    t.bigint "equipe_id", null: false
    t.date "data_adesao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipe_id"], name: "index_membro_da_equipes_on_equipe_id"
    t.index ["usuario_id"], name: "index_membro_da_equipes_on_usuario_id"
  end

  create_table "metrica_projetos", force: :cascade do |t|
    t.string "nome_metrica"
    t.decimal "valor_metrica"
    t.string "unidade"
    t.date "data_captura"
    t.bigint "quadro_kanban_id", null: false
    t.bigint "sprint_id", null: false
    t.bigint "equipe_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipe_id"], name: "index_metrica_projetos_on_equipe_id"
    t.index ["quadro_kanban_id"], name: "index_metrica_projetos_on_quadro_kanban_id"
    t.index ["sprint_id"], name: "index_metrica_projetos_on_sprint_id"
  end

  create_table "notificacaos", force: :cascade do |t|
    t.bigint "destinatario_id", null: false
    t.bigint "remetente_id", null: false
    t.string "tipo_notificacao"
    t.text "mensagem"
    t.string "link_relacionado"
    t.integer "id_entidade_relacionada"
    t.boolean "lida"
    t.boolean "arquivada"
    t.datetime "data_criacao", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["destinatario_id"], name: "index_notificacaos_on_destinatario_id"
    t.index ["remetente_id"], name: "index_notificacaos_on_remetente_id"
  end

  create_table "participante_reuniaos", force: :cascade do |t|
    t.bigint "reuniao_id", null: false
    t.string "nome_membro"
    t.string "papel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reuniao_id"], name: "index_participante_reuniaos_on_reuniao_id"
  end

  create_table "pauta_reuniaos", force: :cascade do |t|
    t.bigint "reuniao_id", null: false
    t.text "topico_item"
    t.text "anotacoes_discussao"
    t.text "decisoes_tomadas"
    t.bigint "quadro_kanban_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quadro_kanban_id"], name: "index_pauta_reuniaos_on_quadro_kanban_id"
    t.index ["reuniao_id"], name: "index_pauta_reuniaos_on_reuniao_id"
  end

  create_table "projetos", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quadro_kanbans", force: :cascade do |t|
    t.string "titulo_tarefa"
    t.text "descricao"
    t.string "status_tarefa"
    t.date "data_vencimento"
    t.date "data_inicio"
    t.date "data_prioridade"
    t.string "tipo_tarefa"
    t.string "responsavel"
    t.text "comentarios"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relatorio_diarios", force: :cascade do |t|
    t.date "data_relatorio"
    t.bigint "sprint_id", null: false
    t.text "pontos_atencao"
    t.text "acoes_a_serem_tomadas"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sprint_id"], name: "index_relatorio_diarios_on_sprint_id"
  end

  create_table "reuniaos", force: :cascade do |t|
    t.date "data_reuniao"
    t.time "horario_previsto_inicio"
    t.time "horario_previsto_fim"
    t.time "horario_real_inicio"
    t.time "horario_real_fim"
    t.text "tema"
    t.text "link_reuniao"
    t.text "notas_pessoais"
    t.string "facilitador"
    t.bigint "sprint_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sprint_id"], name: "index_reuniaos_on_sprint_id"
  end

  create_table "riscos", force: :cascade do |t|
    t.bigint "quadro_kanban_id", null: false
    t.string "titulo_risco"
    t.text "descricao"
    t.string "probabilidade"
    t.string "impacto"
    t.integer "pontuacao_criticidade"
    t.string "status_risco"
    t.text "plano_mitigacao"
    t.bigint "responsavel_id", null: false
    t.datetime "data_criacao", precision: nil
    t.datetime "data_resolucao", precision: nil
    t.datetime "data_atualizacao", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quadro_kanban_id"], name: "index_riscos_on_quadro_kanban_id"
    t.index ["responsavel_id"], name: "index_riscos_on_responsavel_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "setors", force: :cascade do |t|
    t.string "nome_setor"
    t.bigint "unidade_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unidade_id"], name: "index_setors_on_unidade_id"
  end

  create_table "sprints", force: :cascade do |t|
    t.string "nome_sprint"
    t.date "data_inicio"
    t.date "data_fim"
    t.text "objetivo_sprint"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "priority"
    t.string "status"
    t.date "start_date"
    t.date "due_date"
    t.datetime "completed_at", precision: nil
    t.bigint "quadro_kanban_id", null: false
    t.bigint "parent_task_id"
    t.boolean "is_macro_task"
    t.bigint "user_id", null: false
    t.decimal "estimated_effort"
    t.bigint "assignee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignee_id"], name: "index_tasks_on_assignee_id"
    t.index ["parent_task_id"], name: "index_tasks_on_parent_task_id"
    t.index ["quadro_kanban_id"], name: "index_tasks_on_quadro_kanban_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "time_logs", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.bigint "user_id", null: false
    t.decimal "hours_logged"
    t.text "description"
    t.date "log_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_time_logs_on_task_id"
    t.index ["user_id"], name: "index_time_logs_on_user_id"
  end

  create_table "unidades", force: :cascade do |t|
    t.string "nome_unidade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_projects", force: :cascade do |t|
    t.bigint "usuario_id", null: false
    t.bigint "projeto_id", null: false
    t.bigint "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["projeto_id"], name: "index_user_projects_on_projeto_id"
    t.index ["role_id"], name: "index_user_projects_on_role_id"
    t.index ["usuario_id"], name: "index_user_projects_on_usuario_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "nome_completo"
    t.date "data_nascimento"
    t.string "chave_acesso"
    t.string "email"
    t.string "telefone"
    t.string "usuario_git"
    t.string "url_foto_perfil"
    t.string "role"
    t.string "status"
    t.datetime "data_criacao", precision: nil
    t.datetime "ultimo_login", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id", null: false
    t.index ["chave_acesso"], name: "index_usuarios_on_chave_acesso", unique: true
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["role_id"], name: "index_usuarios_on_role_id"
  end

  add_foreign_key "ativo_projetos", "quadro_kanbans"
  add_foreign_key "attachments", "documents"
  add_foreign_key "attachments", "tasks"
  add_foreign_key "attachments", "usuarios", column: "uploaded_by_user_id"
  add_foreign_key "celulas", "setors"
  add_foreign_key "diagramas", "quadro_kanbans"
  add_foreign_key "documento_projetos", "quadro_kanbans"
  add_foreign_key "documents", "documents", column: "parent_document_id"
  add_foreign_key "documents", "quadro_kanbans"
  add_foreign_key "documents", "usuarios", column: "created_by_user_id"
  add_foreign_key "documents", "usuarios", column: "last_edited_by_user_id"
  add_foreign_key "entrada_trabalhos", "quadro_kanbans"
  add_foreign_key "entrada_trabalhos", "relatorio_diarios"
  add_foreign_key "equipes", "celulas"
  add_foreign_key "historico_atividades", "usuarios"
  add_foreign_key "impedimentos", "entrada_trabalhos"
  add_foreign_key "item_de_acaos", "quadro_kanbans"
  add_foreign_key "item_de_acaos", "reuniaos"
  add_foreign_key "membro_da_equipes", "equipes"
  add_foreign_key "membro_da_equipes", "usuarios"
  add_foreign_key "metrica_projetos", "equipes"
  add_foreign_key "metrica_projetos", "quadro_kanbans"
  add_foreign_key "metrica_projetos", "sprints"
  add_foreign_key "notificacaos", "usuarios", column: "destinatario_id"
  add_foreign_key "notificacaos", "usuarios", column: "remetente_id"
  add_foreign_key "participante_reuniaos", "reuniaos"
  add_foreign_key "pauta_reuniaos", "quadro_kanbans"
  add_foreign_key "pauta_reuniaos", "reuniaos"
  add_foreign_key "relatorio_diarios", "sprints"
  add_foreign_key "reuniaos", "sprints"
  add_foreign_key "riscos", "quadro_kanbans"
  add_foreign_key "riscos", "usuarios", column: "responsavel_id"
  add_foreign_key "setors", "unidades"
  add_foreign_key "tasks", "quadro_kanbans"
  add_foreign_key "tasks", "tasks", column: "parent_task_id"
  add_foreign_key "tasks", "usuarios", column: "assignee_id"
  add_foreign_key "tasks", "usuarios", column: "user_id"
  add_foreign_key "time_logs", "tasks"
  add_foreign_key "time_logs", "usuarios", column: "user_id"
  add_foreign_key "user_projects", "projetos"
  add_foreign_key "user_projects", "roles"
  add_foreign_key "user_projects", "usuarios"
  add_foreign_key "usuarios", "roles"
end
