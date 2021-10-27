class EventsController < ApplicationController

    # def show
    #   id = params[:id] # retrieve movie ID from URI route
    #   @movie = Movie.find(id) # look up movie by unique ID
    #   # will render app/views/movies/show.<extension> by default
    # end
  
    def index
      all_events = Event.all
      # get venue name from id
      all_events.each do |evt|
        ven_id = evt.venue_id
        if ven_id != nil && ven_id != ''
          evt_ven = Venue.where(id: ven_id)
          if evt_ven != nil
            evt.venue_name = evt_ven.first.name
          end
        end
      end
      @events = all_events
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
  