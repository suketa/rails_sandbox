# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Product.create(
  [
    { name: 'りんご', price: 100 },
    { name: 'バナナ', price: 200 },
    { name: '梨', price: 300 },
    { name: 'すいか', price: 400 },
    { name: 'ぶどう', price: 500 },
    { name: 'キウイ', price: 600 },
    { name: '柿', price: 700 }
  ]
)
