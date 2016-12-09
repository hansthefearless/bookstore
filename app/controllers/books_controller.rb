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

     if @book.save
       redirect_to book_path(@book)
     else
       render 'new'
     end
   end

   def update
     @book = Book.find(params[:id])

     if @book.update(book_params)
       redirect_to book_path(@book)
     else
       render 'edit'
     end
   end

   def search
   end

   def find
      @books ||= find_books
   end

   private
      def book_params
        params.require(:book).permit(:ISBN, :title, :authors, :copies, :subject, :year, :price, :publisher, :keywords, :format, :thumbnail)
      end

      def find_books
        title = params[:title]
        authors = params[:authors]
        publisher = params[:publisher]
        subject = params[:subject]

        if params[:sort] == 'none'
          return Book.where("books.title LIKE ? AND books.authors LIKE ? AND books.publisher LIKE ? AND books.subject LIKE ?", "%#{title}%", "%#{authors}%", "%#{publisher}%", "%#{subject}%")
        end
        if params[:sort] == 'year'
          return Book.where("books.title LIKE ? AND books.authors LIKE ? AND books.publisher LIKE ? AND books.subject LIKE ?", "%#{title}%", "%#{authors}%", "%#{publisher}%", "%#{subject}%").order(:year)
        end
        if params[:sort] == 'rating'
          return Book.left_outer_joins(opinions: :ratings).where("books.title LIKE ? AND books.authors LIKE ? AND books.publisher LIKE ? AND books.subject LIKE ?", "%#{title}%", "%#{authors}%", "%#{publisher}%", "%#{subject}%").select("books.*, avg(ratings.usefulness) as avg_rating").group("books.id").order("avg_rating DESC")
        end
      end

end
