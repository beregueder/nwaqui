class Bookmark < ActiveRecord::Base
  belongs_to :user
  belongs_to :property

  validates_uniqueness_of :user, :scope => :property
end
