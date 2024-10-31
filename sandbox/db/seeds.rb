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
    { name: 'りんご', price: 10 },
    { name: 'バナナ', price: 20 },
    { name: '梨', price: 30 },
    { name: 'すいか', price: 40 },
    { name: 'ぶどう', price: 50 },
    { name: 'キウイ', price: 60 },
    { name: '柿', price: 70 },
    { name: 'あんず', price: 80 },
    { name: 'みかん', price: 90 },
    { name: 'カリン', price: 100 },
    { name: 'グレープフルーツ', price: 110 },
    { name: 'すもも', price: 120 },
    { name: '桃', price: 130 },
    { name: '西洋梨', price: 140 },
    { name: 'びわ', price: 150 },
    { name: 'メロン', price: 160 },
    { name: 'ライチ', price: 170 }
  ]
)
