class TagsController < ApplicationController
  def index
    tags = Tag.all
    render json: tags, each_serializer: TagsSerializer, adapter: :json, root: 'tags'
  end

  def create
    @record = Tag.new(tag_params)
    if @record.save
      render json: { tag: @record, message: 'Successfully created' }
    else
      render json: { message: @record.errors.full_messages.to_sentence }, status: 422
    end
  end

  def update
    @record = Tag.find_by(id: params[:id])
    if @record.update_attributes(tag_params)
      render json: { tag: @record, message: 'Successfully updated' }
    else
      render json: { message: @record.errors.full_messages.to_sentence }, status: 422
    end
  end

  def destroy
    @record = Tag.find_by(id: params[:id])
    @record.destroy
    UserTag.where(tag_id: @record.id).destroy_all
    render json: { message: 'Successfully deleted' }
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
