module Locomotive
  module Steam
    module Adapters
      module Filesystem
        module YAMLLoaders

          class Site

            include Adapters::Filesystem::YAMLLoader

            def load(scope)
              attributes = _load(File.join(site_path, 'config', 'site.yml'))

              (attributes[:domains] ||= []) << 'localhost'

              [attributes]
            end

          end

        end
      end
    end
  end
end
