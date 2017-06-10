class ChefKnot
  class Resource
    class Config < Chef::Resource
      resource_name :knot_config

      default_action :create
      allowed_actions :create, :delete

      property :config, Hash
      property :content, [String,NilClass], default: lazy { to_conf }
      property :path, String, desired_state: false,
                              default: lazy { KnotHelper::CONFIG_PATH }

      private

      def to_conf
        ## config is very yaml like but --- separator does not work
        config.to_hash.to_yaml.lines.drop(1).join('')
      end
    end
  end
end
