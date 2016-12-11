class RatingsController < ApplicationController
   def create
     @opinion = Opinion.find(rating_params[:opinion_id])
     @book = Book.find(@opinion[:book_id])

     if @opinion[:customer_id] == session[:customer_id]
       flash[:danger] = "You cannot rate your own opinion!"
       redirect_to book_path(@book) and return
     end

     @rating = Rating.create("customer": Customer.find(rating_params[:customer_id]), "opinion": Opinion.find(rating_params[:opinion_id]), "usefulness": rating_params[:usefulness])

     redirect_to book_path(@book)
   end

   private
     def rating_params
      params.require(:rating).permit(:customer_id, :opinion_id, :usefulness)
     end
end
