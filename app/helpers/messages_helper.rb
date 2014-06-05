module MessagesHelper
  def getUserById(id)
    return User.find_by_id(id)
  end
end
