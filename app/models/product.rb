class Product < ActiveRecord::Base
  include PgSearch

  pg_search_scope :search,
    against: {
      name: :A,
      description: :B
    },
    using: {
      tsearch: { dictionary: :english}
    }

  class << self
    def search_by params = {}
      params = params.try(:symbolize_keys) || {}

      collection = page(params[:page]) # <<< QUESTION: if its will be a query to base?
      # If yes - we need to use if-else
      if params[:term].present?
        collection = collection.where('name ILIKE ?', "#{params[:term]}%")
      end

      if params[:name].present?
        collection = collection.search(params[:name])
      end

      collection # <<< QUESTION
      #code
    end
  end
end
