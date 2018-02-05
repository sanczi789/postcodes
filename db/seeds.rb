# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Cleaning database...'
Office.destroy_all
# puts 'Creating offices...'
cambridge = Office.create!(name:"Cambridge", postcode:"Cb41pw")
whitechapel = Office.create!(name:"whitechapel", postcode:"e15pt")
hoxton = Office.create!(name:"hoxton", postcode:"N16SU")
brixton = Office.create!(name:"brixton", postcode:"sw21rj")
manchester = Office.create!(name:"manchester", postcode:"m139pl")
badminton = Office.create!(name:"badminton", postcode:"GL91ES")
leicester = Office.create!(name:"leicester", postcode:"le17rh")
birmingham = Office.create!(name:"birmingham", postcode:"b54bu")
