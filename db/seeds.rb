# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
require 'faker'
require "open-uri"


puts 'cleaning DB.....'
Step.destroy_all
Navigation.destroy_all
Place.destroy_all
User.destroy_all

puts "seeding"

 u1 = User.create!(name: "Erika", email: "fonsecarika@gmail.com", password: "123456789", password_confirmation: "123456789")
 u2 = User.create!(name: "Sarah", email: "sarah@gmail.com", password: "123456789", password_confirmation: "123456789")
 u3 = User.create!(name: "Ilhem", email: "illem@gmail.com", password: "123456789", password_confirmation: "123456789")
 u4 = User.create!(name: "Julie", email: "test@journey.com", password: "123456789", password_confirmation: "123456789")

puts 'created 3 users'

n1 = Navigation.create!(starting_longitude: "5.373907044477363", starting_latitude: "43.294522397027606", ending_longitude: "5.380254614802709", ending_latitude: "43.30283129514038", done: true, user_id: User.last.id, time_deadline: "10:12:22.869900", date: "2022-01-06")

puts 'created 1 navigation'

p1 = Place.new(name: "Musée Cantini",
              interest: ["culture", "contemporary arts"],
              address: "19 Rue Grignan 13006 Marseille",
              user_id: u1.id,
              duration: 8,
              rating: 4,
              senses: ["best sight"],
              exterior: false,
              environment: ["calm", "windy"],
              description: "It houses collections of modern and contemporary art complemented by those of the Museum of Contemporary Art in Marseille. The museum initially exhibited his works from the 17th to the 19th century, including painters from the 19th century Provencal school, such as Paul Guigou, Adolphe Monticelli, Émile Loubon, René Seyssaud, Félix Ziem, Maurice Bompard, Jean-Antoine Constantin, Gustave Ricard or José Silbert. Since then, it has specialized more particularly in modern art from the first half of the twentieth century until the sixties and today houses one of the most important French provincial public collections covering the period 1900-1980, along with those museums in Lyon, Saint-Étienne, Grenoble or Strasbourg.")
url1 = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641831780/Marseille/Marseille%20new/musee_marseille_lovespots_cantini_05_eoacij.jpg"
file1 = URI.open(url1)
p1.photo.attach(io: file1, filename: 'file.png', content_type: 'image/jpg')
p2 = Place.new(name: "Opéra de Marseille",
              address: "2 Rue Molière 13001 Marseille",
              interest: ["opera","culture", "theater"],
              user_id: u2.id,
              duration: 25,
              rating: 3,
              senses: ["amazing hearing"],
              exterior: false,
              environment: ["calm", "windy"],
              description: "It is a theater located in the district of the same name, not far from the Old Port. The first opera theater was created in Marseille in 1685 by the composer Pierre Gaultier who obtained permission from Lully to open such an establishment, in return for the payment of an excessive royalty which ruined it. It is said that Mademoiselle de Maupin (actress) performed there at the end of the 1680s.Marseille's municipal opera house is built on the remains of the Grand-Théâtre, which was destroyed by fire in 1919.")
url2 = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641831758/Marseille/Marseille%20new/Ope%CC%81ra-de-Marseille-e1544270641705_mpz1pg.jpg"
file2 = URI.open(url2)
p2.photo.attach(io: file2, filename: 'file.png', content_type: 'image/jpg')
p3 = Place.new(name: "Palais du Pharo",
              interest: ["history", "culture"],
              address: "58, Boulevard Charles Livon 13007 Marseille",
              user_id: u3.id,
              duration: 9,
              rating: 4,
              senses: ["best sight"],
              exterior: false,
              environment: ["sunny"],
              description: "The Pharo Palace (from Occitan faròt, lighthouse) is a Marseille monument whose construction was ordered by Napoleon III for the Empress Eugenie in the second half of the 19th century. It now belongs to the city of Marseille and is a venue for conferences and various events. It overlooks the port pass, on the sea side, and the Pharo garden, on the town side.")
url3 = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641886932/Marseille/Marseille%20new/depositphotos_379242336-stock-photo-marsigliafrancia-april2018-view-of-the_y60tuf.jpg"
file3 = URI.open(url3)
p3.photo.attach(io: file3, filename: 'file.png', content_type: 'image/jpg')

places = [p1, p2, p3]
places.each do |place|
  place.save!
end
puts 'created 3 places .....'

step1 = Step.create!(navigation_id: Navigation.last.id, place_id: Place.last.id, status: "visited")

 puts 'created 1 step'

 puts ' done seeding ......'
