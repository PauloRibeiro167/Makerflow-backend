class Api::V1::AtivosProjetoController < ApplicationController
  before_action :set_ativo_projeto, only: [:show, :update, :destroy]
  before_action :set_quadro_kanban, only: [:create]

  def index
    if params[:quadro_kanban_id]
      @ativos_projeto = AtivoProjeto.where(quadro_kanban_id: params[:quadro_kanban_id])
    else
      @ativos_projeto = AtivoProjeto.all
    end
    render json: @ativos_projeto
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def show
    render json: @ativo_projeto
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Ativo do projeto não encontrado' }, status: :not_found
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def create
    @ativo_projeto = @quadro_kanban.ativos_projeto.build(ativo_projeto_params)
    if @ativo_projeto.save
      render json: @ativo_projeto, status: :created
    else
      render json: { errors: @ativo_projeto.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def update
    if @ativo_projeto.update(ativo_projeto_params)
      render json: @ativo_projeto
    else
      render json: { errors: @ativo_projeto.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  def destroy
    @ativo_projeto.destroy
    head :no_content
  rescue ActiveRecord::RecordNotDestroyed => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def set_ativo_projeto
    @ativo_projeto = AtivoProjeto.find(params[:id])
  end

  def set_quadro_kanban
    @quadro_kanban = QuadroKanban.find(params[:quadro_kanban_id]) if params[:quadro_kanban_id]
  end

  def ativo_projeto_params
    params.require(:ativo_projeto).permit(:quadro_kanban_id, :tipo_ativo, :caminho_ativo, :descricao_ativo)
  end
end
