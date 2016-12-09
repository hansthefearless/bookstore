class CustomersController < ApplicationController
   def new
     @customer = Customer.new
   end

   def show
     @customer = Customer.find(params[:id])
   end

   def edit
     @customer = Customer.find(params[:id])
   end

   def create
     @customer = Customer.new(customer_params)

     @customer.save
     redirect_to @customer
   end

   def update
     @customer = Customer.find(params[:id])

     @customer.update(customer_params)
     redirect_to @customer
   end

   private
     def customer_params
       params.require(:customer).permit(:login, :password, :name, :phone, :address, :CCN)
     end
end
