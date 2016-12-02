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
      @current_customer = nil
    end

    # redirects to stored location (or to the default).
    # def redirect_back_or(default)
    #   redirect_to(session[:forwarding_url] || default)
    #   session.delete(:forwarding_url)
    # end

    # Stores the url trying to be accessed
    # def store_location
    #   session[:forwarding_url] = request.original_url if request.get?
    # end


end
