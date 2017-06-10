class ChefKnot
  class Provider
    class Config < Chef::Provider
      provides :knot_config, os: "linux"

      def load_current_resource
        @current_resource = ChefKnot::Resource::Config.new(new_resource.name)

        if ::File.exist?(new_resource.path)
          current_resource.content(::File.read(new_resource.path))
        else
          current_resource.content(nil)
        end

        current_resource
      end

      def action_create
        converge_by("Create nsd config: #{new_resource}") do
          knot_config.run_action(:create)
        end if !current_resource.exists || current_resource.content != new_resource.content
      end

      def action_delete
        converge_by("Delete nsd config: #{new_resource}") do
          knot_config.run_action(:delete)
        end if current_resource.exists
      end

      private

      def knot_config
        @knot_config ||= Chef::Resource::File.new(new_resource.path, run_context).tap do |r|
          r.path new_resource.path
          r.content new_resource.content
        end
      end
    end
  end
end
