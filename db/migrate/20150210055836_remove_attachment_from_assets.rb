class RemoveAttachmentFromAssets < ActiveRecord::Migration
  def change
    Asset.all.each do |asset|
      attachment = asset.attachments.build(file_width: asset.attachment_width, file_height: asset.attachment_height, file_file_size: asset.attachment_file_size, file_content_type: asset.attachment_content_type, file_file_name: asset.attachment_file_name, file_updated_at: asset.attachment_updated_at)
      attachment.save!
    end

    remove_column :assets, :attachment_width
    remove_column :assets, :attachment_height
    remove_column :assets, :attachment_file_size
    remove_column :assets, :attachment_content_type
    remove_column :assets, :attachment_file_name
    remove_column :assets, :attachment_updated_at
  end
end
