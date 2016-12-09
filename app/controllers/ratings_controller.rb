class RatingsController < ApplicationController
   def create
     @rating = Rating.new(rating_params)

     @rating.save
     redirect_to @rating
   end
end
