ActiveAdmin.register Site, namespace: 'office_staff' do
  belongs_to :customer, optional: true

  actions :index, :show, :edit, :create, :update, :new
  scope :all, default: true
  permit_params :name, :source, :damage, :status, :roof_built_at, :insurance_company, :claim_number, :mortgage_company, :loan_tracking_number, manager_ids: [], address_attributes: [:id, :address1, :address2, :city, :state_id, :zipcode, :customer_id]
  before_filter :ensure_manager, only: [:create, :update]

  controller do
    private
      def ensure_manager
        params[:site][:manager_ids] ||= []
        params[:site][:manager_ids] << current_user.id.to_s if params[:site][:manager_ids].all?(&:blank?)
      end
  end

  index do
    column :name
    column 'Managers' do |site|
      site.managers.pluck(:email).join(', ')
    end

    column 'Source' do |site|
      Site::SOURCE[site.status]
    end

    column 'Status' do |site|
      Site::STATUS[site.status]
    end
    column 'Address' do |site|
      site.address.full_address
    end

    actions
  end

  filter :name
  filter :customer_email, as: :string
  filter :managers_id, as: :select, collection: User.all.collect { |u| [u.email, u.id] }, label: 'Manager'
  filter :source, as: :select, collection: Site::SOURCE.collect {|k,v| [v,k]}
  filter :status, as: :select, collection: Site::STATUS.collect {|k,v| [v,k]}
  filter :address_address1, as: :string, label: 'Address1'
  filter :address_address2, as: :string, label: 'Address2'
  filter :address_city, as: :string, label: 'City'
  filter :address_state_id, as: :select, collection: Country.default.states.collect {|s| [s.name,s.id]}, label: 'State'
  filter :address_zipcode, as: :string, label: 'Zipcode'

  show do
    attributes_table do
      row :name

      row 'Managers' do |site|
        site.managers.pluck(:email).join(', ')
      end

      row :stage

      row 'Address' do |site|
        site.address.full_address
      end

      row 'Source' do |site|
        Site::SOURCE[site.status]
      end

      row :damage
      row 'Status' do |site|
        Site::STATUS[site.status]
      end
      row :roof_built_at
      row :insurance_company
      row :claim_number, label: 'Claim #'
      row :mortgage_company
      row :loan_tracking_number, 'Loan Tracking #'
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Details' do
      f.input :name
      f.input :manager_ids, as: :select, collection: User.all.collect {|user| [user.email, user.id]  }, multiple: true, input_html: { class: "chosen-select" }, label: 'Managers'
      f.input :source, as: :select, collection: Site::SOURCE.collect{|k,v| [v, k]}
      f.input :damage
      f.input :status, as: :select, collection: Site::STATUS.collect{|k,v| [v, k]}
      f.input :roof_built_at
      f.input :insurance_company
      f.input :claim_number
      f.input :mortgage_company
      f.input :loan_tracking_number

      f.object.address ||= Address.new

      f.inputs 'Address' do
        f.fields_for :address do |af|
          if params[:customer_id]
            af.input :customer_id, as: :hidden, input_html: { value: params[:customer_id] }
          else
            af.input :customer_id, as: :select, collection: Customer.all.collect { |customer| [customer.fullname, customer.id] }
          end

          af.input :address1
          af.input :address2
          af.input :city
          af.input :state_id, as: :select, collection: State.all.collect {|state| [state.name, state.id]  }
          af.input :zipcode
        end
      end
    end

    f.submit
  end
end