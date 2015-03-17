ActiveAdmin.register Appointment, namespace: 'office_staff' do
  belongs_to :site
  actions :index, :show, :edit, :create, :update, :new, :destroy
  scope :all, default: true
  permit_params :scheduled_at_date, :scheduled_at_time_hour, :scheduled_at_time_minute, :outcome, :notes, :user_id, follow_ups_attributes: [:scheduled_at_date, :scheduled_at_time_hour, :scheduled_at_time_minute, :notes, :id, :_destroy]

  action_item 'Site', only: [:index] do
    link_to 'Site', office_staff_site_url(site)
  end

  controller do
  end

  index do
    column :scheduled_at

    column 'Outcome' do |appointment|
      appointment.outcome_string
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

  filter :scheduled_at
  filter :outcome, as: :select, collection: Appointment::OUTCOMES.collect { |k,v| [v, k] }
  filter :user_email, as: :string, placeholder: 'Email', label: 'Assigned To'

  show do
    attributes_table do
      row :scheduled_at

      row 'Outcome' do |appointment|
        appointment.outcome_string
      end

      row :notes

      row 'Assigned To' do |appointment|
        appointment.assigned_to.email
      end

      row 'Created By' do |appointment|
        appointment.created_by.email
      end
    end

    if appointment.follow_ups.present?
      panel 'Follow Ups' do
        attributes_table_for appointment.follow_ups do
          row :scheduled_at
          row :notes
        end
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Details' do
      f.input :scheduled_at, as: :just_datetime_picker
      f.input :outcome, as: :select, collection: Appointment::OUTCOMES.collect { |k, v| [v, k] }, input_html: { class: "chosen-select" }
      f.input :notes
      f.input :user_id, as: :select, collection: f.object.site.managers.collect {|user| [user.email, user.id]  }, input_html: { class: "chosen-select" }, label: 'Assigned To'

      f.has_many :follow_ups do |fuf|
        fuf.input :scheduled_at, as: :just_datetime_picker
        fuf.input :notes
        fuf.input :_destroy, as: :boolean, label: 'Remove'
      end
    end

    f.submit
  end
end