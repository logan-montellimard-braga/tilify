json.array!(@messages) do |message|
  json.extract! message, :title, :content, :public
  json.url message_url(message, format: :json)
end