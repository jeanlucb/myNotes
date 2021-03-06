require 'elasticsearch/model'

class ToDo < ApplicationRecord
	belongs_to :user
	belongs_to :note, optional: true
	acts_as_taggable


  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  
  def not_achieved?
    return not(self.achieved)
  end


  def label
    if self.achieved
      return "default"
    end

    if self.deadline < Time.now	
      return "danger" # Too late
    else
      if self.deadline.today?
        return "warning" # For today
      else
        return "success" # For later on
      end
    end
  end

  def tag_to_text
    tag_list.map { |t| t}.join(' ')
  end


  def independent?
    if self.note_id.nil?
      return true
    else
      return false
    end
  end

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['title^10', 'text', 'tag_to_text']
          }
        }
      }
    )
  end

end

ToDo.import force: true
