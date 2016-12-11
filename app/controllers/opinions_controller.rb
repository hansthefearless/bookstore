class OpinionsController < ApplicationController
   def create
     @book = Book.find(opinion_params[:book_id])
     puts opinion_params[:book_id]
     @opinion = Opinion.create("customer": Customer.find(opinion_params[:customer_id]), "book": Book.find(opinion_params[:book_id]), "text": opinion_params[:text], "score": opinion_params[:score])

     redirect_to book_path(@book)
   end

   private
     def opinion_params
      params.require(:opinion).permit(:customer_id, :book_id, :score, :text)
     end
end
