class Api::V1::EquipesController < ApplicationController
  before_action :set_equipe, only: [:show, :update, :destroy]
  before_action :set_celula, only: [:create]

  def index
    if params[:celula_id]
      @equipes = Equipe.where(celula_id: params[:celula_id])
    else
      @equipes = Equipe.all
    end
    render json: @equipes
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def show
    render json: @equipe
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Equipe não encontrada' }, status: :not_found
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def create
    @equipe = @celula.equipes.build(equipe_params)
    if @equipe.save
      render json: @equipe, status: :created
    else
      render json: { errors: @equipe.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def update
    if @equipe.update(equipe_params)
      render json: @equipe
    else
      render json: { errors: @equipe.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def destroy
    @equipe.destroy
    head :no_content
  rescue ActiveRecord::RecordNotDestroyed => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def set_equipe
    @equipe = Equipe.find(params[:id])
  end

  def set_celula
    @celula = Celula.find(params[:celula_id]) if params[:celula_id]
  end

  def equipe_params
    params.require(:equipe).permit(:nome_equipe, :celula_id)
  end
end
