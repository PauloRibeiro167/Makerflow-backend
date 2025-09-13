class Api::V1::HistoricoAtividadesController < ApplicationController
  before_action :set_historico_atividade, only: [:show, :update, :destroy]

  # GET /api/v1/historico_atividades
  def index
    @historico_atividades = HistoricoAtividade.all
    render json: @historico_atividades, status: :ok
  rescue StandardError => e
    render json: { error: 'Erro ao buscar histórico de atividades', details: e.message }, status: :internal_server_error
  end

  # GET /api/v1/historico_atividades/:id
  def show
    render json: @historico_atividade, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Histórico de atividade não encontrado' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao buscar histórico de atividade', details: e.message }, status: :internal_server_error
  end

  # POST /api/v1/historico_atividades
  def create
    @historico_atividade = HistoricoAtividade.new(historico_atividade_params)
    if @historico_atividade.save
      render json: @historico_atividade, status: :created
    else
      render json: { errors: @historico_atividade.errors.full_messages }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: 'Erro ao criar histórico de atividade', details: e.message }, status: :internal_server_error
  end

  # PATCH/PUT /api/v1/historico_atividades/:id
  def update
    if @historico_atividade.update(historico_atividade_params)
      render json: @historico_atividade, status: :ok
    else
      render json: { errors: @historico_atividade.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Histórico de atividade não encontrado' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao atualizar histórico de atividade', details: e.message }, status: :internal_server_error
  end

  # DELETE /api/v1/historico_atividades/:id
  def destroy
    @historico_atividade.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Histórico de atividade não encontrado' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao deletar histórico de atividade', details: e.message }, status: :internal_server_error
  end

  private

  def set_historico_atividade
    @historico_atividade = HistoricoAtividade.find(params[:id])
  end

  def historico_atividade_params
    params.require(:historico_atividade).permit(:id_usuario_id, :tipo_acao, :tipo_entidade, :id_entidade, :descricao, :alteracoes_antes, :alteracoes_depois, :data_criacao)
  end
end
