class SessionsController < ApplicationController
    def google_auth
        user_info = request.env['omniauth.auth']
        p response.inspect
        p user_info.inspect
        Rails.logger.debug("Google OAuth Response: #{response.inspect}")
        Rails.logger.debug("User Info: #{user_info.inspect}")

        # Extract necessary fields from the user info
        google_id = user_info['uid']
        email = user_info['info']['email']
        name = user_info['info']['name']

        # Find or create the user
        user = User.find_or_initialize_by(google_id: google_id)
        user.assign_attributes(email: email, name: name)

        if user.save
            # Set session if user successfully saved
            session[:user_id] = user.id
            redirect_to companies_path, notice: "Signed in as #{user.name}"
        else
            # Handle validation errors
            redirect_to root_path, alert: "Failed to sign in: #{user.errors.full_messages.join(', ')}"
        end
      end
    
      def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: 'Logged out!'
      end
end
