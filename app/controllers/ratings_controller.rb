class RatingsController < ApplicationController
   def create
     @book = Book.find(params[:book_id])
     @opinion = Opinion.find(params[:opinion_id])
     @rating = @opinion.ratings.create(rating_params)

     redirect_to book_path(@book)
   end

   private
     def rating_params
      params.require(:rating).permit(:customer_id, :opinion_id, :usefulness)
     end
end
