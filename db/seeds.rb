# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'

Book.destroy_all
Customer.destroy_all
Order.destroy_all

file = File.read("db/data.txt")
data_hash = JSON.parse(file)

Customer.create("login": "hans", "password": "hans", "name": "Sng Han Jie", "phone": "81234567", "address": "8 Somapah Road", "CCN": "2222111133334444")
Customer.create("login": "jang", "password": "jang", "name": "Joel Ang", "phone": "82345678", "address": "8 Somapah Road", "CCN": "2222111133334444")
Customer.create("login": "candy", "password": "candy", "name": "Lou Yu Xin", "phone": "83456789", "address": "8 Somapah Road", "CCN": "2222111133334444")
Customer.create("login": "chay", "password": "chay", "name": "Chay Choong", "phone": "84567890", "address": "8 Somapah Road", "CCN": "2222111133334444")

customers = ["hans", "jang", "candy", "chay"]

counter = 0
data_hash.each do |k, v|
	isbn = v['ISBN'].to_s
	title = v['title']
	authors = v['authors'].join("; ")
	copies = rand(1...20)
	subject = v['subject']
	year = v['year']
	price = rand(2000...10000) / 100.0
	publisher = v['publisher']
	thumbnail = v['thumbnail']
	keywords = v['keywords']
	form = rand(1..2) == 1 ? "Hardcover" : "Softcover"
	Book.create("ISBN": isbn, "title": title, "authors": authors, "thumbnail": thumbnail, "copies": copies, "subject": subject, "year": year, "price": price, "publisher": publisher, "keywords": keywords, "format": form)
	
	begin
		randomCust = rand(0..3)
		Opinion.create("customer": Customer.find_by("login": customers[randomCust]), "book": Book.find(counter+1), "score": rand(0..10), "text": "this book is gr8 i r8 8/8")
		Rating.create("customer": Customer.find_by("login": customers[randomCust]), "opinion": Opinion.find(counter+1), "usefulness": rand(0..2))

	rescue
		counter -= 1
	end
		
	counter += 1
	print "\rSeeding #{counter} books: #{isbn}"
end

Admin.create("login": "admin1", "password": "admin1", "name": "Admin 1")
Admin.create("login": "admin2", "password": "admin2", "name": "Admin 2")

for i in 1..20
	Order.create("customer": Customer.find_by("login": customers[rand(0..3)]), "status": "Pending")
	for j in 1..5
		OrderBook.create("order": Order.find(i), "book": Book.find(rand(1..615)))
	end
end

# Opinion.create("customer": "hans", "book": "", "score": "", "text": "")


puts "\nSeeding complete"

