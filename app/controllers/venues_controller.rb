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
        # uncomment this code to get image
        #@client = GooglePlaces::Client.new(Rails.application.credentials.google_maps_api_key)
        #@google_venue = @client.spots(@venue.latitude, @venue.longitude, :name => @venue.name, :radius => 5)[0]
        #if not @google_venue.nil? and @google_venue.respond_to? :photos
        #  @image_url = @google_venue.photos[0].fetch_url(400) 
        #else
        #  @image_url = nil
        #end
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
    # def movie_params
    #   params.require(:movie).permit(:title, :rating, :description, :release_date, :director)
    # end
  end
  