module ApplicationHelper

  def login_helper
    if !logged_in?
      (link_to "sign up", new_user_path, method: 'get') + " | " +
      (link_to "sign in", signin_path , method: 'get') + " | " +
      (link_to('log in with Facebook', '/auth/facebook'))
    else
      (link_to current_user.named, user_path(current_user)) + " | " +
      (link_to "Total: #{number_to_currency(session[:total])}", trip_path(session[:trip_id]) if session[:trip_id]) + " | " +
      (link_to "log out", logout_path , method: 'post')
    end
  end


  def admin_items
    if logged_in? && is_admin?
       # 'ADMIN' + " | " +
       (link_to "ADMIN  |  Add New Meal", new_meal_path) + " |  "  +
       (link_to "Customer Orders", trips_path)
       end
  end


  # #<% if current_user && current_user.admin %>
  #   <li class='nav'><%= "ADMIN"  %></li>
  # <% end %>
  # <%# if current_user %>
  #   <% if is_admin? %>
  #     <li><%= link_to "Add New Meal", new_meal_path %></li>
  #     <li><%= link_to "Customer Orders", trips_path %></li>
  #   <% end %>

  # <% if !logged_in? %>
  #   <li><%=  link_to "sign up", new_user_path, method: 'get' %></li>
  #   <li><%=  link_to "sign in", signin_path , method: 'get'%></li>
  #   <li><%=  link_to('log in with Facebook', '/auth/facebook') %></li>
  # <% else %>
  #   <li> <%= link_to "log Out", logout_path , method: 'post'%> </li>
  # <% end %>
  #
  # <% if current_user %>
  #   <li class='nav'><%= link_to current_user.named, user_path(current_user) %></li>
  #
  #   <% if current_user.trips %>
  #     <li><%= link_to "Total: #{number_to_currency(session[:total])}", trip_path(session[:trip_id]) if session[:trip_id] %></li>
  #   <% end %>
  # <% end %>
end
