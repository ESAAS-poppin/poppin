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

    def filter(filter_list)
      
      filter_list.each do 
        @events = Event.filter(filter_list)
      end
      event = @events
      if event.nil?
        redirect_to events_path(), :flash => { :error => "No events with those criteria." }
      end
      @events
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
    # def movie_params
    #   params.require(:movie).permit(:title, :rating, :description, :release_date, :director)
    # end
  end
  