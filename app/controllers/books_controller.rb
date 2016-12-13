class BooksController < ApplicationController
   def add_to_cart
     book_id = params[:book]
     if add(book_id)
       flash[:success] = "Book added to cart"
     else
       flash[:danger] = "Book has already been added to cart"
     end
     redirect_back_to
   end

   def cart
     @cart = populate_cart
   end

   def subtract_from_qty
     book_id = params[:book]
     subtract_qty(book_id)
     redirect_to cart_path
   end

   def add_to_qty
     book_id = params[:book]
     add_qty(book_id)
     redirect_to cart_path
   end

   def back
     redirect_back_to
   end

   def delete_from_cart
     delete(params[:book])
     flash[:success] = "Book deleted from cart"
     redirect_to cart_path
   end

   def index
     store_location
     @books = Book.all
   end

   def new
     @book = Book.new
   end

   def show
     if params[:limit] == nil
       n = 5
     else
       if params[:limit].to_f < 1
         n = 5
       else
         n = params[:limit]
       end
     end
     @book = Book.find(params[:id])
     @opinions = Opinion.left_outer_joins(:ratings).where(
     book_id: params[:id]).select(
     "opinions.*, ratings.usefulness, avg(ratings.usefulness) as avg_rating").group(
     "opinions.id").order(
     "avg(ratings.usefulness) DESC").limit(n)
     @opinion = Opinion.new
     @rating = Rating.new
   end

   def edit
     @book = Book.find(params[:id])
   end

   def create
     @book = Book.new(book_params)

     if @book.save
       redirect_to action: 'index'
     else
       render 'new'
     end
   end

   def update
     @book = Book.find(params[:id])

     if @book.update(book_params)
       redirect_to action: 'index'
     else
       render 'edit'
     end
   end

   def destroy
     Book.find(params[:id]).destroy
     flash[:success] = "Book deleted"
     redirect_to books_path
   end

   def search
   end

   def find
     store_location
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
          return Book.left_outer_joins(opinions: :ratings).select(
          "books.*, avg(ratings.usefulness) as avg_rating").where(
          "books.copies > 0").where(
          "books.title LIKE ? AND books.authors LIKE ? AND books.publisher LIKE ? AND books.subject LIKE ?", "%#{title}%", "%#{authors}%", "%#{publisher}%", "%#{subject}%").group(
          "books.id")
        end
        if params[:sort] == 'year'
          return Book.left_outer_joins(opinions: :ratings).select(
          "books.*, avg(ratings.usefulness) as avg_rating").where(
          "books.copies > 0").where(
          "books.title LIKE ? AND books.authors LIKE ? AND books.publisher LIKE ? AND books.subject LIKE ?", "%#{title}%", "%#{authors}%", "%#{publisher}%", "%#{subject}%").group(
          "books.id").order(year: :desc)
        end
        if params[:sort] == 'rating'
          return Book.left_outer_joins(opinions: :ratings).select(
          "books.*, ratings.usefulness, avg(ratings.usefulness) as avg_rating").where(
          "books.copies > 0").where(
          "books.title LIKE ? AND books.authors LIKE ? AND books.publisher LIKE ? AND books.subject LIKE ?", "%#{title}%", "%#{authors}%", "%#{publisher}%", "%#{subject}%").group(
          "books.id").order("avg(ratings.usefulness) DESC")
        end
      end


end
