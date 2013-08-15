class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :contact_name
      t.string :contact_email
      t.string :contact_phone
      t.string :contact_title
      t.text :contact_message

      t.timestamps
    end
  end
end
