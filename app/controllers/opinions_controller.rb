class OpinionsController < ApplicationController
   def create
     @book = Book.find(params[:id])
     @opinion = @book.opinions.create(opinion_params)

     redirect_to book_path(@book)
   end

   private
     def opinion_params
      params.require(:opinion).permit(:customer_id, :book_id, :score, :text)
     end
end
