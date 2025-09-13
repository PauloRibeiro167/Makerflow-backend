class Api::V1::CelulasController < ApplicationController
  before_action :set_celula, only: [:show, :update, :destroy]
  before_action :set_setor, only: [:create]

  def index
    if params[:setor_id]
      @celulas = Celula.where(setor_id: params[:setor_id])
    else
      @celulas = Celula.all
    end
    render json: @celulas
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def show
    render json: @celula
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Célula não encontrada' }, status: :not_found
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def create
    @celula = @setor.celulas.build(celula_params)
    if @celula.save
      render json: @celula, status: :created
    else
      render json: { errors: @celula.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def update
    if @celula.update(celula_params)
      render json: @celula
    else
      render json: { errors: @celula.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def destroy
    @celula.destroy
    head :no_content
  rescue ActiveRecord::RecordNotDestroyed => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def set_celula
    @celula = Celula.find(params[:id])
  end

  def set_setor
    @setor = Setor.find(params[:setor_id]) if params[:setor_id]
  end

  def celula_params
    params.require(:celula).permit(:nome_celula, :setor_id)
  end
end
