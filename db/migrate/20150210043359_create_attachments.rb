class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :asset
      t.integer :file_width
      t.integer :file_height
      t.integer :file_file_size
      t.string :file_content_type
      t.string :file_file_name
      t.datetime :file_updated_at

      t.timestamps
    end
  end
end
