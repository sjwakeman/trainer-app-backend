class UserSerializer < ActiveModel::Serializer
  has_many :created_clients, class_name: "Client" #ALIAS RELATIONSHIP for has_many :clients
  has_many :training_sessions
  has_many :clients, through: :training_sessions #LAST RELATIONSHIP IS CALLED :clients
  attributes :id, :name, :password, :email, :image, :uid
end
