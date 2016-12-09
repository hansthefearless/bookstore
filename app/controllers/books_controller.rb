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
     redirect_to book_path(@book)
   end

   def update
     @book = Book.find(params[:id])

     @book.update(book_params)
     redirect_to book_path(@book)
   end

   def search
     @books ||= find_books
   end

   private
      def book_params
        params.require(:book).permit(:ISBN, :title, :authors, :copies, :subject, :year, :price, :publisher, :keywords, :format, :thumbnail)
      end

      def find_books
        Book.find(:all, :conditions => conditions)
      end

      def title_conditions
        ["books.title LIKE ?", "%#{title}%"] unless title.blank?
      end

      def authors_conditions
        ["books.authors LIKE ?", "%#{authors}%"] unless authors.blank?
      end

      def publisher_conditions
        ["books.publisher LIKE ?", "%#{publisher}%"] unless publisher.blank?
      end

      def subject_conditions
        ["products.subject = ?", subject] unless subject.blank?
      end

      def conditions
        [conditions_clauses.join(' AND '), *conditions_options]
      end

      def conditions_clauses
        conditions_parts.map { |condition| condition.first }
      end

      def conditions_options
        conditions_parts.map { |condition| condition[1..-1] }.flatten
      end

      def conditions_parts
        private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
      end

end
