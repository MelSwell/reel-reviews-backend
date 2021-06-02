class ReviewSerializer < ActiveModel::Serializer 
  attributes :id, :rating, :written_review, :username, :user_id

  belongs_to :movie
end