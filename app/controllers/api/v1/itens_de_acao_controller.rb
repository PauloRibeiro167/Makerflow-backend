class Api::V1::ItensDeAcaoController < ApplicationController
  before_action :set_item_de_acao, only: [:show, :update, :destroy]

  # GET /api/v1/itens_de_acao
  def index
    @itens_de_acao = ItemDeAcao.all
    render json: @itens_de_acao, status: :ok
  rescue StandardError => e
    render json: { error: 'Erro ao buscar itens de ação', details: e.message }, status: :internal_server_error
  end

  # GET /api/v1/itens_de_acao/:id
  def show
    render json: @item_de_acao, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Item de ação não encontrado' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao buscar item de ação', details: e.message }, status: :internal_server_error
  end

  # POST /api/v1/itens_de_acao
  def create
    @item_de_acao = ItemDeAcao.new(item_de_acao_params)
    if @item_de_acao.save
      render json: @item_de_acao, status: :created
    else
      render json: { errors: @item_de_acao.errors.full_messages }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: 'Erro ao criar item de ação', details: e.message }, status: :internal_server_error
  end

  # PATCH/PUT /api/v1/itens_de_acao/:id
  def update
    if @item_de_acao.update(item_de_acao_params)
      render json: @item_de_acao, status: :ok
    else
      render json: { errors: @item_de_acao.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Item de ação não encontrado' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao atualizar item de ação', details: e.message }, status: :internal_server_error
  end

  # DELETE /api/v1/itens_de_acao/:id
  def destroy
    @item_de_acao.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Item de ação não encontrado' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao deletar item de ação', details: e.message }, status: :internal_server_error
  end

  private

  def set_item_de_acao
    @item_de_acao = ItemDeAcao.find(params[:id])
  end

  def item_de_acao_params
    params.require(:item_de_acao).permit(:id_reuniao_id, :id_kanban_id, :descricao_acao, :responsavel, :data_prazo, :status)
  end
end
