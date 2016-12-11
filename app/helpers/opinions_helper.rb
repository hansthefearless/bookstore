module OpinionsHelper

  def opinion_owner(customer_id)
    @customer = Customer.find_by(id: customer_id)
    @customer.login
  end
end
