class FavoriteTuile < ActiveRecord::Base
  belongs_to :tuile
  belongs_to :user
end
