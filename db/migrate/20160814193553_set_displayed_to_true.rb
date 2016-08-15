class SetDisplayedToTrue < ActiveRecord::Migration[5.0]
  def change
  	ToDo.all.each do |t|
  		t.displayed = true
  		t.save!
  	end
  end
end
