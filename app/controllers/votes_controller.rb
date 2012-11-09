class VotesController < InheritedResources::Base
  belongs_to :tip

  def create
    vote = params[:vote] == "up" ? 1 : -1
    if parent.add_or_update_evaluation :votes, vote, current_user
      render text: t("reputation.vote_success"), status: :created
    else
      render text: t("reputation.vote_error"), status: :unprocessable_entity
    end
  end
end
