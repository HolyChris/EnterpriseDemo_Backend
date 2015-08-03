module MailHelper

  def frontend_root_url
   'http://' +(ENV["MAILER_HOST"] || 'eco-roof-and-solar.bitballoon.com')
  end

end