class Api::V1::AttachmentsController < ApplicationController
  before_action :set_attachment, only: [:show, :update, :destroy]

  # GET /api/v1/attachments
  def index
    @attachments = Attachment.all
    render json: @attachments, status: :ok
  rescue StandardError => e
    render json: { error: 'Erro ao buscar anexos', details: e.message }, status: :internal_server_error
  end

  # GET /api/v1/attachments/:id
  def show
    render json: @attachment, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Anexo não encontrado' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao buscar anexo', details: e.message }, status: :internal_server_error
  end

  # POST /api/v1/attachments
  def create
    @attachment = Attachment.new(attachment_params)
    if @attachment.save
      render json: @attachment, status: :created
    else
      render json: { errors: @attachment.errors.full_messages }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: 'Erro ao criar anexo', details: e.message }, status: :internal_server_error
  end

  # PATCH/PUT /api/v1/attachments/:id
  def update
    if @attachment.update(attachment_params)
      render json: @attachment, status: :ok
    else
      render json: { errors: @attachment.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Anexo não encontrado' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao atualizar anexo', details: e.message }, status: :internal_server_error
  end

  # DELETE /api/v1/attachments/:id
  def destroy
    @attachment.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Anexo não encontrado' }, status: :not_found
  rescue StandardError => e
    render json: { error: 'Erro ao deletar anexo', details: e.message }, status: :internal_server_error
  end

  private

  def set_attachment
    @attachment = Attachment.find(params[:id])
  end

  def attachment_params
    params.require(:attachment).permit(:document_id, :task_id, :file_name, :file_path, :file_size, :uploaded_by_user_id)
  end
end
