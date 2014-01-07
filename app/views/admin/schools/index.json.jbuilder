json.array!(@admin_schools) do |admin_school|
  json.extract! admin_school, :id
  json.url admin_school_url(admin_school, format: :json)
end
