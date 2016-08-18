class Document < ApplicationRecord
  belongs_to :user
  belongs_to :note, optional: true

  acts_as_taggable

  mount_uploader :file, FileUploader

  def download_url
  	if self.use_main_link
  		return self.main_link
  	else
  		return self.file_url
  	end
  end
  
end
