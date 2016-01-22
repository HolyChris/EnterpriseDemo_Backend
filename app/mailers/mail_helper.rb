module MailHelper

  def frontend_root_url
   'http://' +(ENV["MAILER_HOST"] || 'eco-roof-and-solar.bitballoon.com')
  end

  def company_name
    ENV['company_name'] || 'Start Closing'
    end

  def company_telephone
    ENV['company_telephone'] || '720.515.5795'
  end
end