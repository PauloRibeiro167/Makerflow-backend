class Api::V1::PautaReuniaoController < ApplicationController
  before_action :set_pauta_reuniao, only: [:show, :update, :destroy]

  # GET /api/v1/pauta_reuniao
  def index
    @pauta_reuniaos = PautaReuniao.all
    render json: @pauta_reuniaos, status: :ok
  rescue StandardError => e
    render json: { error: 'Erro ao buscar pautas da reunião', details: e.message }, status: :internal_server_error
  end

  # GET /api/v1/pauta_reuniao/:id
  def show
    render json: @pauta_reuniao, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Pauta da reunião não encontrada' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao buscar pauta da reunião', details: e.message }, status: :internal_server_error
  end

  # POST /api/v1/pauta_reuniao
  def create
    @pauta_reuniao = PautaReuniao.new(pauta_reuniao_params)
    if @pauta_reuniao.save
      render json: @pauta_reuniao, status: :created
    else
      render json: { errors: @pauta_reuniao.errors.full_messages }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: 'Erro ao criar pauta da reunião', details: e.message }, status: :internal_server_error
  end

  # PATCH/PUT /api/v1/pauta_reuniao/:id
  def update
    if @pauta_reuniao.update(pauta_reuniao_params)
      render json: @pauta_reuniao, status: :ok
    else
      render json: { errors: @pauta_reuniao.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Pauta da reunião não encontrada' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao atualizar pauta da reunião', details: e.message }, status: :internal_server_error
  end

  # DELETE /api/v1/pauta_reuniao/:id
  def destroy
    @pauta_reuniao.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Pauta da reunião não encontrada' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao deletar pauta da reunião', details: e.message }, status: :internal_server_error
  end

  private

  def set_pauta_reuniao
    @pauta_reuniao = PautaReuniao.find(params[:id])
  end

  def pauta_reuniao_params
    params.require(:pauta_reuniao).permit(:id_reuniao_id, :topico_item, :anotacoes_discussao, :decisoes_tomadas, :id_kanban_id)
  end
end
