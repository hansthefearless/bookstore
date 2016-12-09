class OrdersController < ApplicationController
   def index
     @orders = Order.all
   end

   def new
     @order = Order.new
   end

   def show
     @order = Order.find(params[:id])
   end

   def edit
     @order = Order.find(params[:id])
   end

   def create
     @order = Order.new(order_params)

     @order.save

     params['books'].each do |b|
       @order_books = OrderBook.new(b)

       @order_books.save
     redirect_to @order
   end

   def update
     @order = Order.find(params[:id])

     @order.update(order_params)
     redirect_to @order
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
