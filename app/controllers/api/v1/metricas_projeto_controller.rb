class Api::V1::MetricasProjetoController < ApplicationController
  before_action :set_metrica_projeto, only: [:show, :update, :destroy]

  # GET /api/v1/metricas_projeto
  def index
    @metricas_projeto = MetricaProjeto.all
    render json: @metricas_projeto, status: :ok
  rescue StandardError => e
    render json: { error: 'Erro ao buscar métricas do projeto', details: e.message }, status: :internal_server_error
  end

  # GET /api/v1/metricas_projeto/:id
  def show
    render json: @metrica_projeto, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Métrica do projeto não encontrada' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao buscar métrica do projeto', details: e.message }, status: :internal_server_error
  end

  # POST /api/v1/metricas_projeto
  def create
    @metrica_projeto = MetricaProjeto.new(metrica_projeto_params)
    if @metrica_projeto.save
      render json: @metrica_projeto, status: :created
    else
      render json: { errors: @metrica_projeto.errors.full_messages }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: 'Erro ao criar métrica do projeto', details: e.message }, status: :internal_server_error
  end

  # PATCH/PUT /api/v1/metricas_projeto/:id
  def update
    if @metrica_projeto.update(metrica_projeto_params)
      render json: @metrica_projeto, status: :ok
    else
      render json: { errors: @metrica_projeto.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Métrica do projeto não encontrada' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao atualizar métrica do projeto', details: e.message }, status: :internal_server_error
  end

  # DELETE /api/v1/metricas_projeto/:id
  def destroy
    @metrica_projeto.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Métrica do projeto não encontrada' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao deletar métrica do projeto', details: e.message }, status: :internal_server_error
  end

  private

  def set_metrica_projeto
    @metrica_projeto = MetricaProjeto.find(params[:id])
  end

  def metrica_projeto_params
    params.require(:metrica_projeto).permit(:nome_metrica, :valor_metrica, :unidade, :data_captura, :id_projeto_id, :id_sprint_id, :id_equipe_id)
  end
end
