class Api::V1::ReunioesController < ApplicationController
  before_action :set_reuniao, only: [:show, :update, :destroy]

  # GET /api/v1/reunioes
  def index
    @reunioes = Reuniao.all
    render json: @reunioes, status: :ok
  rescue StandardError => e
    render json: { error: 'Erro ao buscar reuniões', details: e.message }, status: :internal_server_error
  end

  # GET /api/v1/reunioes/:id
  def show
    render json: @reuniao, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Reunião não encontrada' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao buscar reunião', details: e.message }, status: :internal_server_error
  end

  # POST /api/v1/reunioes
  def create
    @reuniao = Reuniao.new(reuniao_params)
    if @reuniao.save
      render json: @reuniao, status: :created
    else
      render json: { errors: @reuniao.errors.full_messages }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: 'Erro ao criar reunião', details: e.message }, status: :internal_server_error
  end

  # PATCH/PUT /api/v1/reunioes/:id
  def update
    if @reuniao.update(reuniao_params)
      render json: @reuniao, status: :ok
    else
      render json: { errors: @reuniao.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Reunião não encontrada' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao atualizar reunião', details: e.message }, status: :internal_server_error
  end

  # DELETE /api/v1/reunioes/:id
  def destroy
    @reuniao.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Reunião não encontrada' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao deletar reunião', details: e.message }, status: :internal_server_error
  end

  private

  def set_reuniao
    @reuniao = Reuniao.find(params[:id])
  end

  def reuniao_params
    params.require(:reuniao).permit(:data_reuniao, :horario_previsto_inicio, :horario_previsto_fim, :horario_real_inicio, :horario_real_fim, :tema, :link_reuniao, :notas_pessoais, :facilitador, :id_sprint_id)
  end
end
