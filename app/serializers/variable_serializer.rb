class VariableSerializer < ActiveModel::Serializer
  attributes :id,:no,:name,:vtype,:value
  belongs_to :events
end
