module Bestie
  module Repositories
    module Catalogs
      module Concerns
        module ModelCachingExtention
          extend ActiveSupport::Concern

          included do
            # The first time you call Model.all_cached it will cache the collection,
            # each consequent call will not fire the DB query
            def all_cached
              Rails.cache.fetch("cached_#{self.class.name.underscore.to_s.gsub("/", "_")}") { @db_client.all.load }
            end

            private

            # Making sure, that data is in consistent state by removing the cache
            # everytime, the table is touched (eg some record is edited/created/destroyed etc).
            def clear_cache
              Rails.cache.delete("cached_#{self.class.name.underscore.to_s.gsub("/", "_")}")
            end
          end
        end
      end
    end
  end
end
