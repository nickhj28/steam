module Locomotive
  module Steam
    module Adapters
      module Filesystem
        module YAMLLoaders

          class Translation

            include Adapters::Filesystem::YAMLLoader

            def load(scope)
              super
              load_array
            end

            private

            def load_array
              [].tap do |array|
                _load(path).each do |key, values|
                  array << { key: key.to_s, values: HashConverter.to_string(values) }
                end
              end
            end

            def path
              File.join(site_path, 'config', 'translations.yml')
            end

          end

        end
      end
    end
  end
end

# module Locomotive
#   module Steam
#     module Repositories
#       module Filesystem
#         module YAMLLoaders

#           class Translation < Struct.new(:root_path, :cache)

#             include YAMLLoaders::Concerns::Common

#             def list_of_attributes
#               cache.fetch('config/translations') { load_array }
#             end

#             private

#             def load_array
#               [].tap do |array|
#                 load(path).each do |key, values|
#                   array << { key: key.to_s, values: HashConverter.to_string(values) }
#                 end
#               end
#             end

#             def path
#               File.join(root_path, 'config', 'translations.yml')
#             end

#           end

#         end
#       end
#     end
#   end
# end
