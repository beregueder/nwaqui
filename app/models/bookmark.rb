class Bookmark < ActiveRecord::Base
  belongs_to :user, class_name: 'Site::ExternalUser'
  belongs_to :property

  validates_uniqueness_of :user, :scope => :property

end
