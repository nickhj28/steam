module Locomotive::Steam
  module Models

    module Repository

      extend ActiveSupport::Concern
      extend Forwardable

      class RecordNotFound < StandardError; end

      attr_accessor :adapter, :scope

      def_delegators :@scope, :site, :site=, :locale, :locale=

      def initialize(adapter, site = nil, locale = nil)
        @adapter  = adapter
        @scope    = Scope.new(site, locale)
      end

      def find(id)
        adapter.find(mapper, scope, id)
      end

      def query(&block)
        adapter.query(mapper, scope, &block)
      end

      def first(&block)
        adapter.query(mapper, scope, &block).first
      end

      alias :all :query

      # def create(entity)
      #   entity.id = adapter.create(collection_name, entity)
      # end

      # def persisted?(entity)
      #   !!entity.id && adapter.persisted?(collection_name, entity)
      # end

      # def update(entity)
      #   adapter.update(collection_name, entity)
      # end

      # def destroy(entity)
      #   adapter.destroy(collection_name, entity)
      # end

      def mapper
        name, options, block = mapper_options
        @mapper ||= Mapper.new(name, options, self, &block)
      end


      # TODO: not sure about that. could it be used further in the dev
      # def collection_name
      #   mapper.name
      # end

      module ClassMethods

        def mapping(name, options = {}, &block)
          class_eval do
            define_method(:mapper_options) { [name, options, block] }
          end
        end

      end

    end

  end
end
