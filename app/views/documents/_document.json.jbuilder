json.extract! document, :id, :title, :author, :summary, :user_id, :note_id, :created_at, :updated_at
json.url document_url(document, format: :json)