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
      # 'localhost:3000'
    elsif Rails.env.staging?
      # 'localhost:3000'
    else
      'http://asdasdsa.com'
    end
  end

end