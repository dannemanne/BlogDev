class ProfilesController < ApplicationController
  before_filter :authenticate_user!

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

  def update
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
