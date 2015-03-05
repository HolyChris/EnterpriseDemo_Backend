ActiveAdmin.register Production, namespace: 'office_staff' do
  menu false
  belongs_to :site
  actions :show, :edit, :create, :update, :new
  permit_params :delivery_date, :production_date, :roof_built_date, :production_inspection_date,
                :production_inspection_passed_date, :materials_not_used, :permit_number, :permit_date, :permit_department,
                order_material_attributes: [:id, :pitch, :stories, :shingles, :ridge, :starter, :felt, :felt_color, :polystick, :mule_hide_cap_rolls, :mule_hide_base_rolls, :mule_hide_color, :decking, :deck_nails_8d_21_strip_boxes, :roof_nails_1_1_4_coil, :roof_nails_3_hand_ridge_vent, :plastic_cap, :drip_edge, :drip_edge_color, :flashing_step, :flashing_step_color, :flashing_counter, :flashing_counter_color, :flashing_headwall, :flashing_headwall_color, :w_valley, :valley_metal, :pipe_jacks, :attic_vents, :small_broan, :large_broan, :cap_collar, :paint, :caulk, :gaf_product, :gaf_color, :gaf_text, :other_information, :delivery_instructions]

  action_item 'Site', only: [:edit, :new, :show] do
    link_to 'Site', office_staff_site_url(site)
  end

  action_item 'Contract', only: [:edit, :new, :show] do
    link_to 'Contract', office_staff_site_contract_url(site, production.contract)
  end

  action_item 'Project', only: [:edit, :new, :show] do
    link_to 'Project', office_staff_site_project_url(site, production.project)
  end

  action_item 'Cancel', only: [:edit] do
    link_to 'Cancel', office_staff_site_production_url(site, production)
  end

  controller do
    def scoped_collection
      if @site = Site.find_by(id: params[:site_id])
        Production.where(site_id: @site.id)
      end
    end
  end

  show do
    attributes_table do
      row :delivery_date
      row :production_date
      row :roof_built_date
      row :production_inspection_date
      row :production_inspection_passed_date
      row :materials_not_used
      row :permit_number
      row :permit_date
      row :permit_department
    end

    if production.order_material
      panel 'Materials Ordering Details' do
        attributes_table_for production.order_material do
          row :pitch
          row :stories
          row :shingles
          row :ridge
          row :starter
          row :felt
          row :felt_color
          row :polystick
          row :mule_hide_cap_rolls
          row :mule_hide_base_rolls
          row :mule_hide_color
          row :decking
          row 'Deck Nails 8D 21* Strip boxes' do |production|
            production.deck_nails_8d_21_strip_boxes
          end
          row 'Roof Nails 1 1/4 Coil' do |production|
            production.roof_nails_1_1_4_coil
          end
          row 'Roof Nails 3" Hand (ridge vent)' do |production|
            production.roof_nails_3_hand_ridge_vent
          end
          row :plastic_cap
          row :drip_edge
          row :drip_edge_color
          row :flashing_step
          row :flashing_step_color
          row :flashing_counter
          row :flashing_counter_color
          row :flashing_headwall
          row :flashing_headwall_color
          row :w_valley
          row :valley_metal
          row :pipe_jacks
          row :attic_vents
          row :small_broan
          row :large_broan
          row 'Cap/Collar' do |production|
            production.cap_collar
          end
          row :paint
          row :caulk
          row 'GAF Product' do |production|
            production.gaf_product
          end
          row 'GAF Color' do |production|
            production.gaf_color
          end
          row 'GAF Text' do |production|
            production.gaf_text
          end
          row :other_information
          row :delivery_instructions
        end
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    project = f.object

    f.inputs 'Details' do
      f.input :delivery_date, as: :datepicker, input_html: {class: 'date-field'}
      f.input :production_date, as: :datepicker, input_html: {class: 'date-field'}
      f.input :roof_built_date, as: :datepicker, input_html: {class: 'date-field'}
      f.input :production_inspection_date, as: :datepicker, input_html: {class: 'date-field'}
      f.input :production_inspection_passed_date, as: :datepicker, input_html: {class: 'date-field'}
      f.input :materials_not_used
      f.input :permit_number
      f.input :permit_date, as: :datepicker, input_html: {class: 'date-field'}
      f.input :permit_department
    end

    production.order_material || production.build_order_material

    f.fields_for :order_material do |omf|
      omf.inputs 'Materials Ordering' do
        omf.input :pitch
        omf.input :stories
        omf.input :shingles
        omf.input :ridge
        omf.input :starter
        omf.input :felt
        omf.input :felt_color, as: :string
        omf.input :polystick
        omf.input :mule_hide_cap_rolls
        omf.input :mule_hide_base_rolls
        omf.input :mule_hide_color, as: :string
        omf.input :decking
        omf.input :deck_nails_8d_21_strip_boxes, label: 'Deck Nails 8D 21* Strip boxes'
        omf.input :roof_nails_1_1_4_coil, label: 'Roof Nails 1 1/4 Coil'
        omf.input :roof_nails_3_hand_ridge_vent, label: 'Roof Nails 3" Hand (ridge vent)'
        omf.input :plastic_cap
        omf.input :drip_edge
        omf.input :drip_edge_color, as: :string
        omf.input :flashing_step
        omf.input :flashing_step_color, as: :string
        omf.input :flashing_counter
        omf.input :flashing_counter_color, as: :string
        omf.input :flashing_headwall
        omf.input :flashing_headwall_color, as: :string
        omf.input :w_valley
        omf.input :valley_metal
        omf.input :pipe_jacks
        omf.input :attic_vents
        omf.input :small_broan
        omf.input :large_broan
        omf.input :cap_collar, label: 'Cap/Collar'
        omf.input :paint
        omf.input :caulk
        omf.input :gaf_product, label: 'GAF Product'
        omf.input :gaf_color, as: :string, label: 'GAF Color'
        omf.input :gaf_text, label: 'GAF Text'
        omf.input :other_information
        omf.input :delivery_instructions
      end
    end

    f.submit
  end
end