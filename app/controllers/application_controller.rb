class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :is_admin?, :is_user?, :is_superadmin?
	SUPER_ADMIN = "SuperAdmin"
	ADMIN = "Admin"
	USER = "User"

  private

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
	    @current_user = current_user_session && current_user_session.record
    end

    def require_user
      unless current_user
        redirect_to login_path
      end
    end

    def require_superadmin
      unless session[:user_role] == SUPER_ADMIN
        redirect_to login_path
      end
    end    
    
    def require_admin
      unless session[:user_role] == ADMIN
        redirect_to login_path
      end
    end    

    def authenticate_email(email)
      user = User.where(:email => email).first
      if user
			  return user
	    end
	    return false
    end

    def authenticate_change_password(password)
        user_exists = User.exists?(password: password)
        if user_exists
		  user = User.find_by_password(password)
		  return user
	    end
	    return false
    end

	  def is_admin?
		  session[:user_role] == ADMIN
	  end

    def is_user?
	   session[:user_role] == USER
    end

    def is_superadmin?
	   session[:user_role] == SUPER_ADMIN
    end

end
