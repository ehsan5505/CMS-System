class Subject < ActiveRecord::Base
  
  has_many :pages
  
  validates_presence_of :name
  
  acts_as_list

  scope :visible,	lambda {	where(:visible=>true)	}
  scope :invisible,	lambda {	where(:visible=>false)	}
  scope :sorted,	lambda {	order("subjects.position ASC")	}
  scope :recent,	lambda {	order("subjects.created_at DESC").limit(1)	}
  scope :search,	lambda { |se|	where(["name LIKE ?","%#{se}%"])	}
  
end
