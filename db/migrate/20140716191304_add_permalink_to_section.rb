class AddPermalinkToSection < ActiveRecord::Migration
  def up
  	add_column 	"sections","permalink",:string,:after=>"visible",:length=>30,:null=>false
  end
  def down
  	remove_column "sections","permalink"
  end
end
