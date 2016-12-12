require 'json'

#
# Admin
#
Admin.destroy_all
Admin.create("login": "admin", "password": "admin", "name": "Admin")
print "\rSeeded 1 admin\n"


#
# Customers
#
numCustomers = 30

Customer.destroy_all
Customer.create("login": "hans", "password": "hans", "name": "Sng Han Jie", "phone": "81234567", "address": "8 Somapah Road", "CCN": "2222111133334444")
Customer.create("login": "jang", "password": "jang", "name": "Joel Ang", "phone": "82345678", "address": "8 Somapah Road", "CCN": "2222111133334444")
Customer.create("login": "candy", "password": "candy", "name": "Lou Yu Xin", "phone": "83456789", "address": "8 Somapah Road", "CCN": "2222111133334444")
Customer.create("login": "chay", "password": "chay", "name": "Chay Choong", "phone": "84567890", "address": "8 Somapah Road", "CCN": "2222111133334444")
customers = ["hans", "jang", "candy", "chay"]

for i in 1..numCustomers-4
	fullname = Faker::Name.name
	user = Faker::Internet.user_name(fullname, %w(. _ -))
	if !customers.include? user
		Customer.create("login": user, "password": user, "name": fullname, "phone": rand(80000000..89999999), "address": Faker::Address.street_address, "CCN": rand(1000000000000000..9999999999999999))
		customers.push(user)
	end
end

numCustomers = customers.size

print "\rSeeded #{numCustomers} customers\n"


#
# Books, Opinions and Ratings
#
Book.destroy_all
Opinion.destroy_all
Rating.destroy_all

file = File.read("db/data.txt")
data_hash = JSON.parse(file)

counter = 0
opinioncounter = 0
ratingcounter = 0

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
		custList = customers.shuffle

		for i in 0..rand(0..3)
			Opinion.create("customer": Customer.find_by("login": custList[i]), "book": Book.find(counter+1), "score": rand(0..10), "text": Faker::Lorem.paragraph)
			opinioncounter += 1

			for j in 0..rand(0..3)
				if j != i
					Rating.create("customer": Customer.find_by("login": custList[j]), "opinion": Opinion.find(opinioncounter), "usefulness": rand(0..2))
					ratingcounter += 1
				end
			end
		end

	rescue
		counter -= 1
	end

	counter += 1
	print "\rSeeded #{counter} books, #{opinioncounter} opinions and #{ratingcounter} ratings"
end

print "\n"


#
# Orders
#
Order.destroy_all

for i in 1..numCustomers
	Order.create("customer": Customer.find_by("login": customers[rand(0...numCustomers)]), "status": rand(1..2) == 1 ? "Pending" : "Completed")
	for j in 1..5
		OrderBook.create("order": Order.find(i), "book": Book.find(rand(1..615)), "copies": rand(1..5))
		print "\rSeeded #{i} orders"
	end
end

puts "\nSeeding complete"
