class Document < ApplicationRecord
  belongs_to :user
  belongs_to :note, optional: true

  acts_as_taggable

  mount_uploader :file, FileUploader
end
