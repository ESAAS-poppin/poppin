class Event < ApplicationRecord
  include Filterable
  attr_accessor :venue_name

  has_many :users, :through => :saved_events
  belongs_to :venue

  

end