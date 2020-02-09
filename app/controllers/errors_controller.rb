class ErrorsController < ApplicationController

  def not_found
    render status: :not_found
  end

  def unacceptable
    render status: :unacceptable
  end

  def internal_error
    render status: :internal_error
  end

end
