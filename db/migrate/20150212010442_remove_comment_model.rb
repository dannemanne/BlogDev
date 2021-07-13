class RemoveCommentModel < ActiveRecord::Migration[5.1]
  def up
    remove_index 'comments', ['ancestry']
    remove_index 'comments', ['post_id']
    remove_index 'comments', ['user_id']

    drop_table 'comments'
  end
  
  def down
    create_table 'comments', force: true do |t|
      t.integer  'user_id'
      t.integer  'post_id',     null: false
      t.string   'title'
      t.string   'message_old'
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.string   'ancestry'
      t.string   'name'
      t.string   'website'
      t.text     'message'
      t.boolean  'no_follow',   default: false, null: false
    end

    add_index 'comments', ['ancestry'], name: 'index_comments_on_ancestry', using: :btree
    add_index 'comments', ['post_id'], name: 'index_comments_on_post_id', using: :btree
    add_index 'comments', ['user_id'], name: 'index_comments_on_user_id', using: :btree
  end
  
end
