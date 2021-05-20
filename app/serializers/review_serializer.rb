class ReviewSerializer < ActiveModel::Serializer 
  attributes :id, :rating, :written_review, :movie
end