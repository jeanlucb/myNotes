class Document < ApplicationRecord
  belongs_to :user
  belongs_to :note, optional: true
end
