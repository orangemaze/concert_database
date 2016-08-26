json.extract! album, :id, :album_name, :album_review, :album_amazon_ad, :created_at, :updated_at
json.url album_url(album, format: :json)