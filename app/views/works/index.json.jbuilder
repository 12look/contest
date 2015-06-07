json.array!(@works) do |work|
  json.extract! work, :id, :name, :description, :user_id, :category_id
  json.url work_url(work, format: :json)
end
