class OrdersController < ApplicationController
   def index
     @orders = Order.all
   end

   def new
     @order = Order.new
   end

   def show
     Order.joins("INNER JOIN order_books ON order_books.order_id = orders.id").joins(
     "INNER JOIN books ON books.id = order_books.book_id").select("books.*").where(
     "orders.id = ?", params[:id])
   end

   def edit
     @order = Order.find(params[:id])
   end

   def create
     @order = Order.new(order_params)

     @order.save

     params['books'].each do |order_book_params|
       @order_books = OrderBook.new(order_book_params)

       @order_books.save

     @books = []
     params['books'].each do |book|
       @books << book[:id]

     @recommended = Order.joins("INNER JOIN order_books ON order_books.order_id = orders.id").joins(
     "INNER JOIN books ON books.id = order_books.book_id").where(
     id: Order.joins("INNER JOIN order_books ON order_books.order_id = orders.id").joins(
     "INNER JOIN books ON books.id = order_books.book_id").where(
     "customer_id != ?", order_params[:customer_id]).where(
     "books.id IN ?", @books).select("order_id").distinct).select("books.*").where.not(
     "books.id IN ?", @books)

     redirect_to order_path(@order)
   end

   def update
     @order = Order.find(params[:id])

     @order.update(order_params)
     redirect_to order_path(@order)
   end

   private
     def order_params
       params.require(:order).permit(:status, :customer_id)
     end

   private
     def order_book_params
       params.require(:order_book).permit(:book_id, :order_id, :copies)
     end
end
