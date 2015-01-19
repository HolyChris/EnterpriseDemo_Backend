ActiveAdmin.register Asset do
  belongs_to :site
  scope :all, default: true
  scope :images
  scope :docs

  actions :index, :show, :edit, :create, :update, :new, :destroy
  before_filter :ensure_type, only: [:create, :update]
  permit_params :alt, :attachment, :description, :notes, :stage, :type

  controller do
    private
      def ensure_type
        if params[:asset][:type].blank?
          params[:asset][:type] = 'Document'
        end
      end
  end

  index do
    column 'Attachment' do |obj|
      if obj.document?
        link_to obj.attachment_file_name, obj.attachment.url, target: '_blank'
      else
        image_tag obj.attachment.url(:small)
      end
    end

    column 'Stage', sortable: true do |obj|
      Site::STAGE.key(obj.stage).try(:capitalize) || '-'
    end

    column 'Alt Text' do |obj|
      obj.alt
    end

    column :description, sortable: false
    column :notes, sortable: false

    actions
  end

  filter :stage, as: :select, collection: Site::STAGE.collect{|k,v| [k.to_s.capitalize, v]}

  show do
    attributes_table do
      row 'Attachment' do |obj|
        if obj.document?
          link_to obj.attachment_file_name, obj.attachment.url, target: '_blank'
        else
          image_tag obj.attachment.url(:large)
        end
      end

      row 'Stage' do |obj|
        Site::STAGE.key(obj.stage).try(:capitalize) || '-'
      end

      row 'Alt Text' do |obj|
        obj.alt
      end

      row :description
      row :notes
    end
  end

  form(html: { multipart: true }) do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs 'Details' do
      f.input :attachment, as: :file, required: true
      f.input :type, as: :select, collection: Asset::SUBCLASS.collect{|v| [v, v]}, include_blank: false
      f.input :stage, as: :select, collection: Site::STAGE.collect{|k,v| [k.to_s.capitalize, v]}
      f.input :alt, label: 'Alternative Text'
      f.input :description
      f.input :notes
    end

    f.submit
  end
end