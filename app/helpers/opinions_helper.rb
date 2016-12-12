module OpinionsHelper

  def opinion_owner(customer_id)
    @customer = Customer.find_by(id: customer_id)
    @customer.login
  end

  def opinion_book(book_id)
    @book = Book.find_by(id: book_id)
    @book.title
  end

  def get_usefulness(usefulness)
    lista = ["Useless", "Useful", "Very Useful"]
    lista[usefulness]
  end
  
end
