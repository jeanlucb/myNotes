json.extract! to_do, :id, :title, :text, :status, :deadline, :displayed, :achieved, :user, :note, :created_at, :updated_at
json.url to_do_url(to_do, format: :json)