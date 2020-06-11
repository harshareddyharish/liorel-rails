class UserTagsController < ApplicationController
  def destroy
    @record = UserTag.find_by(id: params[:id])
    @record.destroy
    render json: { message: 'Successfully deleted' }
  end
end
