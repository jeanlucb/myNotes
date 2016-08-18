class AddMainLinkToDocument < ActiveRecord::Migration[5.0]
  def change
  	add_column :documents, :main_link,  :string
  	add_column :documents, :use_main_link, :boolean, default: false
  end
end
