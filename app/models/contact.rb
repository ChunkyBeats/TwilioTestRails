class Contact < ActiveRecord::Base

  validates_presence_of :first_name, presence: true
  validates_presence_of :last_name
  validates_presence_of :phone, presence: true

end
