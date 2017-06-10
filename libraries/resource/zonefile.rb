class ChefKnot
  class Resource
    class Zonefile < Chef::Resource
      resource_name :knot_zonefile

      default_action :create
      allowed_actions :create, :create_if_missing

      property :domain, String
      property :ttl, Integer, default: 300
      property :name_server, String
      property :email_addr, String
      property :sn, Integer, default: 2017010101
      property :ref, Integer, default: 28800
      property :ret, Integer, default: 14400
      property :ex, Integer, default: 604800
      property :nx, Integer, default: 86400

      property :owner, String, defualt: 'knot'
      property :group, String, default: 'knot'

      property :hosts, Hash
      property :zone_options, Hash, default: {}
      property :path, String, default: lazy { ::File.join(Chef::Config[:file_cache_path], 'knot', domain) }
    end
  end
end
