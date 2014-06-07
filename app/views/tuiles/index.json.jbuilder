json.array!(@tuiles) do |tuile|
  json.extract! tuile, :lien, :image, :titre, :description, :forme
  json.url tuile_url(tuile, format: :json)
end
