json.extract! post, :id, :text, :link, :user_id, :parent_post_id, :created_at, :updated_at
json.url post_url(post, format: :json)
