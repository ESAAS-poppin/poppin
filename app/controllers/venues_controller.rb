class VenuesController < ApplicationController
  
    def index
      @venues = Venue.all
      @venues = @venues.with_price_range(params[:filter_price_range]) if params[:filter_price_range].present? 
      @venues = @venues.with_venue_type(params[:filter_venue_type]) if params[:filter_venue_type].present?      
      @venues = @venues.with_attire(params[:filter_attire]) if params[:filter_attire].present?  
      @venues = @venues.search(params[:search]) if params[:search].present?
    end

    def show
      id = params[:id]
      venue = Venue.find_by_id(id)
      if venue == nil
        redirect_to venues_path(), :flash => { :error => "Venue not found." }
      else
        @venue = venue
      end
    end
  end
  