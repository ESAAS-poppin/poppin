class Event < ApplicationRecord
  belongs_to :venue
  has_one :time, :date, :address, :name, :attire, :price_range, :description, :id, :duration, :location, :image_url
end