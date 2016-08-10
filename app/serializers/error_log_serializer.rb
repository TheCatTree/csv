class ErrorLogSerializer < ActiveModel::Serializer
  attributes :id, :name
  
  has_many :pairs
  has_many :events, through: :pairs
  has_many :variables, through: :events
  belongs_to :user
  
end
