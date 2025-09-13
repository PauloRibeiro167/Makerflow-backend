class Api::V1::AutomationsController < ApplicationController
  before_action :set_automation, only: [:show, :update, :destroy]

  # GET /api/v1/automations
  def index
    @automations = Automation.all
    render json: @automations, status: :ok
  rescue StandardError => e
    render json: { error: 'Erro ao buscar automações', details: e.message }, status: :internal_server_error
  end

  # GET /api/v1/automations/:id
  def show
    render json: @automation, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Automação não encontrada' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao buscar automação', details: e.message }, status: :internal_server_error
  end

  # POST /api/v1/automations
  def create
    @automation = Automation.new(automation_params)
    if @automation.save
      render json: @automation, status: :created
    else
      render json: { errors: @automation.errors.full_messages }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: 'Erro ao criar automação', details: e.message }, status: :internal_server_error
  end

  # PATCH/PUT /api/v1/automations/:id
  def update
    if @automation.update(automation_params)
      render json: @automation, status: :ok
    else
      render json: { errors: @automation.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Automação não encontrada' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao atualizar automação', details: e.message }, status: :internal_server_error
  end

  # DELETE /api/v1/automations/:id
  def destroy
    @automation.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Automação não encontrada' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao deletar automação', details: e.message }, status: :internal_server_error
  end

  private

  def set_automation
    @automation = Automation.find(params[:id])
  end

  def automation_params
    params.require(:automation).permit(:name, :description, :trigger_event, :trigger_data, :action_type, :action_data, :is_active)
  end
end
