class CustomerMailer < ActionMailer::Base
  default from: "support@startclosing.com"
  helper :mail

  def contract_created(site, customer)
    @customer = customer
    @site = site
    mail(to: @customer.email, subject: "Welcome to #{ENV['company_name'] || 'Start Closing'}")
  end
end
