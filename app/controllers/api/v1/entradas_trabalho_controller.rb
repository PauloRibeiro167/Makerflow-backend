class Api::V1::EntradasTrabalhoController < ApplicationController
  before_action :set_entrada_trabalho, only: [:show, :update, :destroy]
  before_action :set_relatorio_diario, only: [:index, :create]

  def index
    if @relatorio_diario
      @entradas_trabalho = @relatorio_diario.entradas_trabalho
    else
      @entradas_trabalho = EntradaTrabalho.all
    end
    render json: @entradas_trabalho
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def show
    render json: @entrada_trabalho
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Entrada de Trabalho não encontrada' }, status: :not_found
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def create
    @entrada_trabalho = EntradaTrabalho.new(entrada_trabalho_params)
    @entrada_trabalho.relatorio_diario = @relatorio_diario if @relatorio_diario
    if @entrada_trabalho.save
      render json: @entrada_trabalho, status: :created
    else
      render json: { errors: @entrada_trabalho.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def update
    if @entrada_trabalho.update(entrada_trabalho_params)
      render json: @entrada_trabalho
    else
      render json: { errors: @entrada_trabalho.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def destroy
    @entrada_trabalho.destroy
    head :no_content
  rescue ActiveRecord::RecordNotDestroyed => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def set_entrada_trabalho
    @entrada_trabalho = EntradaTrabalho.find(params[:id])
  end

  def set_relatorio_diario
    @relatorio_diario = RelatorioDiario.find(params[:relatorio_diario_id]) if params[:relatorio_diario_id]
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Relatório Diário não encontrado' }, status: :not_found
  end

  def entrada_trabalho_params
    params.require(:entrada_trabalho).permit(:relatorio_diario_id, :quadro_kanban_id, :reportado_por, :o_que_foi_feito, :o_que_sera_feito)
  end
end
