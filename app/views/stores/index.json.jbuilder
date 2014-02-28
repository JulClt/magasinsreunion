json.array!(@stores) do |store|
  json.extract! store, :id, :name, :address, :postcode, :town, :phonenumber, :email, :name_shopper, :activity
  json.url store_url(store, format: :json)
end
