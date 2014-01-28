json.array!(@topics) do |topic|
  json.extract! topic, :title, :description, :locked, :user_id, :secret, :created_at
  json.url topic_url(topic, format: :json)
end
