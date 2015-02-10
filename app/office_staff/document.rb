ActiveAdmin.register Document, namespace: 'office_staff' do
  belongs_to :site
  scope :all, default: true

  actions :index, :show, :edit, :create, :update, :new, :destroy
  permit_params :alt, :doc_type, :title, :attachment, :notes, :stage, :type, attachment_attributes: [:file]

  controller do
  end

  index do
    column 'Doc Type', sortable: true do |obj|
      Asset::DOC_TYPE[obj.doc_type]
    end

    column :title, sortable: false

    column 'Attachment' do |obj|
      if obj.attachment
        link_to obj.attachment.file_file_name, obj.attachment.file.url, target: '_blank'
      end
    end

    column 'Stage', sortable: true do |obj|
      Site::STAGE.key(obj.stage).try(:capitalize) || '-'
    end

    column 'Alt Text' do |obj|
      obj.alt
    end

    column :notes, sortable: false

    actions
  end

  filter :doc_type, as: :select, collection: Asset::DOC_TYPE.collect{|k,v| [v, k]}
  filter :stage, as: :select, collection: Site::STAGE.collect{|k,v| [k.to_s.capitalize, v]}

  show do
    attributes_table do
      row 'Doc Type' do |obj|
        Asset::DOC_TYPE[obj.doc_type]
      end

      row :title

      row 'Attachment' do |obj|
        if obj.attachment
          link_to obj.attachment.file_file_name, obj.attachment.file.url, target: '_blank'
        end
      end

      row 'Stage' do |obj|
        Site::STAGE.key(obj.stage).try(:capitalize) || '-'
      end

      row 'Alt Text' do |obj|
        obj.alt
      end

      row :notes
    end
  end

  form(html: { multipart: true }) do |f|
    f.semantic_errors *f.object.errors.keys
    f.object.attachment || f.object.build_attachment
    f.inputs 'Details' do
      f.input :doc_type, as: :select, collection: Asset::DOC_TYPE.collect{|k,v| [v, k]}, include_blank: false
      f.input :title
      f.fields_for :attachment, required: true do |af|
        af.input :file, as: :file
      end
      f.input :type, as: :hidden
      f.input :stage, as: :select, collection: Site::STAGE.collect{|k,v| [k.to_s.capitalize, v]}
      f.input :alt, label: 'Alternative Text'
      f.input :notes
    end

    f.submit
  end
end