class ErrorsController < ApplicationController

  # Not Found_404
  def not_found_404
    render status: 404
  end

  # Not Acceptable_406
  # def not_acceptable
  #   render status: 406
  # end

  # Unprocessable Entity_422
  # def unprocessable
  #   render status: 422
  # end

  # Internal Server Error_500
  # def internal_server
  #   render status: 500
  # end
end
