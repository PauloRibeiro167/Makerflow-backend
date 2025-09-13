class Api::V1::SprintsController < ApplicationController
  before_action :set_sprint, only: [:show, :update, :destroy]

  def index
    @sprints = Sprint.all
    render json: @sprints
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def show
    render json: @sprint
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Sprint não encontrada' }, status: :not_found
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def create
    @sprint = Sprint.new(sprint_params)
    if @sprint.save
      render json: @sprint, status: :created
    else
      render json: { errors: @sprint.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def update
    if @sprint.update(sprint_params)
      render json: @sprint
    else
      render json: { errors: @sprint.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def destroy
    @sprint.destroy
    head :no_content
  rescue ActiveRecord::RecordNotDestroyed => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def set_sprint
    @sprint = Sprint.find(params[:id])
  end

  def sprint_params
    params.require(:sprint).permit(:nome_sprint, :data_inicio, :data_fim, :objetivo_sprint)
  end
end
