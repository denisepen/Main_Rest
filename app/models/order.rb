class Order < ApplicationRecord
  belongs_to :trip
  belongs_to :meal

  # def add_to_order
  #   # raise session.inspect
  #   @meal = Meal.find_by(id: self.meal.id)
  #   user = User.find_by(id: self.user.id) #or current_user
  #
  #
  #   self.user.meals << @meal
  #   return "Meal added to Order"
  # end


end
