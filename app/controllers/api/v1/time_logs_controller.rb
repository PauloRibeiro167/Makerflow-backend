class Api::V1::TimeLogsController < ApplicationController
  before_action :set_time_log, only: [:show, :update, :destroy]

  # GET /api/v1/time_logs
  def index
    @time_logs = TimeLog.all
    render json: @time_logs, status: :ok
  rescue StandardError => e
    render json: { error: 'Erro ao buscar logs de tempo', details: e.message }, status: :internal_server_error
  end

  # GET /api/v1/time_logs/:id
  def show
    render json: @time_log, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Log de tempo não encontrado' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao buscar log de tempo', details: e.message }, status: :internal_server_error
  end

  # POST /api/v1/time_logs
  def create
    @time_log = TimeLog.new(time_log_params)
    if @time_log.save
      render json: @time_log, status: :created
    else
      render json: { errors: @time_log.errors.full_messages }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: 'Erro ao criar log de tempo', details: e.message }, status: :internal_server_error
  end

  # PATCH/PUT /api/v1/time_logs/:id
  def update
    if @time_log.update(time_log_params)
      render json: @time_log, status: :ok
    else
      render json: { errors: @time_log.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Log de tempo não encontrado' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao atualizar log de tempo', details: e.message }, status: :internal_server_error
  end

  # DELETE /api/v1/time_logs/:id
  def destroy
    @time_log.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Log de tempo não encontrado' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao deletar log de tempo', details: e.message }, status: :internal_server_error
  end

  private

  def set_time_log
    @time_log = TimeLog.find(params[:id])
  end

  def time_log_params
    params.require(:time_log).permit(:task_id, :user_id, :hours_logged, :description, :log_date)
  end
end
