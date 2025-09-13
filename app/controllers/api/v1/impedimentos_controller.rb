class Api::V1::ImpedimentosController < ApplicationController
  before_action :set_impedimento, only: [:show, :update, :destroy]

  # GET /api/v1/impedimentos
  def index
    @impedimentos = Impedimento.all
    render json: @impedimentos, status: :ok
  rescue StandardError => e
    render json: { error: 'Erro ao buscar impedimentos', details: e.message }, status: :internal_server_error
  end

  # GET /api/v1/impedimentos/:id
  def show
    render json: @impedimento, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Impedimento não encontrado' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao buscar impedimento', details: e.message }, status: :internal_server_error
  end

  # POST /api/v1/impedimentos
  def create
    @impedimento = Impedimento.new(impedimento_params)
    if @impedimento.save
      render json: @impedimento, status: :created
    else
      render json: { errors: @impedimento.errors.full_messages }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: 'Erro ao criar impedimento', details: e.message }, status: :internal_server_error
  end

  # PATCH/PUT /api/v1/impedimentos/:id
  def update
    if @impedimento.update(impedimento_params)
      render json: @impedimento, status: :ok
    else
      render json: { errors: @impedimento.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Impedimento não encontrado' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao atualizar impedimento', details: e.message }, status: :internal_server_error
  end

  # DELETE /api/v1/impedimentos/:id
  def destroy
    @impedimento.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Impedimento não encontrado' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao deletar impedimento', details: e.message }, status: :internal_server_error
  end

  private

  def set_impedimento
    @impedimento = Impedimento.find(params[:id])
  end

  def impedimento_params
    params.require(:impedimento).permit(:id_entry_id, :descricao_impedimento, :status_impedimento, :categoria_impedimento, :responsavel_impedimento, :notas_resolucao)
  end
end
