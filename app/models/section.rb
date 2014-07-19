class Section < ActiveRecord::Base
  
#   has_and_belongs_to_many	:pages
  has_many	:section_edits  
  has_many 	:editors,	:through=>:section_edits,	:class_name=>"AdminUser"
  belongs_to	:page
  
  before_save :touch_page
  before_validation :default_permalink

  # gem utilization
  acts_as_list   :scope  =>  :page

  #validatation take place
  CONTENT_TYPE = ['txt','html']
  validates_presence_of :name
  validates_length_of 	:name,:within =>5..50
  validates_presence_of :page_id
  validates_inclusion_of :content_type, :in=>CONTENT_TYPE,:message=>"Type must be #{CONTENT_TYPE.split(", ")}."
  validates_presence_of :content
  
  
  
  scope :visible,	lambda {	where(:visible=>true)	}
  scope :invisible,	lambda {	where(:visible=>false)	}
  scope :sorted,	lambda {	order("sections.position ASC")	}
  scope :recent,	lambda {	order("sections.created_at DESC").limit(1)	}
  scope :search,	lambda { |se|	where(["name LIKE ?","%#{se}%"])	}
  
private

  def default_permalink
    if permalink.blank?
      self.permalink="#{id}-#{name.parameterize}"
    end
  end

  def touch_page
    page.touch
  end

  def admin_privileges
    # further study required
    # in this function we want only to create the page,subject and section
    # admin_type is of admin while admin_type user have only privilege to
    # login as user to visit the page
  end

end
