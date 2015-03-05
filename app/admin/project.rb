ActiveAdmin.register Project do
  menu false
  belongs_to :site
  actions :show, :edit, :create, :update, :new
  permit_params :cost, :priority, :insurance_carrier, :re_roof_material, :color, :material,
              roof_accessory_checklist_attributes: [ :id, :open_soffits, :soffit_depth, :pipe_jacks_1_3, :pipe_jacks_4_5,
              :pitched_metal_jacks_collar_and_cap_diameter, :meter_mast_boot, :counter_flashing, :head_wall_4_5,
              :step_flashing, :large_step_flashing, :drip_2_4_color, :drip_2_4, :broan_bath_vent_4, :broan_vent_6,
              :slant_backs_turtle_t_vent, :solar_power_vent, :hard_wired_power_vent, :ridge_vent, :standard_ridge,
              :mid_ridge, :high_ridge, :chimney_1_size, :chimney_2_size, :build_cricket, :access, :house_redeck_sq,
              :garage_redeck, :flat_redeck, :layers_house_comp, :layers_garage_comp, :layers_flat_comp,
              :layers_house_shake, :layers_garage_shake, :layers_flat_shake, :squares_house, :squares_garage,
              :squares_low_slope_2_12_4_12, :squares_flat_lt_2_12, :pitch_predominate, :pitch_steep_gt_8_12,
              :pitch_4_12_8_12, :pitch_2_12_4_12, :pitch_flat_lt_2_12, :d_r_gutters, :remove_gutters, :d_r_downspouts,
              :remove_downspouts, skylights_attributes: [:id, :existing, :curb_size, :od_frame_size, :new_skylight,
              :curb_mount, :deck_mount, :special_instructions, :_destroy] ], job_submission_attributes: [ :id, :po_legacy,
              :project_id, :shingle_color, :drip_color, :shingle_manufacturer, :shingle_type, :initial_payment,
              :initial_payment_date, :completion_payment, :completion_payment_date, :submitted_at, :work_type, :claim_number,
              :build_type, :deductible, :deductible_paid_date, :roof_work_rcv, :roof_work_acv,
              :roof_type_special_instructions, :hoa_approval_date, :initial_cost_per_sq, :mortgage_company,
              :loan_number, :mortgage_inspection_date, :supplement_required, :supplement_notes, :roof_rcv,
              :roof_acv, :roof_upgrade_cost, :roof_discount, :roof_total, :gutters_rcv, :gutters_acv, :gutters_upgrade_cost,
              :gutters_discount, :gutters_total, :siding_rcv, :siding_acv, :siding_upgrade_cost, :siding_discount,
              :siding_total, :windows_rcv, :windows_acv, :windows_upgrade_cost, :windows_discount, :windows_total,
              :paint_rcv, :paint_acv, :paint_upgrade_cost, :paint_discount, :paint_total, :hvac_rcv, :hvac_acv,
              :hvac_upgrade_cost, :hvac_discount, :hvac_total, :deposit_check_amount, :price_per_square,
              :building_code_upgrade_confirmed, :redeck, :depreciation_recoverable ]

  action_item 'Site', only: [:edit, :new, :show] do
    link_to 'Site', admin_site_url(site)
  end

  action_item 'Contract', only: [:edit, :show] do
    if project.contract.present?
      link_to 'Contract', admin_site_contract_url(project.site, project.contract)
    else
      link_to 'Create Contract', new_admin_site_contract_url(project.site)
    end
  end

  action_item 'Production', only: [:edit, :show] do
    if project.contract.present?
      if project.production.present?
        link_to 'Production', admin_site_production_url(project.site, project.production)
      else
        link_to 'Create Production', new_admin_site_production_url(project.site)
      end
    end
  end

  action_item 'Cancel', only: [:edit] do
    link_to 'Cancel', admin_site_project_url(site, project)
  end

  controller do
    def scoped_collection
      if @site = Site.find_by(id: params[:site_id])
        Project.where(site_id: @site.id)
      end
    end
  end

  show do
    attributes_table do
      row 'PO#' do
        project.po_number
      end

      row 'Priority' do
        Project::PRIORITY[project.priority]
      end

      row 'Cost' do
        number_to_currency(project.cost)
      end

      row :insurance_carrier
      row :re_roof_material
      row :color

      row 'Material' do
        Project::MATERIAL[project.material]
      end
    end

    if project.roof_accessory_checklist
      panel 'Roof Accessory Checklist' do
        attributes_table_for project.roof_accessory_checklist do
          row :open_soffits
          row :soffit_depth
          row '1"-3" Pipe Jacks' do |rac|
            rac.pipe_jacks_1_3
          end
          row '4"-5" Pipe Jacks' do |rac|
            rac.pipe_jacks_4_5
          end
          row :pitched_metal_jacks_collar_and_cap_diameter
          row :meter_mast_boot
          row :counter_flashing
          row '4"x5" Head-wall' do |rac|
            rac.head_wall_4_5
          end
          row :step_flashing
          row :large_step_flashing
          row 'Drip 2"x4" Color' do |rac|
            rac.drip_2_4_color
          end
          row 'Drip 2"x4"' do |rac|
            rac.drip_2_4
          end
          row 'Broan Bath Vent 4"' do |rac|
            rac.broan_bath_vent_4
          end
          row 'Broan Vent 6"' do |rac|
            rac.broan_vent_6
          end
          row 'Slant Backs/Turtle/T-vent' do |rac|
            rac.slant_backs_turtle_t_vent
          end
          row :solar_power_vent
          row :hard_wired_power_vent
          row :ridge_vent
          row :standard_ridge
          row :mid_ridge
          row :high_ridge
          row :chimney_1_size
          row :chimney_2_size
          row :build_cricket
          row 'Access' do |rac|
            RoofAccessoryChecklist::ACCESS[rac.access]
          end
          row :house_redeck_sq
          row :garage_redeck
          row :flat_redeck
          row :layers_house_comp
          row :layers_garage_comp
          row :layers_flat_comp
          row :layers_house_shake
          row :layers_garage_shake
          row :layers_flat_shake
          row 'Squares House SQ' do |rac|
            rac.squares_house
          end
          row 'Squares Garage SQ' do |rac|
            rac.squares_garage
          end
          row 'Squares Low Slope 2/12-4/12 SQ' do |rac|
            rac.squares_low_slope_2_12_4_12
          end
          row 'Squares Flat LT 2/12 SQ' do |rac|
            rac.squares_flat_lt_2_12
          end
          row 'Pitch Predominate SQ' do |rac|
            rac.pitch_predominate
          end
          row 'Pitch Steep GT 8/12 SQ' do |rac|
            rac.pitch_steep_gt_8_12
          end
          row 'Pitch 4/12-8/12 SQ' do |rac|
            rac.pitch_4_12_8_12
          end
          row 'Pitch 2/12-4/12 SQ' do |rac|
            rac.pitch_2_12_4_12
          end
          row 'Pitch Flat LT 2/12 SQ' do |rac|
            rac.pitch_flat_lt_2_12
          end
          row 'D&R Gutters' do |rac|
            rac.d_r_gutters
          end
          row :remove_gutters
          row 'D&R Downspouts' do |rac|
            rac.d_r_downspouts
          end
          row :remove_downspouts
        end
      end

      if project.roof_accessory_checklist.skylights.present?
        panel 'Skylights' do
          attributes_table_for project.roof_accessory_checklist.skylights do
            row :existing
            row :curb_size
            row :od_frame_size
            row :new_skylight
            row :curb_mount
            row :deck_mount
            row :special_instructions
          end
        end
      end
    end

    if project.job_submission
      panel 'Job Submission' do
        attributes_table_for project.job_submission  do
          row 'PO Legacy' do |js|
            js.po_legacy
          end
          row 'Shingle Color' do |js|
            JobSubmission::SHINGLE_COLOR[js.shingle_color]
          end
          row 'Drip Color' do |js|
            JobSubmission::DRIP_COLOR[js.drip_color]
          end
          row 'Shingle Manufacturer' do |js|
            JobSubmission::SHINGLE_MANUFACTURER[js.shingle_manufacturer]
          end
          row 'Shingle Type' do |js|
            JobSubmission::SHINGLE_TYPE[js.shingle_type]
          end
          row 'Initial Payment' do |js|
            number_to_currency(js.initial_payment)
          end
          row :initial_payment_date, as: :datepicker, input_html: {class: 'date-field'}
          row 'Completion Payment' do |js|
            number_to_currency(js.completion_payment)
          end
          row :completion_payment_date, as: :datepicker, input_html: {class: 'date-field'}
          row :submitted_at, as: :datepicker, input_html: {class: 'date-field'}
          row 'Type of Work to be Completed' do |js|
            JobSubmission::WORK_TYPE[js.work_type]
          end
          row :claim_number
          row :build_type
          row 'Deductible' do |js|
            number_to_currency(js.deductible)
          end
          row :deductible_paid_date
          row 'Roof Work RCV' do |js|
            number_to_currency(js.roof_work_rcv)
          end
          row 'Roof Work ACV' do |js|
            number_to_currency(js.roof_work_acv)
          end
          row :roof_type_special_instructions
          row :hoa_approval_date
          row 'Initial Cost per SQ' do |js|
            number_to_currency(js.initial_cost_per_sq)
          end
          row :mortgage_company
          row :loan_number
          row :mortgage_inspection_date
          row :supplement_required
          row :supplement_notes
          row 'Deposit Check Recieved' do |js|
            number_to_currency(js.deposit_check_amount)
          end
          row :price_per_square
          row :building_code_upgrade_confirmed
          row :redeck
          row :depreciation_recoverable
        end
      end

      panel 'Roof Details' do
        attributes_table_for project.job_submission  do
          row 'Roof RCV' do |js|
            number_to_currency(js.roof_rcv)
          end
          row 'Roof ACV' do |js|
            number_to_currency(js.roof_acv)
          end
          row 'Roof Upgrade Cost' do |js|
            number_to_currency(js.roof_upgrade_cost)
          end
          row 'Roof Discount' do |js|
            number_to_currency(js.roof_discount)
          end
          row 'Roof Total' do |js|
            number_to_currency(js.roof_total)
          end
        end
      end

      panel 'Gutter Details' do
        attributes_table_for project.job_submission  do
          row 'Gutters RCV' do |js|
            number_to_currency(js.gutters_rcv)
          end
          row 'Gutters ACV' do |js|
            number_to_currency(js.gutters_acv)
          end
          row 'Gutters Upgrade Cost' do |js|
            number_to_currency(js.gutters_upgrade_cost)
          end
          row 'Gutters Discount' do |js|
            number_to_currency(js.gutters_discount)
          end
          row 'Gutters Total' do |js|
            number_to_currency(js.gutters_total)
          end
        end
      end

      panel 'Siding Details' do
        attributes_table_for project.job_submission  do
          row 'Siding RCV' do |js|
            number_to_currency(js.siding_rcv)
          end
          row 'Siding ACV' do |js|
            number_to_currency(js.siding_acv)
          end
          row 'Siding Upgrade Cost' do |js|
            number_to_currency(js.siding_upgrade_cost)
          end
          row 'Siding Discount' do |js|
            number_to_currency(js.siding_discount)
          end
          row 'Siding Total' do |js|
            number_to_currency(js.siding_total)
          end
        end
      end

      panel 'Window Details' do
        attributes_table_for project.job_submission  do
          row 'Windows RCV' do |js|
            number_to_currency(js.windows_rcv)
          end
          row 'Windows ACV' do |js|
            number_to_currency(js.windows_acv)
          end
          row 'Windows Upgrade Cost' do |js|
            number_to_currency(js.windows_upgrade_cost)
          end
          row 'Windows Discount' do |js|
            number_to_currency(js.windows_discount)
          end
          row 'Windows Total' do |js|
            number_to_currency(js.windows_total)
          end
        end
      end

      panel 'Paint Details' do
        attributes_table_for project.job_submission  do
          row 'Paint RCV' do |js|
            number_to_currency(js.paint_rcv)
          end
          row 'Paint ACV' do |js|
            number_to_currency(js.paint_acv)
          end
          row 'Paint Upgrade Cost' do |js|
            number_to_currency(js.paint_upgrade_cost)
          end
          row 'Paint Discount' do |js|
            number_to_currency(js.paint_discount)
          end
          row 'Paint Total' do |js|
            number_to_currency(js.paint_total)
          end
        end
      end

      panel 'HVAC Details' do
        attributes_table_for project.job_submission  do
          row 'HVAC RCV' do |js|
            number_to_currency(js.hvac_rcv)
          end
          row 'HVAC ACV' do |js|
            number_to_currency(js.hvac_acv)
          end
          row 'HVAC Upgrade Cost' do |js|
            number_to_currency(js.hvac_upgrade_cost)
          end
          row 'HVAC Discount' do |js|
            number_to_currency(js.hvac_discount)
          end
          row 'HVAC Total' do |js|
            number_to_currency(js.hvac_total)
          end
        end
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    project = f.object

    f.inputs 'Details' do
      f.input :priority, as: :select, collection: Project::PRIORITY.collect {|k,v| [v, k]}
      f.input :material, as: :select, collection: Project::MATERIAL.collect {|k,v| [v, k]}
      f.input :insurance_carrier
      f.input :re_roof_material, label: 'Re-Roof Material'
      f.input :color, as: :string
      f.input :cost
    end

    project.roof_accessory_checklist || project.build_roof_accessory_checklist

    f.fields_for :roof_accessory_checklist do |racf|
      racf.inputs 'Roof Accessory Checklist' do
        racf.input :open_soffits
        racf.input :soffit_depth
        racf.input :pipe_jacks_1_3, label: '1"-3" Pipe Jacks'
        racf.input :pipe_jacks_4_5, label: '4"-5" Pipe Jacks'
        racf.input :pitched_metal_jacks_collar_and_cap_diameter
        racf.input :meter_mast_boot
        racf.input :counter_flashing
        racf.input :head_wall_4_5, label: '4"x5" Head-wall'
        racf.input :step_flashing
        racf.input :large_step_flashing
        racf.input :drip_2_4_color, as: :string, label: 'Drip 2"x4" Color'
        racf.input :drip_2_4, label: 'Drip 2"x4"'
        racf.input :broan_bath_vent_4, label: 'Broan Bath Vent 4"'
        racf.input :broan_vent_6, label: 'Broan Vent 6"'
        racf.input :slant_backs_turtle_t_vent, label: 'Slant Backs/Turtle/T-vent'
        racf.input :solar_power_vent
        racf.input :hard_wired_power_vent
        racf.input :ridge_vent
        racf.input :standard_ridge
        racf.input :mid_ridge
        racf.input :high_ridge
        racf.input :chimney_1_size
        racf.input :chimney_2_size
        racf.input :build_cricket
        racf.input :access, as: :select, collection: RoofAccessoryChecklist::ACCESS.collect {|k,v| [v, k]}
        racf.input :house_redeck_sq
        racf.input :garage_redeck
        racf.input :flat_redeck
        racf.input :layers_house_comp
        racf.input :layers_garage_comp
        racf.input :layers_flat_comp
        racf.input :layers_house_shake
        racf.input :layers_garage_shake
        racf.input :layers_flat_shake
        racf.input :squares_house, label: 'Squares House SQ'
        racf.input :squares_garage, label: 'Squares Garage SQ'
        racf.input :squares_low_slope_2_12_4_12, label: 'Squares Low Slope 2/12-4/12 SQ'
        racf.input :squares_flat_lt_2_12, label: 'Squares Flat LT 2/12 SQ'
        racf.input :pitch_predominate, label: 'Pitch Predominate SQ'
        racf.input :pitch_steep_gt_8_12, label: 'Pitch Steep GT 8/12 SQ'
        racf.input :pitch_4_12_8_12, label: 'Pitch 4/12-8/12 SQ'
        racf.input :pitch_2_12_4_12, label: 'Pitch 2/12-4/12 SQ'
        racf.input :pitch_flat_lt_2_12, label: 'Pitch Flat LT 2/12 SQ'
        racf.input :d_r_gutters, label: 'D&R Gutters'
        racf.input :remove_gutters
        racf.input :d_r_downspouts, label: 'D&R Downspouts'
        racf.input :remove_downspouts

        racf.has_many :skylights do |sf|
          sf.input :existing
          sf.input :curb_size
          sf.input :od_frame_size
          sf.input :new_skylight
          sf.input :curb_mount
          sf.input :deck_mount
          sf.input :special_instructions
          sf.input :_destroy, as: :boolean, required: false, label: t('remove')
        end
      end
    end

    project.job_submission || project.build_job_submission
    f.fields_for :job_submission do |jsf|
      jsf.inputs 'Job Submission' do
        jsf.input :po_legacy, label: 'PO Legacy'
        jsf.input :shingle_color, as: :select, collection: JobSubmission::SHINGLE_COLOR.collect {|k,v| [v, k]}
        jsf.input :drip_color, as: :select, collection: JobSubmission::DRIP_COLOR.collect {|k,v| [v, k]}
        jsf.input :shingle_manufacturer, as: :select, collection: JobSubmission::SHINGLE_MANUFACTURER.collect {|k,v| [v, k]}
        jsf.input :shingle_type, as: :select, collection: JobSubmission::SHINGLE_TYPE.collect {|k,v| [v, k]}
        jsf.input :initial_payment
        jsf.input :initial_payment_date, as: :datepicker, input_html: {class: 'date-field'}
        jsf.input :completion_payment
        jsf.input :completion_payment_date, as: :datepicker, input_html: {class: 'date-field'}
        jsf.input :submitted_at, as: :datepicker, input_html: {class: 'date-field'}
        jsf.input :work_type, as: :select, collection: JobSubmission::WORK_TYPE.collect {|k,v| [v, k]}
        jsf.input :claim_number
        jsf.input :build_type
        jsf.input :deductible
        jsf.input :deductible_paid_date, as: :datepicker, input_html: {class: 'date-field'}
        jsf.input :roof_work_rcv
        jsf.input :roof_work_acv
        jsf.input :roof_type_special_instructions
        jsf.input :hoa_approval_date, as: :datepicker, input_html: {class: 'date-field'}
        jsf.input :initial_cost_per_sq
        jsf.input :mortgage_company
        jsf.input :loan_number
        jsf.input :mortgage_inspection_date, as: :datepicker, input_html: {class: 'date-field'}
        jsf.input :supplement_required
        jsf.input :supplement_notes
        jsf.input :deposit_check_amount
        jsf.input :price_per_square
        jsf.input :building_code_upgrade_confirmed
        jsf.input :redeck
        jsf.input :depreciation_recoverable
        jsf.input :roof_rcv, label: 'Roof RCV'
        jsf.input :roof_acv, label: 'Roof ACV'
        jsf.input :roof_upgrade_cost
        jsf.input :roof_discount
        jsf.input :roof_total
        jsf.input :gutters_rcv, label: 'Gutters RCV'
        jsf.input :gutters_acv, label: 'Gutters ACV'
        jsf.input :gutters_upgrade_cost
        jsf.input :gutters_discount
        jsf.input :gutters_total
        jsf.input :siding_rcv, label: 'Siding RCV'
        jsf.input :siding_acv, label: 'Siding ACV'
        jsf.input :siding_upgrade_cost
        jsf.input :siding_discount
        jsf.input :siding_total
        jsf.input :windows_rcv, label: 'Windows RCV'
        jsf.input :windows_acv, label: 'Windows ACV'
        jsf.input :windows_upgrade_cost
        jsf.input :windows_discount
        jsf.input :windows_total
        jsf.input :paint_rcv, label: 'Paint RCV'
        jsf.input :paint_acv, label: 'Paint ACV'
        jsf.input :paint_upgrade_cost
        jsf.input :paint_discount
        jsf.input :paint_total
        jsf.input :hvac_rcv, label: 'HVAC RCV'
        jsf.input :hvac_acv, label: 'HVAC ACV'
        jsf.input :hvac_upgrade_cost
        jsf.input :hvac_discount
        jsf.input :hvac_total
      end
    end

    f.submit
  end
end