class RatingsController < ApplicationController
   def create
     @book = Book.find(params[:book_id])
     @opinion = Opinion.find(params[:opinion_id])

     if @opinion.customer_id == rating_params[:customer_id]:
       redirect_to book_path(@book)

     @rating = @opinion.ratings.create(rating_params)

     redirect_to book_path(@book)
   end

   private
     def rating_params
      params.require(:rating).permit(:customer_id, :opinion_id, :usefulness)
     end
end
