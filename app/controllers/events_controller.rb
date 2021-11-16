class EventsController < ApplicationController
    skip_before_action :require_login
    before_action :filter_events, only: [:index, :display_full_map]
    

    def index
    end

    def display_full_map
      @events = @events.map{|event| [event.name, event.address, event.latitude, event.longitude]}
    end


    def show
      id = params[:id]
      event = Event.find_by_id(id)
      if event == nil
        redirect_to events_path(), :flash => { :error => "Event not found." }
      else
        @event = event
        if session and session[:user_id]
          @friends_who_saved = User.followed_by(session[:user_id]).that_saved_event(@event.id)
        else
          @friends_who_saved = []
        end
      end
    end

    def new
      @event = Event.new
      @venue_id = params[:venue_id]
      @venue_admin_id = params[:venue_admin_id]

    end

    def create
      @venue = Venue.find_by(id: params[:venue_id])
      @venue_admin = VenueAdmin.find_by(id: params[:venue_admin_id])

      event_params = params.require(:event).permit(:name, :description, :datetime, :duration, :date)
      additional_params = {:venue_id => params[:venue_id], :attire => params[:attire], :price_range => params[:price_range],
        :event_type => params[:event_type], :latitude => @venue.latitude, :longitude => @venue.longitude}
      all_params = event_params.merge(additional_params)
      @event = Event.create(all_params)
      if @event.valid? 
          redirect_to @event
      end
    end


    private

    def filter_events
      @events = Event.all
      @events = @events.with_price_range(params[:filter_price_range]) if params[:filter_price_range].present? 
      @events = @events.with_event_type(params[:filter_event_type]) if params[:filter_event_type].present?      
      @events = @events.with_attire(params[:filter_attire]) if params[:filter_attire].present?  
      @events = @events.search(params[:search]) if params[:search].present?
      @events = @events.saved_by(params[:saved_by].split(',')) if params[:saved_by] != nil
    end
  end
  