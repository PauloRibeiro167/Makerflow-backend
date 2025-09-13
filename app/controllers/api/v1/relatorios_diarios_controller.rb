class Api::V1::RelatoriosDiariosController < ApplicationController
  before_action :set_relatorio_diario, only: [:show, :update, :destroy]
  before_action :set_sprint, only: [:index, :create]

  def index
    if @sprint
      @relatorios_diarios = @sprint.relatorios_diarios
    else
      @relatorios_diarios = RelatorioDiario.all
    end
    render json: @relatorios_diarios
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def show
    render json: @relatorio_diario
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Relatório Diário não encontrado' }, status: :not_found
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def create
    @relatorio_diario = RelatorioDiario.new(relatorio_diario_params)
    @relatorio_diario.sprint = @sprint if @sprint
    if @relatorio_diario.save
      render json: @relatorio_diario, status: :created
    else
      render json: { errors: @relatorio_diario.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def update
    if @relatorio_diario.update(relatorio_diario_params)
      render json: @relatorio_diario
    else
      render json: { errors: @relatorio_diario.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def destroy
    @relatorio_diario.destroy
    head :no_content
  rescue ActiveRecord::RecordNotDestroyed => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def set_relatorio_diario
    @relatorio_diario = RelatorioDiario.find(params[:id])
  end

  def set_sprint
    @sprint = Sprint.find(params[:sprint_id]) if params[:sprint_id]
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Sprint não encontrado' }, status: :not_found
  end

  def relatorio_diario_params
    params.require(:relatorio_diario).permit(:data_relatorio, :sprint_id, :pontos_atencao, :acoes_a_serem_tomadas)
  end
end
