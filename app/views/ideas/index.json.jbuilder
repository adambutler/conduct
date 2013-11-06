json.array!(@ideas) do |idea|
  json.extract! idea, :title, :description, :topic_id, :user_id
  json.url idea_url(idea, format: :json)
end
