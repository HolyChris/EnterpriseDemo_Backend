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
      '54.200.157.85'
    elsif Rails.env.staging?
      '54.68.73.69'
    else
      'localhost:3000'
    end
  end

end