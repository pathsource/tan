class Participation < ActiveRecord::Base

  belongs_to :user
  belongs_to :project

  enum status: [:doing, :quited, :finished]

end