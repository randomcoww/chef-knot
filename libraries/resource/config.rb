class ChefKnot
  class Resource
    class Config < Chef::Resource
      include KnotHelper

      resource_name :knot_config

      default_action :create
      allowed_actions :create, :delete

      property :config, Hash
      property :content, [String,NilClass], default: lazy { to_conf }
      property :path, String, desired_state: false,
                              default: lazy { KnotHelper::CONFIG_PATH }

      private

      def to_conf
        KnotHelper::ConfigGenerator.generate_from_hash(config)
      end
    end
  end
end
