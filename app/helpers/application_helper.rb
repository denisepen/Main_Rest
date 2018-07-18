module ApplicationHelper
#   def current_user
#    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
#  end
#
#  def current_trip
#    @trip ||= Trip.find_by(id: session[:trip_id]) if session[:trip_id]
#  end
#
#  def logged_in?
#    !!current_user
#  end
#
#  def authenticate_user
#    if !logged_in?
#      redirect_to root_path
#    end
#  end
#
#    def is_admin?
#      if current_user.admin  #== true
#        true
#      else
#        false
#      end
#    end
end
