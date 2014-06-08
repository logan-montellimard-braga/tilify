class Tuile < ActiveRecord::Base
  acts_as_taggable
  belongs_to :user

  validates :lien, :format => URI::regexp(%w(http https)), presence: true
  validates :image, :format => URI::regexp(%w(http https)), presence: true
  validates :titre, :uniqueness => { :case_sensitive => false },
    length: { minimum: 5, maximum: 50 }, presence: true
  validates :description, length: { minimum: 10, maximum: 300 }, presence: true
  validates :forme, presence: true
  validates :image, :format => { :with => /\A.+\.(jpeg|jpg|png|gif)\z/ }
  validates :tag_list, presence: true, length: { minimum: 3, maximum: 255 }
end
