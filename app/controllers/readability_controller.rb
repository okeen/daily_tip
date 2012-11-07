class ReadabilityController < ApplicationController
  def show
    @link = Link.find(params[:id])
    render text: @link.to_readable_article
  end
end