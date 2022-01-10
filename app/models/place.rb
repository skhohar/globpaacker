class Place < ApplicationRecord
  belongs_to :user
  has_many :steps, dependent: :destroy
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  has_one_attached :photo
  INTERESTS = ["Culture", "Classical studies", "Cooking", "Critical theory", "Hobbies", "Literature", "Arts",
               "Fiction", "Game", "Poetry", "Sports", "Performing arts", "Dance", "Film", "Music", "Opera", "Theatre",
               "Visual arts", "Architecture", "Crafts", "Drawing", "Film", "Painting", "Photography", "Sculpture",
               "Typography", "Health", "Exercise", "Health science", "Nutrition", "History", "Classical antiquity",
               "Medieval history", "Renaissance", "Modern history", "Contemporary history", "Feminism", "Communism",
               "Liberalism", "LGBTQ", "Food", "Tradition", "Fashion", "Aerospace", "Artificial intelligence",
               "Agriculture", "Big Science", "Computer Science", "Transport", "Robotics", "Military", "Internet culture",
               "Memes & social network trends", "Biology", "Animals", "Botany", "Ecology", "Famous people", "Frienship",
               "Romance", "Sex", "Family", "Children", "Philosophy", "Religion", "Archaeology", "Critical theory",
               "Economics", "Law", "Political science", "Psychology", "Sociology", "Community", "Finance", "Education",
               "Autres lieux de culture", "Bibliotheques", "Cinemas", "Le Dome", "Musees", "Esplanade J4", "Odeon",
               "Opera", "Salles de spectacle", "Theatres"]
  RATING = [1, 2, 3, 4, 5]

  SENSES = ['Best Sight', "Amazing Hearings", 'Best Tastes', "Amazing Touch", 'Best Smell']
  ENVIRONMENTS = ["Cloudy", "Sunny", "Windy", "Calm", "Loudy"]

  #  validates :name, uniqueness: true, length: { minimum: 6 }, presence: true
  #  validates :duration, presence: true
  #  validates :senses, presence: true, inclusion: { in: SENSES }
  #  validates :environment, inclusion: { in: ENVIRONMENTS }
  #  validates :rating, inclusion: { in: RATING }
  #  validates :photo, presence: true
  #  validates :address, presence: true
end
