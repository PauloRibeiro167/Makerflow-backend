class Api::V1::UnidadesController < ApplicationController
  before_action :set_unidade, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from StandardError, with: :internal_server_error

  # GET /api/v1/unidades
  def index
    begin
      unidades = Unidade.all
      render json: { data: unidades }, status: :ok
    rescue => e
      render json: { error: 'Erro ao buscar unidades' }, status: :internal_server_error
    end
  end

  # GET /api/v1/unidades/1
  def show
    render json: { data: @unidade }, status: :ok
  end

  # POST /api/v1/unidades
  def create
    unidade = Unidade.new(unidade_params)

    if unidade.save
      render json: { data: unidade, message: 'Unidade criada com sucesso' }, status: :created
    else
      render json: { errors: unidade.errors }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors }, status: :unprocessable_entity
  end

  # PATCH/PUT /api/v1/unidades/1
  def update
    if @unidade.update(unidade_params)
      render json: { data: @unidade, message: 'Unidade atualizada com sucesso' }, status: :ok
    else
      render json: { errors: @unidade.errors }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors }, status: :unprocessable_entity
  end

  # DELETE /api/v1/unidades/1
  def destroy
    begin
      @unidade.destroy!
      head :no_content
    rescue ActiveRecord::RecordNotDestroyed => e
      render json: { error: 'Não foi possível remover a unidade' }, status: :unprocessable_entity
    rescue => e
      render json: { error: 'Erro interno do servidor' }, status: :internal_server_error
    end
  end

  private

  def set_unidade
    @unidade = Unidade.find(params[:id])
  end

  def unidade_params
    params.require(:unidade).permit(:nome_unidade)
  end

  def record_not_found
    render json: { error: 'Unidade não encontrada' }, status: :not_found
  end

  def record_invalid(exception)
    render json: { errors: exception.record.errors }, status: :unprocessable_entity
  end

  def internal_server_error
    render json: { error: 'Erro interno do servidor' }, status: :internal_server_error
  end
end
