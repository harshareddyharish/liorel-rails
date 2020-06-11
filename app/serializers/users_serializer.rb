class UsersSerializer < ActiveModel::Serializer
	attributes :id, :first_name, :last_name, :address, :city, :state, :zip, :email, :tags, :active, :updated_at
	def tags
		object.tags.pluck(:tag_id)
	end
end