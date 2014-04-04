# The profile to set up the endpoints, auth, and database for Glance
class openstack::profile::glance::auth {
  openstack::resources::controller { 'glance': }
  openstack::resources::database { 'glance': }

  class  { '::glance::keystone::auth':
    password         => hiera('openstack::glance::password'),
    public_address   => hiera('openstack::storage::address::api'),
    admin_address    => hiera('openstack::storage::address::management'),
    internal_address => hiera('openstack::storage::address::management'),
    region           => hiera('openstack::region'),
  }
}
