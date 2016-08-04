json.extract! note, :id, :title, :summary, :text, :user_id, :created_at, :updated_at
json.url note_url(note, format: :json)