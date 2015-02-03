class CreateSkylights < ActiveRecord::Migration
  def change
    create_table :skylights do |t|
      t.references :roof_accessory_checklist
      t.string :existing
      t.string :curb_size
      t.string :od_frame_size
      t.string :new_skylight
      t.string :curb_mount
      t.string :deck_mount
      t.text :special_instructions

      t.timestamps
    end
  end
end
