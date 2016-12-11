class OpinionsController < ApplicationController
   def create
     @book = Book.find(opinion_params[:book_id])
     if opinion_params[:customer_id] != session[:customer_id]
       redirect_to book_path(@book)
     end
     @opinion = Opinion.create(opinion_params)

     redirect_to book_path(@book)
   end

   private
     def opinion_params
      params.require(:opinion).permit(:customer_id, :book_id, :score, :text)
     end
end
