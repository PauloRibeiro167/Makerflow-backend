class Api::V1::SetoresController < ApplicationController
  before_action :set_setor, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from StandardError, with: :internal_server_error

  # GET /api/v1/setores
  def index
    begin
      setores = Setor.includes(:unidade).all
      render json: { data: setores }, status: :ok
    rescue => e
      render json: { error: 'Erro ao buscar setores' }, status: :internal_server_error
    end
  end

  # GET /api/v1/setores/1
  def show
    render json: { data: @setor }, status: :ok
  end

  # POST /api/v1/setores
  def create
    setor = Setor.new(setor_params)

    if setor.save
      render json: { data: setor, message: 'Setor criado com sucesso' }, status: :created
    else
      render json: { errors: setor.errors }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors }, status: :unprocessable_entity
  end

  # PATCH/PUT /api/v1/setores/1
  def update
    if @setor.update(setor_params)
      render json: { data: @setor, message: 'Setor atualizado com sucesso' }, status: :ok
    else
      render json: { errors: @setor.errors }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors }, status: :unprocessable_entity
  end

  # DELETE /api/v1/setores/1
  def destroy
    begin
      @setor.destroy!
      head :no_content
    rescue ActiveRecord::RecordNotDestroyed => e
      render json: { error: 'Não foi possível remover o setor' }, status: :unprocessable_entity
    rescue => e
      render json: { error: 'Erro interno do servidor' }, status: :internal_server_error
    end
  end

  private

  def set_setor
    @setor = Setor.find(params[:id])
  end

  def setor_params
    params.require(:setor).permit(:nome_setor, :unidade_id)
  end

  def record_not_found
    render json: { error: 'Setor não encontrado' }, status: :not_found
  end

  def record_invalid(exception)
    render json: { errors: exception.record.errors }, status: :unprocessable_entity
  end

  def internal_server_error
    render json: { error: 'Erro interno do servidor' }, status: :internal_server_error
  end
end
