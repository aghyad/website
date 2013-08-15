class Contact < ActiveRecord::Base
  attr_accessible :contact_email, :contact_message, :contact_name, :contact_phone, :contact_title
end
