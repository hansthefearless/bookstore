class CustomersController < ApplicationController
   def new
     @customer = Customer.new
   end

   def show
     @customer = Customer.find(params[:id])
     @orders = Order.where(customer_id: params[:id])
     @opinions = Opinion.left_outer_joins(:ratings).where("opinions.customer_id = ?", params[:id]).group("opinions.id").select(
     "opinions.*, avg(ratings.usefulness) as avg_rating")
     @rated_opinions = Opinion.joins(:ratings).where("ratings.customer_id = ?", params[:id]).order("usefulness DESC").select("opinions.id, opinions.customer_id, opinions.book_id, opinions.text, opinions.score, ratings.usefulness as usefulness")
   end

   def edit
     @customer = Customer.find(params[:id])
   end

   def create
     @customer = Customer.new(customer_params)
     if @customer.save
       log_in @customer
       redirect_to customer_path(@customer)
     else
       render 'new'
     end

   end

   def update
     @customer = Customer.find(params[:id])

     if @customer.update(customer_params)
       redirect_to customer_path(@customer)
     else
       render 'edit'
     end
   end

   private
     def customer_params
       params.require(:customer).permit(:login, :password, :name, :phone, :address, :CCN)
     end
end
