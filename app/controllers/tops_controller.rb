class TopsController < ApplicationController
  before_action :require_logout, only: [:index]
  skip_before_action :require_logout, only: [:index]

  def index
  end

  private

  def require_logout
    if user_signed_in?
      redirect_to root_path, alert: 'ログアウトしてください'
    end
  end
end
