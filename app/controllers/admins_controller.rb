class AdminsController < ApplicationController
   def show
     @admin = Admin.find(params[:id])

     if params[:limit] == nil
       m = 5
     else
       m = params[:limit]
     end

     start_of_month = Time.now.beginning_of_month()

     @books = Book.joins("INNER JOIN order_books ON order_books.book_id = books.id").joins(
     "INNER JOIN orders ON orders.id = order_books.order_id").where(
     "orders.created_at > ?", start_of_month).group(
     "books.id").select("books.id, books.title, order_books.copies, sum(order_books.copies) as sold").order(
     "sum(order_books.copies) DESC").limit(m)

     @authors = Book.joins("INNER JOIN order_books ON order_books.book_id = books.id").joins(
     "INNER JOIN orders ON orders.id = order_books.order_id").where(
     "orders.created_at > ?", start_of_month).group(
     "books.authors").select("books.authors, order_books.copies, sum(order_books.copies) as sold").order(
     "sum(order_books.copies) DESC").limit(m)

     @publishers = Book.joins("INNER JOIN order_books ON order_books.book_id = books.id").joins(
     "INNER JOIN orders ON orders.id = order_books.order_id").where(
     "orders.created_at > ?", start_of_month).group(
     "books.publishers").select("books.publishers, order_books.copies, sum(order_books.copies) as sold").order(
     "sum(order_books.copies) DESC").limit(m)
   end

   def login
   end

   def destroy
     log_out_admin
     redirect_to root_url
   end

   def create
     admin = Admin.find_by(login: params[:admin][:login], password: params[:admin][:password])
     if admin
       log_in_admin admin
       redirect_to admin
     else
       flash.now[:danger] = 'Invalid login/password combination'
       render 'login'
     end
   end

   def new
   end


end
