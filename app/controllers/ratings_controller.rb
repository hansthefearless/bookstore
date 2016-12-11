class RatingsController < ApplicationController
   def create
     puts params
     @opinion = Opinion.find(rating_params[:opinion_id])
     @book = Book.find(@opinion[:book_id])

     if @opinion[:customer_id] == session[:customer_id]
       flash[:danger] = "You cannot rate your own opinion!"
       redirect_to book_path(@book) and return
     end

     @rating = Rating.new(rating_params)

     redirect_to book_path(@book)
   end

   private
     def rating_params
      params.require(:rating).permit(:customer_id, :opinion_id, :usefulness)
     end
end
