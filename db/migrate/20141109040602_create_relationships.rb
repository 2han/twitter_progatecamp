# class CreateRelationships < ActiveRecord::Migration
#   def change
#     create_table :relationships do |t|
#       t.integer :follower_id
#       t.integer :following_id

#       t.timestamps
#     end
#     add_index :relationships, :follower_id
#     add_index :relationships, :following_id
#     add_index :relationships, [:follower_id, :following_id], unique: true
#   end

# def change
#     create_table :relationships do |t|
#       t.integer :favorited_id
#       t.integer :favorites_id

#       t.timestamps
#     end
#     add_index :relationships, :favorited_id
#     add_index :relationships, :favorites_id
#     add_index :relationships, [:favorited_id, :favorites_id], unique: true
#   end


# end

class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :following_id

      t.timestamps
    end
    add_index :relationships, :follower_id
    add_index :relationships, :following_id
    add_index :relationships, [:follower_id, :following_id], unique: true
  end
end