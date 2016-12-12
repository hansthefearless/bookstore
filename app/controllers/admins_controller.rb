class AdminsController < ApplicationController
   def show
     @admin = Admin.find(params[:id])
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
