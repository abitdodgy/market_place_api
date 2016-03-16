json.(product, :id, :title, :price_in_cents, :created_at, :updated_at)

json.owner do |json|
  json.partial! product.owner
end
