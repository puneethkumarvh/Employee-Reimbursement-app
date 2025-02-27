Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
    {
      scope: 'userinfo.email,userinfo.profile,openid',
      redirect_uri: 'https://employee-reimbursement-app.onrender.com/auth/google_oauth2/callback',
      prompt: 'select_account'
    }
end
OmniAuth.config.allowed_request_methods = [:post, :get]
OmniAuth.config.silence_get_warning = true