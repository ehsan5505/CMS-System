class CreateAdminUsers < ActiveRecord::Migration
  def up
    create_table :admin_users do |t|
      t.string		:first_name,	:limit=>30
      t.string		:last_name,	:limit=>30
      t.string		:email,		:default=>"",:null=>false,:limit=>100
      t.string		:username,	:limit=>40
      t.string		:hashed_password,	:limit=>40
      t.timestamps
    end
    add_index("admin_users","username")
  end
  
  def down
    drop_table :admin_users
  end
end
