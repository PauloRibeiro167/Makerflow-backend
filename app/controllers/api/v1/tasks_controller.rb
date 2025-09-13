class Api::V1::TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]
  before_action :set_quadro_kanban, only: [:create]

  def index
    if params[:quadro_kanban_id]
      @tasks = Task.where(quadro_kanban_id: params[:quadro_kanban_id])
    else
      @tasks = Task.all
    end
    render json: @tasks
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def show
    render json: @task
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Tarefa não encontrada' }, status: :not_found
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def create
    @task = @quadro_kanban.tasks.build(task_params)
    if @task.save
      render json: @task, status: :created
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def destroy
    @task.destroy
    head :no_content
  rescue ActiveRecord::RecordNotDestroyed => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def set_quadro_kanban
    @quadro_kanban = QuadroKanban.find(params[:quadro_kanban_id]) if params[:quadro_kanban_id]
  end

  def task_params
    params.require(:task).permit(:title, :description, :priority, :status, :start_date, :due_date, :completed_at, :quadro_kanban_id, :parent_task_id, :is_macro_task, :user_id, :estimated_effort, :assignee_id)
  end
end
