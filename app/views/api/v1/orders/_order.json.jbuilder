json.(order, :id, :total_in_cents, :status, :created_at, :updated_at)

json.user do |json|
  json.partial! order.user
end

json.products order.products do |product|
  json.partial! product
end
