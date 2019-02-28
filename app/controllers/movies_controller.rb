class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.getRatings
    
############# Reinitialize With Session Data #############    
    
    
    if params[:commit] == 'Refresh' && params[:ratings] == nil
      session[:ratings] = ''
    end

    if params[:goBack] == 'yes'
      @checkbox = session[:ratings]  
      params[:ratings] = @checkbox
      @savedSorted = session[:sort_by]
      params[:sort_by] = @savedSorted
    else 
      @checkbox = 'T' if @checkbox.nil?
    end
    
    
    
   
##############          End                ###############                            

############## Begin Title Filtering Logic ###############

      if params[:sort_by] == 'title' || params[:sort_by] == 'release_date'
        
        case params[:sort_by]
          when 'title'
             @movies = Movie.order(params[:sort_by])
             @title_header = 'hilite'
             
          when 'release_date'
            @movies = Movie.order(params[:sort_by])
            @release_date_header = 'hilite'
            
        end
       
        session[:sort_by] = params[:sort_by]
        
      else 
         @movies = Movie.all
      end

################### Begin Checkbox Logic ################### 
   
   if params[:ratings].present?
      @movies = Movie.where(rating: params[:ratings].keys)
      session[:ratings] = params[:ratings]
      @checkbox = session[:ratings]
      
      
      
   end
################### End Check Box Logic ################### 

     
     
  end
  
  
###########################################################
  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    sendTo_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    sendTo_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    sendTo_to movies_path
  end

end
