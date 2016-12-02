# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'

# Book.destroy_allx

file = File.read("db/data.txt")
data_hash = JSON.parse(file)

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
	keywords = v['keywords']
	form = rand(1..2) == 1 ? "Hardcover" : "Softcover"
	Book.create("ISBN" => isbn, "title" => title, "authors" => authors, "copies" => copies, "subject" => subject, "year" => year, "price" => price, "publisher" => publisher, "keywords" => keywords, "format" => form)
	counter += 1
	print "\rSeeding #{counter} entries: #{isbn}"
end

puts "\nSeeding complete"

