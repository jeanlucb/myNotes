require 'elasticsearch/model'

class Document < ApplicationRecord
  belongs_to :user
  belongs_to :note, optional: true

  acts_as_taggable
  mount_uploader :file, FileUploader

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  def download_url
  	if self.use_main_link
  		return self.main_link
  	else
  		return self.file_url
  	end
  end

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['title^10', 'author^5', 'summary']
          }
        }
      }
    )
  end
  
end

Document.import force: true
