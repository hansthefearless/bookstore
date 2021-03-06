module SessionsHelper

    #Logs in the given user.
    def log_in(customer)
      session[:customer_id] = customer.id
      session[:cart] = Hash.new()
    end

    def log_in_admin(admin)
      session[:admin_id] = admin.id
    end

    # def current_customer?(customer)
    #   customer == current_customer
    # end
    # Returns the current logged-in user (if any)
    def current_customer
      @current_customer ||= Customer.find_by(id: session[:customer_id])
    end

    def customer_id
      current_customer.id
    end

    def current_admin
      @current_admin ||= Admin.find_by(id: session[:admin_id])
    end

    # Returns true if the user is logged in, false otherwise
    def logged_in?
      !current_customer.nil?
    end

    def logged_in_admin?
      !current_admin.nil?
    end


    def log_out
      session.delete(:customer_id)
      session.delete(:cart)
      @current_customer = nil
    end

    def log_out_admin
      session.delete(:admin_id)
      @current_admin = nil
    end

    # redirects to stored location (or to the default).
    # def redirect_back_or(default)
    #   redirect_to(session[:forwarding_url] || default)
    #   session.delete(:forwarding_url)
    # end

    def redirect_back_to
      redirect_to(session[:forwarding_url])
      session.delete(:forwarding_url)
    end

    #Stores the url trying to be accessed
    def store_location
      session[:forwarding_url] = request.original_url if request.get?
    end

    def add(book_id)
      if session[:cart] == nil
        session[:cart] = {}
      end
      if session[:cart][book_id] == nil
        session[:cart][book_id] = 1
        return true
      else
        session[:cart][book_id] += 1
        return false
      end
    end

    def delete(book_id)
      session[:cart].delete(book_id)
    end

    def subtract_qty(book_id)
      if session[:cart][book_id] > 1
        session[:cart][book_id]-=1
      end
    end

    def add_qty(book_id)
      @book = Book.find_by(id: book_id)
      if session[:cart][book_id] < @book.copies
        session[:cart][book_id]+=1
      end
    end

    def populate_cart
      if session[:cart] == nil
        session[:cart] = {}
      end
      cart = Array.new()
      if !session[:cart].empty?
        session[:cart].each do |book|
          @book = Book.left_outer_joins(opinions: :ratings).select(
          "books.*, avg(ratings.usefulness) as avg_rating").where(
          id: book[0])[0]
          cart.push([@book, session[:cart][book[0]]])
        end
        puts cart
        return cart
      else
        puts "empty"
        return nil
      end
    end

end
