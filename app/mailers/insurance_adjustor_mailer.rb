class InsuranceAdjustorMailer < ActionMailer::Base
  default from: "support@startclosing.com"
  helper :mail

  def contract_created(site, adjustor)
    @site = site
    @adjustor = adjustor
    mail(to: @adjustor.email, subject: "Welcome to #{ENV['company_name'] || 'Start Closing'}")
  end
end
