class TopCommentatorsController < ApplicationController
  def index
    service = TopCommentators::GetList.perform!
    @top_commentators = service.results
  end
end
