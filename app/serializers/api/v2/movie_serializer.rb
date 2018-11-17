module Api
  module V2
    class MovieSerializer < ActiveModel::Serializer
      attributes :id, :title

      has_one :genre, serializer: GenreSerializer
    end
  end
end
