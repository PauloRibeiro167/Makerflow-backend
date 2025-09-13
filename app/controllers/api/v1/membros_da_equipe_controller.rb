class Api::V1::MembrosDaEquipeController < ApplicationController
  before_action :set_membro_da_equipe, only: [:show, :update, :destroy]
  before_action :set_equipe, only: [:create]

  def index
    if params[:equipe_id]
      @membros_da_equipe = MembroDaEquipe.where(equipe_id: params[:equipe_id])
    else
      @membros_da_equipe = MembroDaEquipe.all
    end
    render json: @membros_da_equipe
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def show
    render json: @membro_da_equipe
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Membro da equipe não encontrado' }, status: :not_found
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def create
    @membro_da_equipe = @equipe.membros_da_equipe.build(membro_da_equipe_params)
    if @membro_da_equipe.save
      render json: @membro_da_equipe, status: :created
    else
      render json: { errors: @membro_da_equipe.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def update
    if @membro_da_equipe.update(membro_da_equipe_params)
      render json: @membro_da_equipe
    else
      render json: { errors: @membro_da_equipe.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def destroy
    @membro_da_equipe.destroy
    head :no_content
  rescue ActiveRecord::RecordNotDestroyed => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def set_membro_da_equipe
    @membro_da_equipe = MembroDaEquipe.find(params[:id])
  end

  def set_equipe
    @equipe = Equipe.find(params[:equipe_id]) if params[:equipe_id]
  end

  def membro_da_equipe_params
    params.require(:membro_da_equipe).permit(:usuario_id, :equipe_id, :data_adesao)
  end
end
