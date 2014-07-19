class AdminUser < ActiveRecord::Base

  has_and_belongs_to_many	:pages
  has_many	:section_edits
  has_many	:sections,	:through => :section_edits


#   Password Security
  has_secure_password
  
#   Validation take place
  validates_presence_of	:first_name
  validates_presence_of :last_name
  validates_presence_of	:username
  validates_presence_of :email
  
  validates_length_of 	:first_name, 	:within =>5..25
  validates_length_of	:last_name,	:within =>3..25
  validates_length_of	:username,	:minimum =>5,:maximum => 30
  
  validates_uniqueness_of	:username
  
  scope   :sortedByUsername,  lambda  {   order("username ASC")  }
  scope   :sorted,  lambda  {   order("first_name ASC","last_name ASC")  }  

  def name
    return "#{first_name} #{last_name}"
  end

end
