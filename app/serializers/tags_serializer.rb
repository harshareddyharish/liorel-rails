class TagsSerializer < ActiveModel::Serializer
	attributes :id, :name, :created_at, :updated_at, :associated_users
	def associated_users
		object.users.pluck(:name)
	end
end