module DefaultUrlOptions

  # Including this file sets the default url options. This is useful for mailers or background jobs

  def default_url_options
    {
      :host => host
    }
  end

private

  def host
    if Rails.env.production?
      ENV["MAILER_HOST"] || '54.200.157.85'
    elsif Rails.env.staging?
      'eco-roof-and-solar.bitballoon.com'
      # 'endeavor-exteriors.bitballoon.com'
    else
      'localhost:3000'
    end
  end

end
