class openstack::common::keystone {
  if $::openstack::profile::base::is_controller {
    $admin_bind_host = '0.0.0.0'
  } else {
    $admin_bind_host = $::openstack::config::keystone_server_fqdn
  }

  class { '::keystone':
    admin_token     => $::openstack::config::keystone_admin_token,
    service_name    => $::openstack::config::keystone_service_name,
    sql_connection  => $::openstack::resources::connectors::keystone,
    verbose         => $::openstack::config::verbose,
    debug           => $::openstack::config::debug,
    enabled         => $::openstack::profile::base::is_controller,
    admin_bind_host => $admin_bind_host,
    mysql_module    => '2.2',
  }
  
  if $::openstack::config::keystone_service_name == 'httpd' {
     class { '::keystone::wsgi::apache': 
    }
  }
  class { '::keystone::roles::admin':
    email        => $::openstack::config::keystone_admin_email,
    password     => $::openstack::config::keystone_admin_password,
    admin_tenant => 'admin',
  }
}
