class PairSerializer < ActiveModel::Serializer
  attributes :id,:level,:symbol,:vamount
    belongs_to :error_logs
  has_many :events
end
