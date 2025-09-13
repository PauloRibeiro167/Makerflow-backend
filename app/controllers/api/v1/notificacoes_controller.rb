class Api::V1::NotificacoesController < ApplicationController
  before_action :set_notificacao, only: [:show, :update, :destroy]

  # GET /api/v1/notificacoes
  def index
    @notificacoes = Notificacao.all
    render json: @notificacoes, status: :ok
  rescue StandardError => e
    render json: { error: 'Erro ao buscar notificações', details: e.message }, status: :internal_server_error
  end

  # GET /api/v1/notificacoes/:id
  def show
    render json: @notificacao, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Notificação não encontrada' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao buscar notificação', details: e.message }, status: :internal_server_error
  end

  # POST /api/v1/notificacoes
  def create
    @notificacao = Notificacao.new(notificacao_params)
    if @notificacao.save
      render json: @notificacao, status: :created
    else
      render json: { errors: @notificacao.errors.full_messages }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: 'Erro ao criar notificação', details: e.message }, status: :internal_server_error
  end

  # PATCH/PUT /api/v1/notificacoes/:id
  def update
    if @notificacao.update(notificacao_params)
      render json: @notificacao, status: :ok
    else
      render json: { errors: @notificacao.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Notificação não encontrada' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao atualizar notificação', details: e.message }, status: :internal_server_error
  end

  # DELETE /api/v1/notificacoes/:id
  def destroy
    @notificacao.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Notificação não encontrada' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao deletar notificação', details: e.message }, status: :internal_server_error
  end

  private

  def set_notificacao
    @notificacao = Notificacao.find(params[:id])
  end

  def notificacao_params
    params.require(:notificacao).permit(:id_usuario_destinatario_id, :id_usuario_remetente_id, :tipo_notificacao, :mensagem, :link_relacionado, :id_entidade_relacionada, :lida, :arquivada, :data_criacao)
  end
end
