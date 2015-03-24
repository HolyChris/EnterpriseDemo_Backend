ActiveAdmin.register Image, namespace: 'sales_rep' do
  belongs_to :site
  scope :all, default: true

  actions :index, :show, :edit, :create, :update, :new, :destroy
  permit_params :alt, :title, :notes, :stage, :type, attachments_attributes: [:file, :_destroy, :id]

  controller do
  end

  index do
    column :title, sortable: false

    column 'Attachment' do |obj|
      obj.attachments.collect { |attachment| image_tag attachment.file.url, size: '100x100' }.join(' ').html_safe
    end

    column 'Relevant Stage', sortable: true do |obj|
      Site::STAGE.key(obj.stage).try(:capitalize) || '-'
    end

    column 'Alt Text' do |obj|
      obj.alt
    end

    column 'Additional Notes', sortable: false do |obj|
      obj.notes
    end

    actions
  end

  filter :stage, as: :select, collection: Site::STAGE.collect{|k,v| [k.to_s.capitalize, v]}

  show do
    attributes_table do
      row :title

      row 'Attachment' do |obj|
        obj.attachments.collect { |attachment| image_tag attachment.file.url, size: '100x100' }.join(' ').html_safe
      end

      row 'Relevant Stage' do |obj|
        Site::STAGE.key(obj.stage).try(:capitalize) || '-'
      end

      row 'Alt Text' do |obj|
        obj.alt
      end

      row 'Additional Notes' do |obj|
        obj.notes
      end
    end
  end

  form(html: { multipart: true }) do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs 'Details' do
      f.input :title
      f.has_many :attachments do |af|
        if af.object.persisted?
          af.input :file, required: true, as: :file, hint: "#{image_tag af.object.file.url, size: '100x100'}".html_safe
        else
          af.input :file, required: true, as: :file
        end
        af.input :_destroy, as: :boolean, label: 'Remove'
      end
      f.input :type, as: :hidden
      f.input :stage, as: :select, collection: Site::STAGE.collect{|k,v| [k.to_s.capitalize, v]}, label: 'Relevant Stage'
      f.input :alt, label: 'Alternative Text'
      f.input :notes, label: 'Additional Notes'
    end

    f.submit
  end
end