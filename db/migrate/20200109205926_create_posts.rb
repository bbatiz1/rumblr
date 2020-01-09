class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
    t.string :topic
    t.string :body
    t.integer :user_id
    end
  end
end
