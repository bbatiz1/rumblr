class CreateUser < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
    t.string :firstname
    t.string :lastname
    t.string :birthday
    t.string :email
    t.string :password
    end
  end
end
