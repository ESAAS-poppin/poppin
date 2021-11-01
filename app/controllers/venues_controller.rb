class VenuesController < ApplicationController
    def index
      @venues = Venue.all
    end

    def show
      id = params[:id]
      venue = Venue.find_by_id(id)
      @venue_events = venue.events.where('date >= ?', DateTime.now)
      if venue == nil
        redirect_to venues_path(), :flash => { :error => "Venue not found." }
      else
        @venue = venue
      end
    end
  end
  