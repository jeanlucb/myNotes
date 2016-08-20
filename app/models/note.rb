require 'elasticsearch/model'

class Note < ApplicationRecord

  belongs_to :user
  has_many :to_dos, dependent: :destroy
  has_many :documents
  acts_as_taggable

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  def has_to_dos?
    if self.to_dos.length == 0
      return false
    else
      return true
    end
  end

  def has_documents?
    if self.documents.length == 0
      return false
    else
      return true
    end
  end
 

  def has_open_to_dos?
    open = false
    self.to_dos.each do |t|
      if t.not_achieved?
        open = true
      end
    end
    return open
  end

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['title^10', 'summary^5','text']
          }
        }
      }
    )
  end

end

Note.import force: true
