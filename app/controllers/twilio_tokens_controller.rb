class TwilioTokensController < ApplicationController
 # before_filter :authenticate!
  skip_before_filter  :verify_authenticity_token

  def get_token
    Twilio::Util::AccessToken.new(
      ENV['ACCOUNT_SID'],
      ENV['API_KEY_SID'],
      ENV['API_KEY_SECRET'],
      3600,
      "#{current_user.firstname} #{current_user.lastname}"
    )
  end

  def get_grant
    grant = Twilio::Util::AccessToken::IpMessagingGrant.new
    grant.endpoint_id = "Chatty:#{current_user.firstname} #{current_user.lastname}:browser"
    grant.service_sid = ENV['IPM_SERVICE_SID']
    grant
  end

  def create
    binding.pry

    if params["send_message"] == "true"
      send_sms_message
      return
    end

    token = get_token
    grant = get_grant
    token.add_grant(grant)
    render json: { username: "#{current_user.firstname} #{current_user.lastname}", token: token.to_jwt }
  end
  
  def send_sms

  end

  def send_sms_message
   sms_client.account.messages.create({
    :from => '+13016367652', 
    :to => '+12022103356', 
    :body => 'yo jesse! Twilio is tight', 
     }) 
  end

  private

  def sms_client
    @sms_client ||= Twilio::REST::Client.new(ENV["ACCOUNT_SID"], "7ff0b93b94a94aab404e4782ad7a13b1")
  end

  def ip_messaging_client
    @ip_messaging_client ||= Twilio::REST::IpMessagingClient.new(ENV["ACCOUNT_SID"], '7ff0b93b94a94aab404e4782ad7a13b1')
  end

end
