ActiveAdmin.register Document, namespace: 'sales_rep' do
  belongs_to :site
  scope :all, default: true

  actions :index, :show, :edit, :create, :update, :new, :destroy
  permit_params :doc_type, :title, :attachment, :notes, :stage, :type, attachments_attributes: [:file, :id, :_destroy]

  controller do
  end

  index do
    column 'Doc Type', sortable: true do |obj|
      Asset::DOC_TYPE[obj.doc_type]
    end

    column :title, sortable: false

    column 'Attachment' do |obj|
      obj.attachments.collect { |attachment| link_to attachment.file_file_name, attachment.file.url, target: '_blank' }.join(', ').html_safe
    end

    column 'Stage', sortable: true do |obj|
      Site::STAGE.key(obj.stage).try(:capitalize) || '-'
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
        obj.attachments.collect { |attachment| link_to attachment.file_file_name, attachment.file.url, target: '_blank' }.join(', ').html_safe
      end

      row 'Stage' do |obj|
        Site::STAGE.key(obj.stage).try(:capitalize) || '-'
      end

      row :notes
    end
  end

  form(html: { multipart: true }) do |f|
    f.semantic_errors *f.object.errors.keys
    f.object.attachments.present? || f.object.attachments.build
    f.inputs 'Details' do
      f.input :doc_type, required: true, as: :select, collection: Asset::DOC_TYPE.collect{|k,v| [v, k]}, include_blank: false
      f.input :title
      f.fields_for :attachments do |af|
        if af.object.persisted?
          af.input :file, required: true, as: :file, hint: "#{link_to af.object.file_file_name, af.object.file.url, target: '_blank'}".html_safe
        else
          af.input :file, required: true, as: :file
        end
      end
      f.input :type, as: :hidden
      f.input :stage, as: :select, collection: Site::STAGE.collect{|k,v| [k.to_s.capitalize, v]}
      f.input :notes
    end

    f.submit
  end
end