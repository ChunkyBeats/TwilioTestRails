class AddContactsTable < ActiveRecord::Migration
def change
  create_table :contacts do |t|
    t.column :first_name, :string
    t.column :last_name, :string
    t.column :phone, :string

    end
  end
end
