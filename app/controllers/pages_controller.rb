class PagesController < ApplicationController
  def show
    render action: params[:page].gsub(%r{[^a-z0-9_/]}i, '')
  end
end
