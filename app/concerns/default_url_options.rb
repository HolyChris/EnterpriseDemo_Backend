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
      PRODUCTION_HOST
    elsif Rails.env.staging?
      STAGING_HOST
    else
      'localhost:3000'
    end
  end

end
