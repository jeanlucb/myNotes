class ToDo < ApplicationRecord
	belongs_to :user
	belongs_to :note, optional: true
	acts_as_taggable

  
  def not_achieved?
    return not(self.achieved)
  end

  def label
    if self.achieved
      return "muted"
    end

    if self.deadline < Time.now	
      return "danger" # Too late
    else
      if self.deadline.today?
        return "warning" # For today
      else
        return "primary" # For later on
      end
    end
  end

end
