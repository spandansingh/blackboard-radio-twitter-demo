class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :text
      t.string :link
      t.string :user_id
      t.string :parent_post_id

      t.timestamps
    end
  end
end
