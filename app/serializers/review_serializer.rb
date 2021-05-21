class ReviewSerializer < ActiveModel::Serializer 
  attributes :id, :rating, :written_review

  belongs_to :movie
  belongs_to :user
end