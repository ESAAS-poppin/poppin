class EventsController < ApplicationController
    def index
      byebug
      if params[:saved_by]
        @events = Event.saved_by params[:saved_by]
        
      else
        @events = Event.all
      end
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
  
    # def new
    #   # default: render 'new' template
    # end
  
    # def create
    #   @movie = Movie.create!(movie_params)
    #   flash[:notice] = "#{@movie.title} was successfully created."
    #   redirect_to movies_path
    # end
  
    # def edit
    #   @movie = Movie.find params[:id]
    # end
    
    # def similar
    #   movie = Movie.find params[:id]
    #   director = movie.director
    #   if director == nil || director == ""
    #     flash[:notice] = "'#{movie.title}' has no director info"
    #     redirect_to movies_path
    #   end
    #   @movies = Movie.where(director: director)
    # end
  
    # def update
    #   @movie = Movie.find params[:id]
    #   @movie.update_attributes!(movie_params)
    #   flash[:notice] = "#{@movie.title} was successfully updated."
    #   redirect_to movie_path(@movie)
    # end
  
    # def destroy
    #   @movie = Movie.find(params[:id])
    #   @movie.destroy
    #   flash[:notice] = "Movie '#{@movie.title}' deleted."
    #   redirect_to movies_path
    # end
  
    # private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.

    def event_params
      # params.permit(:saved_by)
    end
  end
  