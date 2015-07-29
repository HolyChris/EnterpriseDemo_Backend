module ApplicationHelper
  include MethodOrProcHelper
  include ::ActiveAdmin::ViewHelpers::FlashHelper
  include ::ActiveAdmin::ViewHelpers::ActiveAdminApplicationHelper

  def errors_for_field(object, field)
    if object.errors[field].any?
      content_tag :span, class: "error_field text-danger" do
        "#{object.errors[field].join(', ')}"
      end.html_safe
    end
  end

  def frontend_root_url
    'http://' +(ENV["MAILER_HOST"] || 'eco-roof-and-solar.bitballoon.com')
  end
end
