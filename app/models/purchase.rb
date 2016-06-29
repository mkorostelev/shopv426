class Purchase < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  before_validation :fill_current_user



  def fill_current_user #<<<Question can`t get @current_user variable from MODEL
    # byebug
    # self.user_id = @current_user.id
  end
end
