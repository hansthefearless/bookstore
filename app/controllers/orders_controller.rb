class OrdersController < ApplicationController
   def index
     @orders = Order.all
   end

   def new
     @order = Order.new
   end

   def show
     @books = Book.joins("INNER JOIN order_books ON order_books.book_id = books.id").joins(
     "INNER JOIN orders ON orders.id = order_books.order_id").where(
     "orders.id = ?", params[:id])

     @order = Order.find(params[:id])

     @book_ids = []
     @books.each do |book|
       @book_ids << book[:id]
     end

     @recommended = Order.joins(
     "INNER JOIN order_books ON order_books.order_id = orders.id").joins(
     "INNER JOIN books ON books.id = order_books.book_id").where(
     customer_id: Customer.joins("INNER JOIN orders ON orders.customer_id = customers.id").joins(
     "INNER JOIN order_books ON order_books.order_id = orders.id").joins(
     "INNER JOIN books ON books.id = order_books.book_id").where(
     "customer_id != ?", session[:customer_id]).where(
     "books.id IN (?)", @book_ids).select("customer_id").distinct).select(
     "books.*, order_books.copies, sum(order_books.copies) as sold").where.not(
     "books.id IN (?)", @book_ids).group("books.id").order("sum(order_books.copies) DESC")
   end

   def edit
     @order = Order.find(params[:id])
   end

   def create
     ActiveRecord::Base.transaction do
       @order = Order.create("customer": Customer.find(session[:customer_id]), "status": "Pending")

       @order.save

       params[:cart].each do |book|
         storebook = Book.lock.find(book)
         copies_left = (storebook.copies-params[:cart][book].to_f)
         if copies_left < 0
           redirect_to 'cart' and return
         end
         storebook.update(copies: copies_left)
         @order_books = OrderBook.create("order": Order.find(@order[:id]), "book": Book.find(book), "copies": params[:cart][book])

         @order_books.save
       end

       session[:cart] = nil
       redirect_to order_path(@order)
     end
   end

   def update
     @order = Order.find(params[:id])

     @order.update(order_params)
     redirect_to order_path(@order)
   end
end
