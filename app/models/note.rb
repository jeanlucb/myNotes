class Note < ApplicationRecord
  belongs_to :user
  has_many :to_dos, dependent: :destroy
  has_many :documents
  acts_as_taggable

  def has_to_dos?
    if self.to_dos.length == 0
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

end
