class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :authentication_keys => [:login]
  attr_accessor :login

  has_many :messages

  validates :username, :uniqueness => { :case_sensitive => false },
    exclusion: { in: %w(admin root tilify Admin Root Tilify), message: "%{value} est réservé." },
    length: { minimum: 3, maximum: 50, too_long: "Trop long !", too_short: "Trop court !" }

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
end
