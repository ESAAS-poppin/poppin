class EventsController < ApplicationController

    def index
      @events = Event.all
      @events = @events.with_price_range(params[:filter_price_range]) if params[:filter_price_range].present? 
      @events = @events.with_event_type(params[:filter_event_type]) if params[:filter_event_type].present?      
      @events = @events.with_attire(params[:filter_attire]) if params[:filter_attire].present?  
      @events = @events.search(params[:search]) if params[:search].present?
      @events = @events.saved_by(params[:saved_by]) if params[:saved_by].present?
    end

    def new
      @event = Event.new
    end

    def show
      id = params[:id]
      event = Event.find_by_id(id)
      if event == nil
        redirect_to events_path(), :flash => { :error => "Event not found." }
      else
        @event = event
      end
    end
  end
  