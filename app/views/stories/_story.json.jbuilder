json.extract! story, :id, :title, :ganre, :body, :created_at, :updated_at
json.url story_url(story, format: :json)
