class Movie < ActiveRecord::Base
    
#   def self.getRatings  
#     select("DISTINCT rating").map(&:rating)
#   end
   def self.getRatings

############################################################
     ratings = ['G','PG','PG-13','R']

     return ratings
    
    #This is working need to clean up with do
##############################################################
  
        
   end



 
end
