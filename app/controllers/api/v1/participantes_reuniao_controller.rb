class Api::V1::ParticipantesReuniaoController < ApplicationController
  before_action :set_participante_reuniao, only: [:show, :update, :destroy]

  # GET /api/v1/participantes_reuniao
  def index
    @participantes_reuniao = ParticipanteReuniao.all
    render json: @participantes_reuniao, status: :ok
  rescue StandardError => e
    render json: { error: 'Erro ao buscar participantes da reunião', details: e.message }, status: :internal_server_error
  end

  # GET /api/v1/participantes_reuniao/:id
  def show
    render json: @participante_reuniao, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Participante da reunião não encontrado' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao buscar participante da reunião', details: e.message }, status: :internal_server_error
  end

  # POST /api/v1/participantes_reuniao
  def create
    @participante_reuniao = ParticipanteReuniao.new(participante_reuniao_params)
    if @participante_reuniao.save
      render json: @participante_reuniao, status: :created
    else
      render json: { errors: @participante_reuniao.errors.full_messages }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: 'Erro ao criar participante da reunião', details: e.message }, status: :internal_server_error
  end

  # PATCH/PUT /api/v1/participantes_reuniao/:id
  def update
    if @participante_reuniao.update(participante_reuniao_params)
      render json: @participante_reuniao, status: :ok
    else
      render json: { errors: @participante_reuniao.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Participante da reunião não encontrado' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao atualizar participante da reunião', details: e.message }, status: :internal_server_error
  end

  # DELETE /api/v1/participantes_reuniao/:id
  def destroy
    @participante_reuniao.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Participante da reunião não encontrado' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao deletar participante da reunião', details: e.message }, status: :internal_server_error
  end

  private

  def set_participante_reuniao
    @participante_reuniao = ParticipanteReuniao.find(params[:id])
  end

  def participante_reuniao_params
    params.require(:participante_reuniao).permit(:id_reuniao_id, :nome_membro, :papel)
  end
end
