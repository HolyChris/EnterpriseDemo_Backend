object :@project

attributes :id, :po_number, :insurance_carrier, :re_roof_material, :color

node(:priority) { |project| Project::PRIORITY[project.priority] }
node(:cost) { |project| number_to_currency(project.cost) }
node(:material) {|project| Project::MATERIAL[project.material] }

child(:site) do
  attributes :id, :name, :damage, :roof_built_at, :insurance_company, :claim_number, :mortgage_company, :loan_tracking_number

  node(:source) {|site| Site::SOURCE[site.source]}
  node(:status) {|site| Site::STATUS[site.status]}
end