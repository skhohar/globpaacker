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

urls = [https://res.cloudinary.com/drwz0yg18/image/upload/v1641847771/Marseille/Marseille%20new/eglise-saint-laurent-marseille_u3olga.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641847115/Marseille/Marseille%20new/theatre-du-gymnase-a-marseille-37982520_nw5hws.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641846708/Marseille/Marseille%20new/love-spots_jardin-puget_05_nll0s9.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641832942/Marseille/Marseille%20new/muse%CC%81e-du-savon-de-marseille-la-licorne-marseille-all-year_zmxc6x.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641831842/Marseille/Marseille%20new/Maison_Diamante%CC%81e__3x2_crop_hjjmsc.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641831838/Marseille/Marseille%20new/1680x817_nlaahk.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641831834/Marseille/Marseille%20new/Porte_d_Aix_Marseille_jaow5s.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641831831/Marseille/Marseille%20new/te%CC%81le%CC%81chargement_8_dqwake.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641831828/Marseille/Marseille%20new/abbaye-saint-victorjorengo2-1920x960_nrwzxj.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641831825/Marseille/Marseille%20new/jardin-vestige-antique-centre-bourse-1400x934_p5gh0l.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641831821/Marseille/Marseille%20new/14013216928_3958ea2f7c_b_ymanbo.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641831818/Marseille/Marseille%20new/news_2293_tc9qhv.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641831815/Marseille/Marseille%20new/castellane-marseille_ht5yyu.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641831812/Marseille/Marseille%20new/IMG_6888_xcbtew.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641831808/Marseille/Marseille%20new/torrefaction-noailles-marseille-14512191980_svoto0.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641831805/Marseille/Marseille%20new/74321_itooft.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641831803/Marseille/Marseille%20new/saladin-epices-du-monde-boutique-marseille-all-year_nnyqz5.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641831798/Marseille/Marseille%20new/915366a866010a8ff49ab7e3ccd4e2f8_adnjfe.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641831795/Marseille/Marseille%20new/photo-1630836741356-240933683544_y1sfb2.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641886932/Marseille/Marseille%20new/depositphotos_379242336-stock-photo-marsigliafrancia-april2018-view-of-the_y60tuf.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641831783/Marseille/Marseille%20new/c10p02_Palais-des-arts_20150701_145542_emoqaj.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641831780/Marseille/Marseille%20new/musee_marseille_lovespots_cantini_05_eoacij.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641831764/Marseille/Marseille%20new/te%CC%81le%CC%81chargement_um7lvs.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641831758/Marseille/Marseille%20new/Ope%CC%81ra-de-Marseille-e1544270641705_mpz1pg.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641848739/Marseille/Marseille%20new/palais-longchamp-leotcm-1920x960_bi9huy.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641831743/Marseille/Marseille%20new/le-mucem-porte-dacces-sur-les-enjeux-et-traditions-de-la-mediterranee-825x460_p5x9z2.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641831739/Marseille/Marseille%20new/la-crie%CC%81e-the%CC%81a%CC%82tre-national-de-marseille_x3cd8a.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641831735/Marseille/Marseille%20new/chateau-borely-marseille-21-848x566_fdrpqu.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641831718/Marseille/Marseille%20new/vieille_charite_marseille-1_612x0_po46h9.jpg,
        https://res.cloudinary.com/drwz0yg18/image/upload/v1641886664/Marseille/Marseille%20new/thumbnail_ks6mqs.jpg]


 u1 = User.create!(name: "Erika", email: "fonsecarika@gmail.com", password: "123456789", password_confirmation: "123456789")
 u2 = User.create!(name: "Sarah", email: "sarah@gmail.com", password: "123456789", password_confirmation: "123456789")
 u3 = User.create!(name: "Ilhem", email: "illem@gmail.com", password: "123456789", password_confirmation: "123456789")
 u4 = User.create!(name: "Julie", email: "test@journey.com", password: "123456789", password_confirmation: "123456789")

puts 'created 3 users'

n1 = Navigation.create(starting_longitude: "5.373907044477363", starting_latitude: "43.294522397027606", ending_longitude: "5.380254614802709", ending_latitude: "43.30283129514038", done: true, user_id: User.last.id, time_deadline: "10:12:22.869900", date: "2022-01-06")

puts 'created 1 navigation'

#csv_options = { col_sep: '	', quote_char: '"', headers: :first_row }

##CSV.foreach(Rails.root.join('lib/lieux_culturels.csv'), csv_options) do |row|
file = URI.open(urls.sample)

#CSV.foreach(Rails.root.join('lib/lieux_culturels.csv'), csv_options) do |row|
  #
  file = URI.open(urls.sample)

  #name = row["Nom du site"]
  #interest = row["Categorie"]
  #address = row["Adresse 1"] + " " + row["Code Postal"] + " " + row["Ville"]
  #longitude = row["Longitude"]
  #latitude = row["Latitude"]

  #place = Place.new(name: name,
                  #interest: Place::INTERESTS.sample(rand(1..7)),
                  #address: address,
                  #longitude: longitude,
                  #latitude: latitude,
                  #user_id: User.all.sample.id,
                  #duration: rand(30..300),
                  #rating: rand(1..5),
                  #senses: Place::SENSES.sample,
                  #exterior: false,
                  #environment: Place::ENVIRONMENTS.sample,
                  #description: Faker::Quote.jack_handey
                #)
 #(io: file, filename: 'file.png', content_type: 'image/png')
  #place.save

p1= Place.new(name: "Musée Cantini",
              interest: "culture", "contemporary arts",
              address: "19 Rue Grignan 13006 Marseille"
              user_id: u3,
              duration: 8,
              rating: 4,
              sense: "best sight",
              exterior: false,
              environement: "calm", "windy",
              description: "It houses collections of modern and contemporary art complemented by those of the Museum of Contemporary Art in Marseille. The museum initially exhibited his works from the 17th to the 19th century, including painters from the 19th century Provencal school, such as Paul Guigou, Adolphe Monticelli, Émile Loubon, René Seyssaud, Félix Ziem, Maurice Bompard, Jean-Antoine Constantin, Gustave Ricard or José Silbert. Since then, it has specialized more particularly in modern art from the first half of the twentieth century until the sixties and today houses one of the most important French provincial public collections covering the period 1900-1980, along with those museums in Lyon, Saint-Étienne, Grenoble or Strasbourg.")
url = "'https://res.cloudinary.com/drwz0yg18/image/upload/v1641831780/Marseille/Marseille%20new/musee_marseille_lovespots_cantini_05_eoacij.jpg"
file = URI.open(url)
p1.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p2= Place.new(name: "Opéra de Marseille",
              address: "2 Rue Molière 13001 Marseille",
              interest: "opera","culture", "theater",
              user_id: u3,
              duration: 4,
              rating: 4,4,
              sense: "amazing hearing",
              exterior: false,
              environment: "calm", "windy",
              description: "It is a theater located in the district of the same name, not far from the Old Port. The first opera theater was created in Marseille in 1685 by the composer Pierre Gaultier who obtained permission from Lully to open such an establishment, in return for the payment of an excessive royalty which ruined it. It is said that Mademoiselle de Maupin (actress) performed there at the end of the 1680s.Marseille's municipal opera house is built on the remains of the Grand-Théâtre, which was destroyed by fire in 1919.")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641831758/Marseille/Marseille%20new/Ope%CC%81ra-de-Marseille-e1544270641705_mpz1pg.jpg"
file = URI.open(url)
p2.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p3= Place.new(name: "Palais du Pharo",
              interest: "history", "culture",
              address: "58, Boulevard Charles Livon 13007 Marseille",
              user_id: u3,
              duration: 9,
              rating: 4,6,
              sense: "best sight",
              exterior: false,
              environment: "sunny",
              description: "The Pharo Palace (from Occitan faròt, lighthouse) is a Marseille monument whose construction was ordered by Napoleon III for the Empress Eugenie in the second half of the 19th century. It now belongs to the city of Marseille and is a venue for conferences and various events. It overlooks the port pass, on the sea side, and the Pharo garden, on the town side.")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641886932/Marseille/Marseille%20new/depositphotos_379242336-stock-photo-marsigliafrancia-april2018-view-of-the_y60tuf.jpg"
file = URI.open(url)
p3.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p4= Place.new(name: "Mucem",
              interest: "arts", "contemporary arts", "culture", "sculpture",
              address: "1 Esplanade J4 13002 Marseille",
              user_id: u3,
              duration: 4,
              rating: 4,4,
              sense: "best sight",
              exterior: false,
              environment: "cloudy", "windy", "sunny",
              description: "The Museum of European and Mediterranean Civilizations (Mucem) is a national museum located in Marseille. It was inaugurated by President François Hollande on June 7, 2013, when Marseille was the European capital of culture.A society museum, the Mucem is a national museum placed under the supervision of the Ministry of Culture and devoted to the civilizations of Europe and the Mediterranean. By creating this museum in Marseille, the State is providing the second largest city in France with major cultural facilities.The permanent exhibitions are based on different scientific fields: anthropology, archeology, history, art history and contemporary art. The museum also offers temporary exhibitions often linked to artistic or societal news. The museum's vocation is to report on the historical and social permanence of this basin of civilization, as well as the tensions that run through it until the present day.According to the definition of ICOM and the principles of the “Museums Law” in France, the Mucem associates with its program of exhibitions, a rich cultural program. Like a forum, it is intended to be a place of debate, and the artistic and cultural program, as well as the exhibitions, seek to tackle the major questions which animate contemporary European and Mediterranean societies. The Mucem is one of the scientific departments of national museums, the bridgehead of social museums in France for the cultural anthropology of societies in Europe and the Mediterranean.")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641831743/Marseille/Marseille%20new/le-mucem-porte-dacces-sur-les-enjeux-et-traditions-de-la-mediterranee-825x460_p5x9z2.jpg"
file = URI.open(url)
p4.photo.attach(io: file, filename: 'file.png', content_type: 'image/png')
p5= Place.new(name: "Parc Borély",
              interest: "botany", "biology", "photography", "ecology",
              address: "Avenue du Parc Borély 13008 Marseille",
              user_id: u3,
              duration: 60,
              rating: 4,5,
              exterior: true,
              sense: "amazing hearing", "best sight",
              environement: "loudy", "sunny",
              description: "Parc Borély is one of Marseille's public parks and gardens, in the Bonneveine district in the 8th arrondissement of Marseille")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641831735/Marseille/Marseille%20new/chateau-borely-marseille-21-848x566_fdrpqu.jpg"
file = URI.open(url)
p5.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p6= Place.new(name: "Palais des Arts",
              interest: "arts", "painting", "culture", "literature",
              address: "1, place Auguste et François Carli 13006 Marseille",
              user_id: u3,
              duration: 11,
              rating: 3,3,
              sense: "best sight",
              exterior: false,
              environement: "windy","cloudy",
              description: "The Palais des Arts is a Marseille monument originally built in 1864 to house the municipal library and the École des Beaux-Arts in Marseille")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641831783/Marseille/Marseille%20new/c10p02_Palais-des-arts_20150701_145542_emoqaj.jpg"
file = URI.open(url)
p6.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p7= Place.new(name: "Basilique Notre-Dame de la Garde",
              interest: "architecture", "religion", "history",
              address: "Rue Fort du Sanctuaire 13006 Marseille",
              user_id: u3,
              duration: 26,
              rating: 4,7,
              sense: "best sight",
              exterior: false,
              environement: "calm", "windy",
              description: "The Notre-Dame-de-la-Garde basilica or more simply Notre-Dame-de-la-Garde, often nicknamed "the Good Mother", is a minor basilica of the Catholic Church dating from the 19th century. Emblem of Marseille, dedicated to Notre-Dame de la Garde (protector of Marseille with Saint Victor), it dominates the city and the Mediterranean Sea from the top of Notre-Dame-de-la-Garde hill")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641831795/Marseille/Marseille%20new/photo-1630836741356-240933683544_y1sfb2.jpg"
file = URI.open(url)
p7.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p8= Place.new(name: "Palais Longchamp",
              interest: "photography", "architecture", "botany", "arts",
              address: "Boulevard jardin Zoologique 13004 Marseille",
              user_id: u3,
              duration: 33,
              rating: 4,5,
              sense: "best sight",
              exterior: false,
              environement: "sunny", "cloudy",
              description: "The Longchamp Palace is a neoclassical-Second Empire style water palace-water tower from the 19th century, in the Cinq-Avenues district of the 4th arrondissement of Marseille, in the Bouches-du-Rhône in Provence-Alpes-Côte d'Azur")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641848739/Marseille/Marseille%20new/palais-longchamp-leotcm-1920x960_bi9huy.jpg"
file = URI.open(url)
p8.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p9= Place.new(name: "Escaliers du Cours Julien",
              interest: "visual arts", "photography", "drawing",
              address: "Rue Estelle, 13006 Marseille",
              user_id: u3,
              duration: 12,
              rating: 4,1,
              sense: "best sight",
              exterior: true,
              environment: "sunny", "cloudy", "loudy",
              description: "Colorful graffiti and urban art on the stairs marking the entrance to Cours Julien")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641831798/Marseille/Marseille%20new/915366a866010a8ff49ab7e3ccd4e2f8_adnjfe.jpg"
file = URI.open(url)
p9.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p10= Place.new(name: "Centre de la Vieille Charité",
              interest: "arts", "culture", "photography", "history", "archaeology",
              address: "2 Rue de la Charité 13002 Marseille",
              user_id: u3,
              duration: 13,
              rating: 4,4,
              sense: "amazing hearing", "best sight",
              exterior: false,
              environment: "cloudy", "windy", "calm"
              description: "The Center de la Vieille Charité brings together several multi-cultural structures in Marseille: museums, associations, school, ... and offers temporary exhibitions and activities throughout the year")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641831718/Marseille/Marseille%20new/vieille_charite_marseille-1_612x0_po46h9.jpg"
file = URI.open(url)
p10.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p11 = Place.new(name: "Wonderful spices of Saladin",
                  interest: "Cooking", "Nutrition", "Food", "Tradition",
                  address: "10 Rue Longue des Capucins, 13001 Marseille",
                  user_id: u2,
                  duration: 15,
                  rating: 5,
                  senses: 'Best Smell',
                  exterior: false,
                  environment: "Calm",

              
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641831803/Marseille/Marseille%20new/saladin-epices-du-monde-boutique-marseille-all-year_nnyqz5.jpg"
file = URI.open(url)
p11.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
                  description: "Discover incredible spices from all around the world in this reknowed shop, emblematic of both Marseilles and the city center")

p12 = Place.new(name: "Fresh sea scents on the Old Port fish market",
                  interest: "Food", "Tradition",
                  address: "11 quai des Belges, 13001 Marseille",
                  user_id: u2,
                  duration: 25,
                  rating: 4,
                  senses: 'Best Sight', "Amazing Hearings", 'Best Smell',
                  exterior: true,
                  environment: "Windy", "Sunny",
                  description: "Key to the city spirit, the fish market lets you experience grocery shopping the old fashion way. Listen to the stallholders screaming their offer and smell the Mediterranean sea right from the boat.")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641831805/Marseille/Marseille%20new/74321_itooft.jpg"
file = URI.open(url)
p12.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p13 = Place.new(name: "Coffee experience takes you back to Marseilles' Roaring Twenties",
                  interest: "Modern history", "Food", "Tradition",
                  address: ("56 la Canebière, 13001 MArseille"),
                  user_id: u2,
                  duration: 5,
                  rating: 3,
                  senses: 'Best Smell', 'Best Tastes',
                  exterior: false,
                  environment: "Calm",
                  description: "Torréfaction Noailles was created in the 20s and preserved a sense of its original setting. Travel the time on top of tasting great quality coffee!")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641831808/Marseille/Marseille%20new/torrefaction-noailles-marseille-14512191980_svoto0.jpg"
file = URI.open(url)
p13.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p14 = Place.new(name: "Clean body, dirty city",
                  interest: "Tradition", "Biology",
                  address: "Cours Julien, Marseille, Bouches-du-Rhône 13006, France",
                  user_id: u2,
                  duration: 30,
                  rating: 4,
                  senses: 'Best Smell',
                  exterior: false,
                  environment: "Calm",
                  description: "Savonnerie Marseillaisse de la Licorne offers free visits of their soap manufacture, getting you through the whole process of this paradoxically traditional and world reknowed industry of Marseilles")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641831812/Marseille/Marseille%20new/IMG_6888_xcbtew.jpg"
file = URI.open(url)
p14.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p15 = Place.new(name: "Making of virtuosos",
                  interest: "Culture", "Performing arts", "Music", "Opera",
                  address: "10 rue de la bibliothèque, 13001 Marseille",
                  user_id: u2,
                  duration: 20,
                  rating: 3,
                  senses: "Amazing Hearings",
                  exterior: true,
                  environment: "Loudy",
                  description: "This elite music school offers the secret opportunity to let you listen to amazing musical talents for free: don't try to get it, but rather walk in the nearby street where you might have a chance to hear a future classical music star, or at least the poetry of a young person training without rest.")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641886664/Marseille/Marseille%20new/thumbnail_ks6mqs.jpg"
file = URI.open(url)
p15.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p16= Place.new(name: "Place Castellane",
              interest: "scultpture", "culture", "photography", "history",
              address: "Place Castellane 13006 Marseille",
              user_id: u3,
              duration: 32,
              rating: 4,1,
              sense: "amazing hearing", "best sight",
              exterior: true,
              environment: "sunny", "cloudy", "loudy",
              description: "Road roundabout known for its 1910s fountain, featuring elaborate carvings and a marble pillar")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641831815/Marseille/Marseille%20new/castellane-marseille_ht5yyu.jpg"
file = URI.open(url)
p16.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p17-= Place.new(name: "Ciel I Rooftop",
              interest: "cooking", "food", "photography",
              address: "17 Rue Haxo, 13001 Marseille",
              user_id: u3,
              duration: 3,
              rating: 4,2,
              sense: "best sight", "best smell", "best tastes",
              exterior: true,
              environment: "sunny", "cloudy", "loudy",
              description: "It's a rooftop restaurant in the heart of Marseille. An incredible roof terrace nestled on one of the tallest buildings in the center [the former Galeries Lafayette], which dominates the city, the entrance to the Old Port and faces the good mother!")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641831818/Marseille/Marseille%20new/news_2293_tc9qhv.jpg"
file = URI.open(url)
p17.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p18-= Place.new(name: "Le Musée du Savon de Marseille",
              interest: "photography", "culture",
              address: "25 Quai de Rive Neuve, 13007 Marseille",
              user_id: u3,
              duration: 20,
              rating: 4,3,
              sense: "best sight", "best smell",
              exterior: false,
              environment: "sunny", "cloudy", "loudy",
              description: "Picturesque museum with objects and demonstrations on soap making, and personalized souvenirs")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641832942/Marseille/Marseille%20new/muse%CC%81e-du-savon-de-marseille-la-licorne-marseille-all-year_zmxc6x.jpg"
file = URI.open(url)
p18.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p19= Place.new(name: "Cathédrale de la Major",
              interest: "architecture", "photography", "religion",
              address: "Place de la Major, 13002 Marseille",
              user_id: u3,
              duration: 23,
              rating: 4,6,
              sense: "best sight", "calm",
              exterior: false,
              environment: "sunny", "cloudy",
              description: "Large 19th century Neo-Byzantine cathedral with an opulent interior with murals, mosaics and marble")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641831821/Marseille/Marseille%20new/14013216928_3958ea2f7c_b_ymanbo.jpg"
file = URI.open(url)
p19.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p20= Place.new(name: "Port Antique",
              interest: "architecture", "photography", "history", "archaeological",
              address: "2 Rue Henri Barbusse, 13001 Marseille",
              user_id: u3,
              duration: 11,
              rating: 4,3,
              sense: "best sight",
              exterior: true,
              environment: "sunny", "cloudy",
              description: "Small public park with archaeological remains of the Roman road and Greek fortifications of the old port")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641831825/Marseille/Marseille%20new/jardin-vestige-antique-centre-bourse-1400x934_p5gh0l.jpg"
file = URI.open(url)
p20.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p21= Place.new(name: "Eglise Saint Laurent",
              interest: "history", "religion",
              address: "16 Esplanade de la Tourette, 13002 Marseille",
              user_id: u3,
              duration: 20,
              rating: 4,3,
              sense: "best sight",
              exterior: false,
              environment: "sunny", "windy", "cloudy",
              description: "Historic Catholic Church with simple and refined architecture, with panoramic view from the hill.")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641847771/Marseille/Marseille%20new/eglise-saint-laurent-marseille_u3olga.jpg"
file = URI.open(url)
p21.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p22= Place.new(name: "Friche de la Belle de Mai",
              interest: "photography", "history",
              address: "41 Rue Jobin, 13003 Marseille",
              user_id: u3,
              duration: 19,
              rating: 4,5,
              sense: "best sight","amazing hearings",
              exterior: true,
              environment: "loudy", "sunny",
              description: "Place of creation with artistic shows, concerts and exhibitions in a former tobacco factory")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641831722/Marseille/Marseille%20new/te%CC%81le%CC%81chargement_bdayyg.jpg"
file = URI.open(url)
p22.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p23= Place.new(name: "Théâtre La Criée",
              interest: "performing arts", "danse",
              address: "30 Quai Rive Neuve, 13007 Marseille",
              user_id: u3,
              duration: 24,
              rating: 4,4,
              sense: "best sight",
              exterior: false,
              environment: "loudy", "cloudy", "windy"
              description: "National drama center with a large glass roof, with exhibitions in the hall and eclectic programming")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641831739/Marseille/Marseille%20new/la-crie%CC%81e-the%CC%81a%CC%82tre-national-de-marseille_x3cd8a.jpg"
file = URI.open(url)
p23.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p24= Place.new(name: "Abbaye Saint-Victor",
              interest: "architecture", "photography", "history",
              address: "Place Saint Victor, 13007 Marseille",
              user_id: u3,
              duration: 24,
              rating: 4,4,
              sense: "best sight",
              exterior: false,
              environment: "loudy", "sunny",
              description: "Fortified abbey founded by Saint Cassien and built above the 5th crypt housing its sarcophagus")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641831828/Marseille/Marseille%20new/abbaye-saint-victorjorengo2-1920x960_nrwzxj.jpg"
file = URI.open(url)
p24.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p25= Place.new(name: "Parc de la Colline Puget",
              interest: "photography", "botany",
              address: "25 Boulevard de la Corderie, 13007 Marseille",
              user_id: u3,
              duration: 26,
              rating: 4,3,
              sense: "best sight",
              exterior: true,
              environment: "sunny",
              description: "City park with children's play area")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641846708/Marseille/Marseille%20new/love-spots_jardin-puget_05_nll0s9.jpg"
file = URI.open(url)
p25.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p26= Place.new(name: "Théâtre du Gymnase",
              interest: "performing arts", "danse",
              address: "4 Rue du Théâtre Français, 13001 Marseille",
              user_id: u3,
              duration: 10,
              rating: 4,3,
              sense: "best sight",
              exterior: false,
              environment: "cloudy", "windy",
              description: "Renovated in the 1980s, this Italian-style theater, founded in 1804, offers a varied program.")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641847115/Marseille/Marseille%20new/theatre-du-gymnase-a-marseille-37982520_nw5hws.jpg"
file = URI.open(url)
p26.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p27= Place.new(name: "Studio Fotokino",
              interest: "visual arts", "painting", "photography",
              address: "33 Allée Léon Gambetta, 13001 Marseille",
              user_id: u3,
              duration: 9,
              rating: 4,5,
              sense: "best sight",
              exterior: false,
              environment: "loudy", "cloudy",
              description: "The Fotokino association, created in 2000 in Marseille, is dedicated to the dissemination of artistic works in the field of visual arts")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641831831/Marseille/Marseille%20new/te%CC%81le%CC%81chargement_8_dqwake.jpg"
file = URI.open(url)
p27.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p28= Place.new(name: "Porte d'Aix",
              interest: "photography", "history", "architecture",
              address: "19 Place Jules Guesde, 13003 Marseille",
              user_id: u3,
              duration: 6,
              rating: 3,9,
              sense: "best sight",
              exterior: true,
              environment: "sunny",
              description: "Triumphal arch designed by Michel-Robert Penchaud in honor of the victories of the Napoleonic wars")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641831834/Marseille/Marseille%20new/Porte_d_Aix_Marseille_jaow5s.jpg"
file = URI.open(url)
p28.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p29= Place.new(name: "Place d'Armes",
              interest: "photography", "history", "architecture",
              address: "Esplanade du Fort Saint-Jean, 13002 Marseille",
              user_id: u3,
              duration: 23,
              rating: 4,6,
              sense: "best sight", "amazing hearings",
              exterior: true,
              environment: "sunny",
              description: "With its village, gardens and countless little secrets, Fort Saint-Jean is a joyful labyrinth")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641831838/Marseille/Marseille%20new/1680x817_nlaahk.jpg"
file = URI.open(url)
p29.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')
p30= Place.new(name: "La Maison Diamantée",
              interest: "culture", "history", "architecture",
              address: "3 Rue de la Prison, 13002 Marseille",
              user_id: u3,
              duration: 16,
              rating: 4,1,
              sense: "best sight",
              exterior: true,
              environment: "sunny",
              description: "The Diamantée house is a building in Marseille located just behind the town hall, in the town hall district. It owes its name to the appearance of its facade, which is covered with stone cut in points: prismatic bosses")
url = "https://res.cloudinary.com/drwz0yg18/image/upload/v1641831842/Marseille/Marseille%20new/Maison_Diamante%CC%81e__3x2_crop_hjjmsc.jpghttps://res.cloudinary.com/drwz0yg18/image/upload/v1641831842/Marseille/Marseille%20new/Maison_Diamante%CC%81e__3x2_crop_hjjmsc.jpg"
file = URI.open(url)
p30.photo.attach(io: file, filename: 'file.png', content_type: 'image/jpg')


Place.save
puts 'created 1 place .....'

 step1 = Step.create(navigation_id: Navigation.last.id, place_id: Place.last.id, status: "visited")

 puts 'created 1 step'
end
 puts ' done seeding ......'
