class Message < ActiveRecord::Base
  belongs_to :user
  validates :title, :presence => true,
    length: { minimum: 3, maximum: 50 }
  validates :content, presence: true,
    length: { minimum: 10, maximum: 1000 }
end
