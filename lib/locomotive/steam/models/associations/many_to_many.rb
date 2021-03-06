module Locomotive::Steam
  module Models

    class ManyToManyAssociation < ReferencedAssociation

      def __load__
        source_key = :"#{@options[:association_name].to_s.singularize}_ids"
        key = @repository.k(:_id, :in)

        @repository.local_conditions[key] = @entity[source_key]

        # use order_by from options as the default one for further queries
        @repository.local_conditions[:order_by] = @options[:order_by] unless @options[:order_by].blank?

        # all the further calls (method_missing) will be delegated to @repository
        @repository
      end

    end

  end
end
