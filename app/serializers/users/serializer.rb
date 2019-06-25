class Users::Serializer < ActiveModel::Serializer
  attributes :id, :uid, :level
end