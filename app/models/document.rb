class Document < ApplicationRecord
  belongs_to :user
  belongs_to :note, optional: true

  mount_uploader :file, FileUploader
end
