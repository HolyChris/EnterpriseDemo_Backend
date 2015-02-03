class CreateRoofAccessoryChecklists < ActiveRecord::Migration
  def change
    create_table :roof_accessory_checklists do |t|
      t.references :project
      t.string :open_soffits
      t.string :soffit_depth
      t.string :pipe_jacks_1_3
      t.string :pipe_jacks_4_5
      t.string :pitched_metal_jacks_collar_and_cap_diameter
      t.string :meter_mast_boot
      t.string :counter_flashing
      t.string :head_wall_4_5
      t.string :step_flashing
      t.string :large_step_flashing
      t.string :drip_2_4_color
      t.string :drip_2_4
      t.string :broan_bath_vent_4
      t.string :broan_vent_6
      t.string :slant_backs_turtle_t_vent
      t.string :solar_power_vent
      t.string :hard_wired_power_vent
      t.string :ridge_vent
      t.string :standard_ridge
      t.string :mid_ridge
      t.string :high_ridge
      t.string :chimney_1_size
      t.string :chimney_2_size
      t.string :build_cricket
      t.integer :access
      t.string :house_redeck_sq
      t.string :garage_redeck
      t.string :flat_redeck
      t.string :layers_house_comp
      t.string :layers_garage_comp
      t.string :layers_flat_comp
      t.string :layers_house_shake
      t.string :layers_garage_shake
      t.string :layers_flat_shake
      t.string :squares_house
      t.string :squares_garage
      t.string :squares_low_slope_2_12_4_12
      t.string :squares_flat_lt_2_12
      t.string :pitch_predominate
      t.string :pitch_steep_gt_8_12
      t.string :pitch_4_12_8_12
      t.string :pitch_2_12_4_12
      t.string :pitch_flat_lt_2_12
      t.string :d_r_gutters
      t.string :remove_gutters
      t.string :d_r_downspouts
      t.string :remove_downspouts

      t.timestamps
    end
  end
end
