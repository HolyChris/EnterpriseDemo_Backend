ActiveAdmin.register User do
  actions :index, :show, :create, :new, :edit, :update
  scope :all, :default => true
  permit_params :email, role_ids: []

  controller do
  end

  index do
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :roles do |user|
      user.roles.pluck(:name).join(', ')
    end
    actions
  end

  filter :roles
  filter :email

  show do
    attributes_table do
      row :email
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
    end
  end

  form do |f|
    user = f.object
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Details' do
      f.input :email, input_html: { disabled: user.persisted? }
      f.inputs 'Roles' do
        html = []
        Role.all.each do |role|
          span do
            check_box_tag("user[role_ids][]", role.id, user.has_role?(role.name))
          end
          f.label(:role_ids, role.name)
        end
      end
    end
    f.submit
  end
end