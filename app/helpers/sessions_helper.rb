module SessionsHelper

    #Logs in the given user.
    def log_in(customer)
      session[:customer_id] = customer.id
    end

    def current_customer?(customer)
      customer == current_customer
    end
    # Returns the current logged-in user (if any)
    def current_customer
      @current_customer ||= Customer.find_by(id: session[:customer_id])
    end

    # Returns true if the user is logged in, false otherwise
    def logged_in?
      !current_customer.nil?
    end

    def log_out
      session.delete(:customer_id)
      session.delete(:cart)
      @current_customer = nil
    end

    # redirects to stored location (or to the default).
    # def redirect_back_or(default)
    #   redirect_to(session[:forwarding_url] || default)
    #   session.delete(:forwarding_url)
    # end

    # def redirect_back_to
    #   redirect_to(session[:forwarding_url])
    # end

    #Stores the url trying to be accessed
    # def store_location
    #   session[:forwarding_url] = request.original_url if request.get?
    # end

    def add(book_id)
      puts book_id
      if session[:cart] == nil
        session[:cart] = {}
      end

      if session[:cart][book_id] == nil
        session[:cart][book_id] = 1
      else
        session[:cart][book_id] += 1
      end

      puts "Cart: ", session[:cart]
    end

    def populate_cart
      cart = Array.new()
      if session[:cart] != nil
        session[:cart].each do |book|
          @book = Book.find_by(id: book)
          puts @book.title
          cart.push([@book, session[:cart][book]])
        end
        return cart
      end
    end

end
