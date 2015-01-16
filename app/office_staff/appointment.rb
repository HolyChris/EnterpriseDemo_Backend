ActiveAdmin.register Appointment, namespace: 'office_staff' do
  belongs_to :site
  actions :index, :show, :edit, :create, :update, :new, :destroy
  scope :all, default: true
  permit_params :date, :start_time_string, :end_time_string, :notes, :user_id

  action_item 'Site', only: [:index] do
    link_to 'Site', admin_site_url(site)
  end

  controller do
  end

  index do
    column :date

    column 'Time' do |appointment|
      appointment.time_range_string
    end

    column :notes, sortable: false

    column 'Assigned To' do |appointment|
      appointment.assigned_to.email
    end

    column 'Created By' do |appointment|
      appointment.created_by.email
    end

    actions
  end

  filter :date
  filter :user_email, as: :string, placeholder: 'Email', label: 'Assigned To'

  show do
    attributes_table do
      row :date

      row 'Time' do |appointment|
        appointment.time_range_string
      end

      row :notes

      row 'Assigned To' do |appointment|
        appointment.assigned_to.email
      end

      row 'Created By' do |appointment|
        appointment.created_by.email
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Details' do
      f.input :date, as: :datepicker, input_html: {class: 'date-field'}
      f.input :start_time_string, required: true, input_html: {class: 'timepicker'}, label: 'Start Time'
      f.input :end_time_string, input_html: {class: 'timepicker'}, label: 'End Time'
      f.input :notes
      f.input :user_id, as: :select, collection: User.all.collect {|user| [user.email, user.id]  }, input_html: { class: "chosen-select" }, label: 'Assigned To'
    end

    f.submit
  end
end