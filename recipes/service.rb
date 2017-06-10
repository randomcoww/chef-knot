systemd_resource_dropin "10-restart" do
  service "knot.service"
  config ({
    'Service' => {
      'Restart' => 'always',
      'RestartSec' => 5,
    }
  })
  action [:create]
end

service 'knot' do
  action [:enable, :start]
end
