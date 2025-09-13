class Api::V1::QuadroKanbanController < ApplicationController
  before_action :set_quadro_kanban, only: [:show, :update, :destroy]

  def index
    @quadro_kanbans = QuadroKanban.all
    render json: @quadro_kanbans
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def show
    render json: @quadro_kanban
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Quadro Kanban não encontrado' }, status: :not_found
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def create
    @quadro_kanban = QuadroKanban.new(quadro_kanban_params)
    if @quadro_kanban.save
      render json: @quadro_kanban, status: :created
    else
      render json: { errors: @quadro_kanban.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def update
    if @quadro_kanban.update(quadro_kanban_params)
      render json: @quadro_kanban
    else
      render json: { errors: @quadro_kanban.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def destroy
    @quadro_kanban.destroy
    head :no_content
  rescue ActiveRecord::RecordNotDestroyed => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def set_quadro_kanban
    @quadro_kanban = QuadroKanban.find(params[:id])
  end

  def quadro_kanban_params
    params.require(:quadro_kanban).permit(:titulo_tarefa, :descricao, :status_tarefa, :data_vencimento, :data_inicio, :data_prioridade, :tipo_tarefa, :responsavel, :comentarios)
  end
end
