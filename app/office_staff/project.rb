ActiveAdmin.register Project, namespace: 'office_staff' do
  belongs_to :site
  actions :show, :edit, :create, :update, :new
  permit_params :cost, :priority, :insurance_carrier, :re_roof_material, :color, :material

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
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Details' do
      f.input :priority, as: :select, collection: Project::PRIORITY.collect {|k,v| [v, k]}
      f.input :material, as: :select, collection: Project::MATERIAL.collect {|k,v| [v, k]}
      f.input :insurance_carrier
      f.input :re_roof_material, label: 'Re-Roof Material'
      f.input :color
      f.input :cost
    end

    f.submit
  end
end