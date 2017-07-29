class Group < ApplicationRecord
validates :title, presence: true
has_many :posts
belongs_to :user

has_many :group_relationships
has_many :members, :through => :group_relationships, :source => :user 

end
