class UsersController < ApplicationController
  def index
    users = User.includes(:user_tags).all
    render json: users, each_serializer: UsersSerializer, adapter: :json, root: 'users'
  end

  def show
    user = User.find(params[:id])
    render json: user, serializer: UsersSerializer, adapter: :json, root: 'user'
  end

  def create
    user_params[:password] = SecureRandom.hex(10)
    @record = User.new(user_params)
    if @record.save
      create_user_tags(@record) if params[:user][:tags]
      render json: { user: @record, message: 'Successfully created' }
    else
      render json: { message: @record.errors.full_messages.to_sentence }, status: 422
    end
  end

  def update
    @record = User.find_by(id: params[:id])
    if @record.update_attributes(user_params)
      create_user_tags(@record) if params[:user][:tags]
      update_password(@record) if params[:password].present?
      render json: { user: @record, message: 'Successfully updated' }
    else
      render json: { message: @record.errors.full_messages.to_sentence }, status: 422
    end
  end

  def destroy
    @record = User.find_by(id: params[:id])
    @record.destroy
    render json: { message: 'Successfully deleted' }
  end

  private

  def create_user_tags(user)
    params[:user][:tags].each do |tag_id|
      user.user_tags.find_or_create_by(tag_id: tag_id)
    end
    user.user_tags.where.not(tag_id: params[:user][:tags]).destroy_all
  end

  def update_password(user)
    user.password = params[:password]
    user.save!
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :address, :city, :state, :zip, :active)
  end
end
