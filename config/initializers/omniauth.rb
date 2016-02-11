Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           '376005332334-ck4pbmipl876nlu5sd6358coub5m634a.apps.googleusercontent.com',
           'AcqZXnwX2Us1zxSRX65R0tfL'
end
