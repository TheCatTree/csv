class EventSerializer < ActiveModel::Serializer
  attributes :id ,:time
  belongs_to :pair
  has_many :variables
end
