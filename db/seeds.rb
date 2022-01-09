# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
require 'faker'


puts 'cleaning DB.....'
Step.destroy_all
Navigation.destroy_all
Place.destroy_all
User.destroy_all

puts "seeding"

urls = ['https://images.unsplash.com/photo-1576453336457-64848c4ab6e9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2970&q=80',
  'https://images.unsplash.com/photo-1615693128203-3b3656d8e852?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1374&q=80',
  'https://images.unsplash.com/photo-1576924593291-95a57fba5c7d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTF8fG1hcnNlaWxsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
  'https://www.opera-online.com/media/images/picture/article/0000/0935/5176/xl_opera-de-marseille-saison-2019-2020.jpg?1556291209',
  'https://www.pagesjaunes.fr/media/resto/cinema_chambord_OSD07949060-66186.jpeg',
  'https://media.tacdn.com/media/attractions-splice-spp-674x446/0b/39/ad/6b.jpg',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmjLDgLJd7TxXiwIax_2wcp9oaxcB6T1YD5g&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIx0FY837eYQ9xri3OfTkyZrw8CcD1TaP51g&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYB2ZF26umwuCWQ3_xxKwKpFHK1tZqxh8ZqA&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVfrj2FFxqtNXUS-fhdsg8cQe8xOg9iaOiow&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4_CDhg-dngV53zdSLfVkpVTCPObXnMKQqbg&usqp=CAU',
  'https://cdn.radiofrance.fr/s3/cruiser-production/2019/09/c22967bf-191d-457d-83fb-6282f3c34e6f/1136_dscf6283.jpg',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhrvTdbplLxoH9rPrbL6A59adnOkNbjx3nrw&usqp=CAU',
  'https://images.unsplash.com/photo-1613828802410-edbb5e3402d3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bWFyc2VpbGxlJTIwcXVlZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=900&q=60',
  'https://images.unsplash.com/photo-1596491516432-b911a64808c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
  'https://images.unsplash.com/photo-1636982180754-0b9e5183849e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
  'https://images.unsplash.com/photo-1637512445331-ba3d6af7957b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
  'https://images.unsplash.com/photo-1631628489767-889fcd886a9f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
  'https://images.unsplash.com/photo-1566462588212-17e1bcf05f44?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
  'https://images.unsplash.com/photo-1566943024213-6f6caf67f558?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
  'https://images.unsplash.com/photo-1519110466169-102db60f74d5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
  'https://images.unsplash.com/photo-1616533884200-dddbf9e3193f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
  'https://images.unsplash.com/photo-1519110641722-0437c3a06d6f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
  'https://images.unsplash.com/photo-1576169797924-abffc61226a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
  'https://images.unsplash.com/photo-1621187168536-0c2551d8c975?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2836&q=80',
  'https://images.unsplash.com/photo-1590261460879-2bd70850e303?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1548&q=80',
  'https://images.unsplash.com/photo-1566840467174-c43e9c4b9a2e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
  'https://images.unsplash.com/photo-1590426058378-0cb1b9e20727?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
  'https://images.unsplash.com/photo-1629635771780-4bc960336c4b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
  'https://images.unsplash.com/photo-1518506020915-f4b91133f60c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
  'https://images.unsplash.com/photo-1637871220003-d3556c98f237?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
  'https://images.unsplash.com/photo-1601920448992-f3abea135411?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=627&q=80',
  'https://images.unsplash.com/photo-1566840601924-07789e0ad0b0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
  'https://images.unsplash.com/photo-1614979504528-5d0dbaa092ba?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
  'https://images.unsplash.com/photo-1601921845322-f29d1715129d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=627&q=80',
  'https://images.unsplash.com/photo-1601921845314-80ee27e006f8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=627&q=80',
  'https://images.unsplash.com/photo-1589229672456-0c6b70055b8a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
  'https://images.unsplash.com/photo-1613234073279-4c9c1b049d90?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1748&q=80',
  'https://images.unsplash.com/photo-1567017497423-2de680cc04b2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
  'https://images.unsplash.com/photo-1533376050980-236257b0b66a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
  'https://images.unsplash.com/photo-1536482252533-5c45502f7aa3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1160&q=80',
  'https://images.unsplash.com/photo-1601441322244-90edf2e328af?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1742&q=80']

 u1 = User.create!(email: "fonsecarika@gmail.com", password: "123456789", password_confirmation: "123456789")
 u2 = User.create!(email: "sarah@gmail.com", password: "123456789", password_confirmation: "123456789")
 u3 = User.create!(email: "illem@gmail.com", password: "123456789", password_confirmation: "123456789")
 u4 = User.create!(email: "test@journey.com", password: "123456789", password_confirmation: "123456789")

puts 'created 3 users'

n1 = Navigation.create(starting_longitude: "5.373907044477363", starting_latitude: "43.294522397027606", ending_longitude: "5.380254614802709", ending_latitude: "43.30283129514038", done: true, user_id: User.last.id, time_deadline: "10:12:22.869900", date: "2022-01-06")

puts 'created 1 navigation'

csv_options = { col_sep: '	', quote_char: '"', headers: :first_row }

CSV.foreach(Rails.root.join('lib/lieux_culturels.csv'), csv_options) do |row|
  file = URI.open(urls.sample)

  name = row["Nom du site"]
  interest = row["Categorie"]
  address = row["Adresse 1"] + " " + row["Code Postal"] + " " + row["Ville"]
  longitude = row["Longitude"]
  latitude = row["Latitude"]

  place = Place.new(name: name,
                  interest: Place::INTERESTS.sample(rand(1..7)),
                  address: address,
                  longitude: longitude,
                  latitude: latitude,
                  user_id: User.all.sample.id,
                  duration: rand(30..300),
                  rating: rand(1..5),
                  senses: Place::SENSES.sample,
                  exterior: false,
                  environment: Place::ENVIRONMENTS.sample,
                  description: Faker::Quote.jack_handey
                )
 place.photo.attach(io: file, filename: 'file.png', content_type: 'image/png')
  place.save
  p place.photo.key

p1= Place.create!(name: Musée Cantini, address: 19 Rue Grignan 13006 Marseille)
p2= Place.create!(name: Opéra de Marseille, address: 2 Rue Molière 13001 Marseille)
p3= Place.create!(name: Palais du Pharo, address: 58, Boulevard Charles Livon 13007 Marseille)
p4= Place.create!(name: Mucem, address: 1 Esplanade J4, 13002 Marseille)
p5= Place.create!(name: Parc Borély, Avenue du Parc Borély 13008 Marseille)
p6= Place.create!(name: Palais des Arts, address: 1, place Auguste et François Carli 13006 Marseille)
p7= Place.create!(name: Basilique Notre-Dame de la Garde, address: Rue Fort du Sanctuaire 13006 Marseille)
p8= Place.create!(name: Palais Longchamps, address: Boulevard, jardin Zoologique 13004 Marseille)
p9= Place.create!(name: Escaliers du Cours Julien, address: Rue Estelle, 13006 Marseille)
p10= Place.create!(name: Centre de la Vieille Charité, address: 2 Rue de la Charité 13002 Marseille)


 puts 'created 1 place .....'

 step1 = Step.create(navigation_id: Navigation.last.id, place_id: Place.last.id, status: "visited")

 puts 'created 1 step'
end
 puts ' done seeding ......'
