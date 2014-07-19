class AddAdminTypeInAdminUser < ActiveRecord::Migration
  def up
  	add_column "admin_users","admin_type",:string,:length=>15,:default=>"user",:null=>false
  end

  def down
  	remove_column "admin_users","admin_type"
  end

end
