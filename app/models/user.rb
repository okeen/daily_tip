class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :tips, foreign_key: "author_id"
  has_many :subscriptions

  has_many :evaluations, class_name: ReputationSystem::Evaluation, as: :source

end
