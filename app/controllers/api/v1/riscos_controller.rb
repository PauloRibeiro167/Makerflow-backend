class Api::V1::RiscosController < ApplicationController
  before_action :set_risco, only: [:show, :update, :destroy]

  # GET /api/v1/riscos
  def index
    @riscos = Risco.all
    render json: @riscos, status: :ok
  rescue StandardError => e
    render json: { error: 'Erro ao buscar riscos', details: e.message }, status: :internal_server_error
  end

  # GET /api/v1/riscos/:id
  def show
    render json: @risco, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Risco não encontrado' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao buscar risco', details: e.message }, status: :internal_server_error
  end

  # POST /api/v1/riscos
  def create
    @risco = Risco.new(risco_params)
    if @risco.save
      render json: @risco, status: :created
    else
      render json: { errors: @risco.errors.full_messages }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: 'Erro ao criar risco', details: e.message }, status: :internal_server_error
  end

  # PATCH/PUT /api/v1/riscos/:id
  def update
    if @risco.update(risco_params)
      render json: @risco, status: :ok
    else
      render json: { errors: @risco.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Risco não encontrado' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao atualizar risco', details: e.message }, status: :internal_server_error
  end

  # DELETE /api/v1/riscos/:id
  def destroy
    @risco.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Risco não encontrado' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao deletar risco', details: e.message }, status: :internal_server_error
  end

  private

  def set_risco
    @risco = Risco.find(params[:id])
  end

  def risco_params
    params.require(:risco).permit(:id_projeto_id, :titulo_risco, :descricao, :probabilidade, :impacto, :pontuacao_criticidade, :status_risco, :plano_mitigacao, :id_responsavel_id, :data_criacao, :data_resolucao, :data_atualizacao)
  end
end
