module Api
  module V2
    class GenreSerializer < ActiveModel::Serializer
      attributes :id, :name, :movies_count
    end
  end
end
