class Pair < ActiveRecord::Base
  belongs_to :error_logs
  has_many :events
end
