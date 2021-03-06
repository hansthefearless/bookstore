module OrdersHelper
  def book_list(order_id)
    @books = Book.joins("INNER JOIN order_books ON order_books.book_id = books.id").joins(
    "INNER JOIN orders ON orders.id = order_books.order_id").where(
    "orders.id = ?", order_id).select("books.id, books.title, books.thumbnail, order_books.copies")
  end
end
