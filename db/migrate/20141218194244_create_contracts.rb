class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string :document_file_name
      t.integer :document_file_size
      t.string :document_content_type
      t.datetime :document_updated_at
      t.datetime :signed_at
      t.integer :site_id
      t.decimal :price, precision: 10, scale: 2
      t.decimal :paid_till_now, precision: 10, scale: 2
      t.text :notes
      t.text :special_instructions
      t.datetime :construction_start_at
      t.datetime :construction_end_at
      t.datetime :construction_payment_at
      t.string :ers_sign_image_file_name
      t.integer :ers_sign_image_file_size
      t.string :ers_sign_image_content_type
      t.datetime :ers_sign_image_updated_at
      t.string :customer_sign_image_file_name
      t.integer :customer_sign_image_file_size
      t.string :customer_sign_image_content_type
      t.datetime :customer_sign_image_updated_at

      t.timestamps
    end

    add_index :contracts, :site_id
  end
end
