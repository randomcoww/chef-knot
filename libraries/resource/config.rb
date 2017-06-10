class ChefKnot
  class Resource
    class Config < Chef::Resource
      resource_name :knot_config

      default_action :create
      allowed_actions :create, :delete

      property :config, Hash
      property :content, [String,NilClass], default: lazy { config.to_yaml }
      property :path, String, desired_state: false,
                              default: lazy { KnotHelper::CONFIG_PATH }

    end
  end
end
