class Page < ActiveRecord::Base

  belongs_to :subject
  has_and_belongs_to_many :editors,	:class_name=>"AdminUser"
  has_many	:sections
  
  before_validation  :default_permalink
  after_save  :touch_subject
  #before_create :admin_privileges

#   Validation Take place
  validates_presence_of :name
  validates_length_of	:name,:maximum=>50
  validates_presence_of :subject_id
  validates_uniqueness_of	:permalink
  
  #gem utilization
  acts_as_list  :scope => :subject

  
  scope :visible,	lambda {	where(:visible=>true)	}
  scope :invisible,	lambda {	where(:visible=>false)	}
  scope :sorted,	lambda {	order("pages.position ASC")	}
  scope :recent,	lambda {	order("pages.created_at DESC").limit(1)	}
  scope :search,	lambda { |se|	where(["name LIKE ?","%#{se}%"])	}
  
  private

  def default_permalink
    if permalink.blank?
      self.permalink = "#{id}-#{name.parameterize}"
    end
  end

  def touch_subject
    subject.touch
  end

  def admin_privileges
    # further study required
    # in this function we want only to create the page,subject and section
    # admin_type is of admin while admin_type user have only privilege to
    # login as user to visit the page
  end

end
