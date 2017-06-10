class ChefKnot
  class Provider
    class Zonefile < Chef::Provider
      provides :knot_zonefile, os: "linux"

      def load_current_resource
        @current_resource = ChefKnot::Resource::Zonefile.new(new_resource.name)
        current_resource
      end

      def action_create
        create_path
        knot_zonefile.run_action(:create)
        new_resource.updated_by_last_action(knot_zonefile.updated_by_last_action?)
      end

      def action_create_if_missing
        create_path
        knot_zonefile.run_action(:create_if_missing)
        new_resource.updated_by_last_action(knot_zonefile.updated_by_last_action?)
      end

      private

      def create_path
        Chef::Resource::Directory.new(::File.dirname(new_resource.path), run_context).tap do |r|
          r.recursive true
        end.run_action(:create_if_missing)
      end

      def knot_zonefile
        @knot_zonefile ||= Chef::Resource::Template.new(new_resource.path, run_context).tap do |r|
          r.path new_resource.path
          r.cookbook 'knot'
          r.source 'zonefile.erb'
          r.variables ({
            domain: new_resource.domain,
            ttl: new_resource.ttl,
            name_server: new_resource.name_server,
            email_addr: new_resource.email_addr,
            sn: new_resource.sn,
            ref: new_resource.ref,
            ret: new_resource.ret,
            ex: new_resource.ex,
            nx: new_resource.nx,

            hosts: new_resource.hosts
          })
          r.owner new_resource.owner
          r.group new_resource.group
          r.atomic_update false
        end
      end
    end
  end
end
