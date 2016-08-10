class Event < ActiveRecord::Base
    belongs_to :pair
    has_many :variables
end
