class Api::V1::DocumentosProjetoController < ApplicationController
  before_action :set_documento_projeto, only: [:show, :update, :destroy]
  before_action :set_quadro_kanban, only: [:create]

  def index
    if params[:quadro_kanban_id]
      @documentos_projeto = DocumentoProjeto.where(quadro_kanban_id: params[:quadro_kanban_id])
    else
      @documentos_projeto = DocumentoProjeto.all
    end
    render json: @documentos_projeto
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def show
    render json: @documento_projeto
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Documento do projeto não encontrado' }, status: :not_found
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def create
    @documento_projeto = @quadro_kanban.documentos_projeto.build(documento_projeto_params)
    if @documento_projeto.save
      render json: @documento_projeto, status: :created
    else
      render json: { errors: @documento_projeto.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def update
    if @documento_projeto.update(documento_projeto_params)
      render json: @documento_projeto
    else
      render json: { errors: @documento_projeto.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def destroy
    @documento_projeto.destroy
    head :no_content
  rescue ActiveRecord::RecordNotDestroyed => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def set_documento_projeto
    @documento_projeto = DocumentoProjeto.find(params[:id])
  end

  def set_quadro_kanban
    @quadro_kanban = QuadroKanban.find(params[:quadro_kanban_id]) if params[:quadro_kanban_id]
  end

  def documento_projeto_params
    params.require(:documento_projeto).permit(:quadro_kanban_id, :tipo_documento, :caminho_documento, :anotacoes)
  end
end
