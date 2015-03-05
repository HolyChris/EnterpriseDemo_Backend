class CreateOrderMaterials < ActiveRecord::Migration
  def change
    create_table :order_materials do |t|
      t.references :production
      t.string :pitch
      t.string :stories
      t.string :shingles
      t.string :ridge
      t.string :starter
      t.string :felt
      t.string :felt_color
      t.string :polystick
      t.string :mule_hide_cap_rolls
      t.string :mule_hide_base_rolls
      t.string :mule_hide_color
      t.string :decking
      t.string :deck_nails_8d_21_strip_boxes
      t.string :roof_nails_1_1_4_coil
      t.string :roof_nails_3_hand_ridge_vent
      t.string :plastic_cap
      t.string :drip_edge
      t.string :drip_edge_color
      t.string :flashing_step
      t.string :flashing_step_color
      t.string :flashing_counter
      t.string :flashing_counter_color
      t.string :flashing_headwall
      t.string :flashing_headwall_color
      t.string :w_valley
      t.string :valley_metal
      t.string :pipe_jacks
      t.string :attic_vents
      t.string :small_broan
      t.string :large_broan
      t.string :cap_collar
      t.string :paint
      t.string :caulk
      t.string :gaf_product
      t.string :gaf_color
      t.string :gaf_text
      t.text :other_information
      t.text :delivery_instructions
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
