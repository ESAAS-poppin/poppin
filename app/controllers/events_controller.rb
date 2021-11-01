class EventsController < ApplicationController
    def index
      @events = Event.all
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
  