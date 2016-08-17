class SetFirstUserToAdmin < ActiveRecord::Migration[5.0]
  def change
  	User.first.update(admin: :true)
  end
end
