class Subscription < ActiveRecord::Base
  belongs_to :user

  POSSIBLE_STATES = %W(active canceled)
  before_create :set_state

  scope :active, where(state: "active")

  private

  def set_state
    self.state = "active"
  end
end
