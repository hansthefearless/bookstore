class BooksController < ApplicationController
   def index
     @books = Book.all
   end

   def new
     @book = Book.new
   end

   def show
     @book = Book.find(params[:id])
   end

   def edit
     @book = Book.find(params[:id])
   end

   def create
     @book = Book.new(book_params)

     @book.save
     redirect_to @book
   end

   def update
     @book = Book.find(params[:id])

     @book.update(book_params)
     redirect_to @book
   end

   private
     def book_params
       params.require(:book).permit(:ISBN, :title, :authors, :copies, :subject, :year, :price, :publisher, :keywords, :format, :thumbnail)
     end

end
