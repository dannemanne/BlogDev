class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

private
  def load_user
    @user = current_user
  end

end
