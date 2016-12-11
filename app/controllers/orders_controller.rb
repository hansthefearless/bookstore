class OrdersController < ApplicationController
   def index
     @orders = Order.all
   end

   def new
     @order = Order.new
   end

   def show
     @order = Order.joins("INNER JOIN order_books ON order_books.order_id = orders.id").joins(
     "INNER JOIN books ON books.id = order_books.book_id").where(
     "orders.id = ?", params[:id])
   end

   def edit
     @order = Order.find(params[:id])
   end

   def create
     @order = Order.create("customer": Customer.find(session[:customer_id]), "status": "Pending")

     @order.save

     params[:cart].each do |book|
       @order_books = OrderBook.create("order": Order.find(@order[:id]), "book": Book.find(book), "copies": params[:cart][book])
       storebook = Book.find(book)
       storebook.update(copies: (storebook.copies-params[:cart][book].to_f))

       @order_books.save
     end

     @books = []
     params[:cart].each do |book|
       @books << book
     end

     @recommended = Order.joins(
     "INNER JOIN order_books ON order_books.order_id = orders.id").joins(
     "INNER JOIN books ON books.id = order_books.book_id").where(
     customer_id: Customer.joins("INNER JOIN orders ON orders.customer_id = customers.id").joins(
     "INNER JOIN order_books ON order_books.order_id = orders.id").joins(
     "INNER JOIN books ON books.id = order_books.book_id").where(
     "customer_id != ?", session[:customer_id]).where(
     "books.id IN (?)", @books).select("customer_id").distinct).select(
     "books.*, order_books.copies, sum(order_books.copies) as sold").where.not(
     "books.id IN (?)", @books).group("books.id").order("sum(order_books.copies) DESC")

     session[:cart] = nil
     redirect_to order_path(@order)
   end

   def update
     @order = Order.find(params[:id])

     @order.update(order_params)
     redirect_to order_path(@order)
   end
end
