# Google Compute Engine Chef Cookbook

This cookbook provides the built-in types and services for Chef to manage
Google Cloud Compute resources, as native Chef types.

## Requirements

### Platforms

#### Supported Operating Systems

This cookbook was tested on the following operating systems:

* RedHat 6, 7
* CentOS 6, 7
* Debian 7, 8
* Ubuntu 12.04, 14.04, 16.04, 16.10
* SLES 11-sp4, 12-sp2
* openSUSE 13
* Windows Server 2008 R2, 2012 R2, 2012 R2 Core, 2016 R2, 2016 R2 Core

## Example

```ruby
gauth_credential 'mycred' do
  action :serviceaccount
  path ENV['CRED_PATH'] # e.g. '/path/to/my_account.json'
  scopes [
    'https://www.googleapis.com/auth/compute'
  ]
end

gcompute_zone 'us-west1-a' do
  action :create
  project 'google.com:graphite-playground'
  credential 'mycred'
end

gcompute_disk 'instance-test-os-1' do
  action :create
  source_image 'projects/ubuntu-os-cloud/global/images/family/ubuntu-1604-lts'
  zone 'us-west1-a'
  project 'google.com:graphite-playground'
  credential 'mycred'
end

gcompute_network 'mynetwork-test' do
  action :create
  project 'google.com:graphite-playground'
  credential 'mycred'
end

gcompute_region 'us-west1' do
  action :create
  project 'google.com:graphite-playground'
  credential 'mycred'
end

gcompute_address 'instance-test-ip' do
  action :create
  region 'us-west1'
  project 'google.com:graphite-playground'
  credential 'mycred'
end

gcompute_machine_type 'n1-standard-1' do
  action :create
  zone 'us-west1-a'
  project 'google.com:graphite-playground'
  credential 'mycred'
end

gcompute_instance 'instance-test' do
  action :create
  machine_type 'n1-standard-1'
  disks [
    {
      boot: true,
      auto_delete: true,
      source: 'instance-test-os-1'
    }
  ]
  network_interfaces [
    {
      network: 'mynetwork-test',
      access_configs: [
        {
          name: 'External NAT',
          nat_ip: 'instance-test-ip',
          type: 'ONE_TO_ONE_NAT'
        }
      ]
    }
  ]
  zone 'us-west1-a'
  project 'google.com:graphite-playground'
  credential 'mycred'
end
```

## Credentials

All Google Cloud Platform cookbooks use an unified authentication mechanism,
provided by the `google-gauth` cookbook. Don't worry, it is automatically
installed when you install this module.

### Example

```ruby
gauth_credential 'mycred' do
  action :serviceaccount
  path ENV['CRED_PATH'] # e.g. '/path/to/my_account.json'
  scopes [
    'https://www.googleapis.com/auth/compute'
  ]
end

```

For complete details of the authentication cookbook, visit the
[google-gauth][] cookbook documentation.

## Resources

* [`gcompute_address`](#gcompute_address) -
    Represents an Address resource.
    Each virtual machine instance has an ephemeral internal IP address and,
    optionally, an external IP address. To communicate between instances on
    the same network, you can use an instance's internal IP address. To
    communicate with the Internet and instances outside of the same
    network,
    you must specify the instance's external IP address.
    Internal IP addresses are ephemeral and only belong to an instance for
    the lifetime of the instance; if the instance is deleted and recreated,
    the instance is assigned a new internal IP address, either by Compute
    Engine or by you. External IP addresses can be either ephemeral or
    static.
* [`gcompute_backend_bucket`](#gcompute_backend_bucket) -
    Backend buckets allow you to use Google Cloud Storage buckets with
    HTTP(S)
    load balancing.
    An HTTP(S) load balancing can direct traffic to specified URLs to a
    backend bucket rather than a backend service. It can send requests for
    static content to a Cloud Storage bucket and requests for dynamic
    content
    a virtual machine instance.
* [`gcompute_backend_service`](#gcompute_backend_service) -
    Creates a BackendService resource in the specified project using the
    data
    included in the request.
* [`gcompute_disk_type`](#gcompute_disk_type) -
    Represents a DiskType resource. A DiskType resource represents the type
    of disk to use, such as a pd-ssd or pd-standard. To reference a disk
    type, use the disk type's full or partial URL.
* [`gcompute_disk`](#gcompute_disk) -
    Persistent disks are durable storage devices that function similarly to
    the physical disks in a desktop or a server. Compute Engine manages the
    hardware behind these devices to ensure data redundancy and optimize
    performance for you. Persistent disks are available as either standard
    hard disk drives (HDD) or solid-state drives (SSD).
    Persistent disks are located independently from your virtual machine
    instances, so you can detach or move persistent disks to keep your data
    even after you delete your instances. Persistent disk performance
    scales
    automatically with size, so you can resize your existing persistent
    disks
    or add more persistent disks to an instance to meet your performance
    and
    storage space requirements.
    Add a persistent disk to your instance when you need reliable and
    affordable storage with consistent performance characteristics.
* [`gcompute_firewall`](#gcompute_firewall) -
    Each network has its own firewall controlling access to and from the
    instances.
    All traffic to instances, even from other instances, is blocked by the
    firewall unless firewall rules are created to allow it.
    The default network has automatically created firewall rules that are
    shown in default firewall rules. No manually created network has
    automatically created firewall rules except for a default "allow" rule
    for
    outgoing traffic and a default "deny" for incoming traffic. For all
    networks except the default network, you must create any firewall rules
    you need.
* [`gcompute_global_address`](#gcompute_global_address) -
    Represents a Global Address resource. Global addresses are used for
    HTTP(S) load balancing.
* [`gcompute_http_health_check`](#gcompute_http_health_check) -
    An HttpHealthCheck resource. This resource defines a template for how
    individual VMs should be checked for health, via HTTP.
* [`gcompute_https_health_check`](#gcompute_https_health_check) -
    An HttpsHealthCheck resource. This resource defines a template for how
    individual VMs should be checked for health, via HTTPS.
* [`gcompute_health_check`](#gcompute_health_check) -
    An HealthCheck resource. This resource defines a template for how
    individual virtual machines should be checked for health, via one of
    the supported protocols.
* [`gcompute_instance_template`](#gcompute_instance_template) -
    Defines an Instance Template resource that provides configuration
    settings
    for your virtual machine instances. Instance templates are not tied to
    the
    lifetime of an instance and can be used and reused as to deploy virtual
    machines. You can also use different templates to create different
    virtual
    machine configurations. Instance templates are required when you create
    a
    managed instance group.
    Tip: Disks should be set to autoDelete=true
    so that leftover disks are not left behind on machine deletion.
* [`gcompute_license`](#gcompute_license) -
    A License resource represents a software license. Licenses are used to
    track software usage in images, persistent disks, snapshots, and
    virtual
    machine instances.
* [`gcompute_image`](#gcompute_image) -
    Represents an Image resource.
    Google Compute Engine uses operating system images to create the root
    persistent disks for your instances. You specify an image when you
    create
    an instance. Images contain a boot loader, an operating system, and a
    root file system. Linux operating system images are also capable of
    running containers on Compute Engine.
    Images can be either public or custom.
    Public images are provided and maintained by Google, open-source
    communities, and third-party vendors. By default, all projects have
    access to these images and can use them to create instances.  Custom
    images are available only to your project. You can create a custom
    image
    from root persistent disks and other images. Then, use the custom image
    to create an instance.
* [`gcompute_instance`](#gcompute_instance) -
    An instance is a virtual machine (VM) hosted on Google's
    infrastructure.
* [`gcompute_instance_group`](#gcompute_instance_group) -
    Represents an Instance Group resource. Instance groups are self-managed
    and can contain identical or different instances. Instance groups do
    not
    use an instance template. Unlike managed instance groups, you must
    create
    and add instances to an instance group manually.
* [`gcompute_machine_type`](#gcompute_machine_type) -
    Represents a MachineType resource. Machine types determine the
    virtualized
    hardware specifications of your virtual machine instances, such as the
    amount of memory or number of virtual CPUs.
* [`gcompute_network`](#gcompute_network) -
    Represents a Network resource.
    Your Cloud Platform Console project can contain multiple networks, and
    each network can have multiple instances attached to it. A network
    allows
    you to define a gateway IP and the network range for the instances
    attached to that network. Every project is provided with a default
    network
    with preset configurations and firewall rules. You can choose to
    customize
    the default network by adding or removing rules, or you can create new
    networks in that project. Generally, most users only need one network,
    although you can have up to five networks per project by default.
    A network belongs to only one project, and each instance can only
    belong
    to one network. All Compute Engine networks use the IPv4 protocol.
    Compute
    Engine currently does not support IPv6. However, Google is a major
    advocate of IPv6 and it is an important future direction.
* [`gcompute_region`](#gcompute_region) -
    Represents a Region resource. A region is a specific geographical
    location where you can run your resources. Each region has one or more
    zones
* [`gcompute_route`](#gcompute_route) -
    Represents a Route resource.
    A route is a rule that specifies how certain packets should be handled
    by
    the virtual network. Routes are associated with virtual machines by
    tag,
    and the set of routes for a particular virtual machine is called its
    routing table. For each packet leaving a virtual machine, the system
    searches that virtual machine's routing table for a single best
    matching
    route.
    Routes match packets by destination IP address, preferring smaller or
    more
    specific ranges over larger ones. If there is a tie, the system selects
    the route with the smallest priority value. If there is still a tie, it
    uses the layer three and four packet headers to select just one of the
    remaining matching routes. The packet is then forwarded as specified by
    the next_hop field of the winning route -- either to another virtual
    machine destination, a virtual machine gateway or a Compute
    Engine-operated gateway. Packets that do not match any route in the
    sending virtual machine's routing table will be dropped.
    A Routes resources must have exactly one specification of either
    nextHopGateway, nextHopInstance, nextHopIp, or nextHopVpnTunnel.
* [`gcompute_ssl_certificate`](#gcompute_ssl_certificate) -
    An SslCertificate resource. This resource provides a mechanism to
    upload
    an SSL key and certificate to the load balancer to serve secure
    connections from the user.
* [`gcompute_subnetwork`](#gcompute_subnetwork) -
    A VPC network is a virtual version of the traditional physical networks
    that exist within and between physical data centers. A VPC network
    provides connectivity for your Compute Engine virtual machine (VM)
    instances, Container Engine containers, App Engine Flex services, and
    other network-related resources.
    Each GCP project contains one or more VPC networks. Each VPC network is
    a
    global entity spanning all GCP regions. This global VPC network allows
    VM
    instances and other resources to communicate with each other via
    internal,
    private IP addresses.
    Each VPC network is subdivided into subnets, and each subnet is
    contained
    within a single region. You can have more than one subnet in a region
    for
    a given VPC network. Each subnet has a contiguous private RFC1918 IP
    space. You create instances, containers, and the like in these subnets.
    When you create an instance, you must create it in a subnet, and the
    instance draws its internal IP address from that subnet.
    Virtual machine (VM) instances in a VPC network can communicate with
    instances in all other subnets of the same VPC network, regardless of
    region, using their RFC1918 private IP addresses. You can isolate
    portions
    of the network, even entire subnets, using firewall rules.
* [`gcompute_zone`](#gcompute_zone) -
    Represents a Zone resource.


### gcompute_address
Represents an Address resource.

Each virtual machine instance has an ephemeral internal IP address and,
optionally, an external IP address. To communicate between instances on
the same network, you can use an instance's internal IP address. To
communicate with the Internet and instances outside of the same network,
you must specify the instance's external IP address.

Internal IP addresses are ephemeral and only belong to an instance for
the lifetime of the instance; if the instance is deleted and recreated,
the instance is assigned a new internal IP address, either by Compute
Engine or by you. External IP addresses can be either ephemeral or
static.


#### Example

```ruby
gcompute_region 'some-region' do
  action :create
  r_label 'us-west1'
  project 'google.com:graphite-playground'
  credential 'mycred'
end

gcompute_address 'test1' do
  action :create
  region 'some-region'
  project 'google.com:graphite-playground'
  credential 'mycred'
end

```

#### Reference

```ruby
gcompute_address 'id-for-resource' do
  address            string
  creation_timestamp time
  description        string
  id                 integer
  name               string
  region             reference to gcompute_region
  users              [
    string,
    ...
  ]
  project            string
  credential         reference to gauth_credential
end
```

#### Actions

* `create` -
  Converges the `gcompute_address` resource into the final
  state described within the block. If the resource does not exist, Chef will
  attempt to create it.
* `delete` -
  Ensures the `gcompute_address` resource is not present.
  If the resource already exists Chef will attempt to delete it.

#### Properties

* `address` -
  The static external IP address represented by this
  resource. Only IPv4 is supported.

* `creation_timestamp` -
  Output only. Creation timestamp in RFC3339 text format.

* `description` -
  An optional description of this resource.

* `id` -
  Output only. The unique identifier for the resource.

* `name` -
  Name of the resource.

* `users` -
  Output only. The URLs of the resources that are using this address.

* `region` -
  Required. A reference to Region resource

#### Label
Set the `a_label` property when attempting to set primary key
of this object. The primary key will always be referred to by the initials of
the resource followed by "_label"

### gcompute_backend_bucket
Backend buckets allow you to use Google Cloud Storage buckets with HTTP(S)
load balancing.

An HTTP(S) load balancing can direct traffic to specified URLs to a
backend bucket rather than a backend service. It can send requests for
static content to a Cloud Storage bucket and requests for dynamic content
a virtual machine instance.


#### Example

```ruby
# *** WARNING ***
# TODO(nelsonjr): http://b/63088154 Google Cloud Platform API is returning
# access denied if we use a more restricted scope such as
# https://www.googleapis.com/auth/compute. For the time being use an all mighty
# scope instead: https://www.googleapis.com/auth/cloud-platform.

gcompute_backend_bucket 'be-bucket-connection' do
  action :create
  bucket_name 'backend-bucket-test'
  description 'A BackendBucket to connect LNB w/ Storage Bucket'
  enable_cdn true
  project 'google.com:graphite-playground'
  credential 'mycred'
end

```

#### Reference

```ruby
gcompute_backend_bucket 'id-for-resource' do
  bucket_name        string
  creation_timestamp time
  description        string
  enable_cdn         boolean
  id                 integer
  name               string
  project            string
  credential         reference to gauth_credential
end
```

#### Actions

* `create` -
  Converges the `gcompute_backend_bucket` resource into the final
  state described within the block. If the resource does not exist, Chef will
  attempt to create it.
* `delete` -
  Ensures the `gcompute_backend_bucket` resource is not present.
  If the resource already exists Chef will attempt to delete it.

#### Properties

* `bucket_name` -
  Cloud Storage bucket name.

* `creation_timestamp` -
  Output only. Creation timestamp in RFC3339 text format.

* `description` -
  An optional textual description of the resource; provided by the
  client when the resource is created.

* `enable_cdn` -
  If true, enable Cloud CDN for this BackendBucket.

* `id` -
  Unique identifier for the resource.

* `name` -
  Name of the resource. Provided by the client when the resource is
  created. The name must be 1-63 characters long, and comply with
  RFC1035.  Specifically, the name must be 1-63 characters long and
  match the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means
  the first character must be a lowercase letter, and all following
  characters must be a dash, lowercase letter, or digit, except the
  last character, which cannot be a dash.

#### Label
Set the `bb_label` property when attempting to set primary key
of this object. The primary key will always be referred to by the initials of
the resource followed by "_label"

### gcompute_backend_service
Creates a BackendService resource in the specified project using the data
included in the request.


#### Example

```ruby
# Backend Service requires various other services to be setup beforehand. Please
# make sure they are defined as well:
#   - gcompute_instance_group 'my-masters' do ... end
#   - Health check
my_health_check = [
  'https://www.googleapis.com/compute/v1',
  'projects/google.com:graphite-playground',
  'global/healthChecks/another-hc'
].join('/')

gcompute_backend_service 'my-app-backend' do
  action :create
  backends [
    { group: 'my-masters' }
  ]
  enable_cdn true
  health_checks [
    my_health_check
  ]
  project 'google.com:graphite-playground'
  credential 'mycred'
end

```

#### Reference

```ruby
gcompute_backend_service 'id-for-resource' do
  affinity_cookie_ttl_sec integer
  backends                [
    {
      balancing_mode               'UTILIZATION', 'RATE' or 'CONNECTION',
      capacity_scaler              double,
      description                  string,
      group                        reference to gcompute_instance_group,
      max_connections              integer,
      max_connections_per_instance integer,
      max_rate                     integer,
      max_rate_per_instance        double,
      max_utilization              double,
    },
    ...
  ]
  cdn_policy              {
    cache_key_policy {
      include_host           boolean,
      include_protocol       boolean,
      include_query_string   boolean,
      query_string_blacklist [
        string,
        ...
      ],
      query_string_whitelist [
        string,
        ...
      ],
    },
  }
  connection_draining     {
    draining_timeout_sec integer,
  }
  creation_timestamp      time
  description             string
  enable_cdn              boolean
  health_checks           [
    string,
    ...
  ]
  id                      integer
  name                    string
  port_name               string
  protocol                'HTTP', 'HTTPS', 'TCP' or 'SSL'
  region                  reference to gcompute_region
  session_affinity        'NONE', 'CLIENT_IP', 'GENERATED_COOKIE', 'CLIENT_IP_PROTO' or 'CLIENT_IP_PORT_PROTO'
  timeout_sec             integer
  project                 string
  credential              reference to gauth_credential
end
```

#### Actions

* `create` -
  Converges the `gcompute_backend_service` resource into the final
  state described within the block. If the resource does not exist, Chef will
  attempt to create it.
* `delete` -
  Ensures the `gcompute_backend_service` resource is not present.
  If the resource already exists Chef will attempt to delete it.

#### Properties

* `affinity_cookie_ttl_sec` -
  Lifetime of cookies in seconds if session_affinity is
  GENERATED_COOKIE. If set to 0, the cookie is non-persistent and lasts
  only until the end of the browser session (or equivalent). The
  maximum allowed value for TTL is one day.
  When the load balancing scheme is INTERNAL, this field is not used.

* `backends` -
  The list of backends that serve this BackendService.

* `backends[]/balancing_mode`
  Specifies the balancing mode for this backend.
  For global HTTP(S) or TCP/SSL load balancing, the default is
  UTILIZATION. Valid values are UTILIZATION, RATE (for HTTP(S))
  and CONNECTION (for TCP/SSL).
  This cannot be used for internal load balancing.

* `backends[]/capacity_scaler`
  A multiplier applied to the group's maximum servicing capacity
  (based on UTILIZATION, RATE or CONNECTION).
  Default value is 1, which means the group will serve up to 100%
  of its configured capacity (depending on balancingMode). A
  setting of 0 means the group is completely drained, offering
  0% of its available Capacity. Valid range is [0.0,1.0].
  This cannot be used for internal load balancing.

* `backends[]/description`
  An optional description of this resource.
  Provide this property when you create the resource.

* `backends[]/group`
  A reference to InstanceGroup resource

* `backends[]/max_connections`
  The max number of simultaneous connections for the group. Can
  be used with either CONNECTION or UTILIZATION balancing modes.
  For CONNECTION mode, either maxConnections or
  maxConnectionsPerInstance must be set.
  This cannot be used for internal load balancing.

* `backends[]/max_connections_per_instance`
  The max number of simultaneous connections that a single
  backend instance can handle. This is used to calculate the
  capacity of the group. Can be used in either CONNECTION or
  UTILIZATION balancing modes.
  For CONNECTION mode, either maxConnections or
  maxConnectionsPerInstance must be set.
  This cannot be used for internal load balancing.

* `backends[]/max_rate`
  The max requests per second (RPS) of the group.
  Can be used with either RATE or UTILIZATION balancing modes,
  but required if RATE mode. For RATE mode, either maxRate or
  maxRatePerInstance must be set.
  This cannot be used for internal load balancing.

* `backends[]/max_rate_per_instance`
  The max requests per second (RPS) that a single backend
  instance can handle. This is used to calculate the capacity of
  the group. Can be used in either balancing mode. For RATE mode,
  either maxRate or maxRatePerInstance must be set.
  This cannot be used for internal load balancing.

* `backends[]/max_utilization`
  Used when balancingMode is UTILIZATION. This ratio defines the
  CPU utilization target for the group. The default is 0.8. Valid
  range is [0.0, 1.0].
  This cannot be used for internal load balancing.

* `cdn_policy` -
  Cloud CDN configuration for this BackendService.

* `cdn_policy/cache_key_policy`
  The CacheKeyPolicy for this CdnPolicy.

* `cdn_policy/cache_key_policy/include_host`
  If true requests to different hosts will be cached separately.

* `cdn_policy/cache_key_policy/include_protocol`
  If true, http and https requests will be cached separately.

* `cdn_policy/cache_key_policy/include_query_string`
  If true, include query string parameters in the cache key
  according to query_string_whitelist and
  query_string_blacklist. If neither is set, the entire query
  string will be included.
  If false, the query string will be excluded from the cache
  key entirely.

* `cdn_policy/cache_key_policy/query_string_blacklist`
  Names of query string parameters to exclude in cache keys.
  All other parameters will be included. Either specify
  query_string_whitelist or query_string_blacklist, not both.
  '&' and '=' will be percent encoded and not treated as
  delimiters.

* `cdn_policy/cache_key_policy/query_string_whitelist`
  Names of query string parameters to include in cache keys.
  All other parameters will be excluded. Either specify
  query_string_whitelist or query_string_blacklist, not both.
  '&' and '=' will be percent encoded and not treated as
  delimiters.

* `connection_draining` -
  Settings for connection draining

* `connection_draining/draining_timeout_sec`
  Time for which instance will be drained (not accept new
  connections, but still work to finish started).

* `creation_timestamp` -
  Output only. Creation timestamp in RFC3339 text format.

* `description` -
  An optional description of this resource.

* `enable_cdn` -
  If true, enable Cloud CDN for this BackendService.
  When the load balancing scheme is INTERNAL, this field is not used.

* `health_checks` -
  The list of URLs to the HttpHealthCheck or HttpsHealthCheck resource
  for health checking this BackendService. Currently at most one health
  check can be specified, and a health check is required.
  For internal load balancing, a URL to a HealthCheck resource must be
  specified instead.

* `id` -
  Output only. The unique identifier for the resource.

* `name` -
  Name of the resource. Provided by the client when the resource is
  created. The name must be 1-63 characters long, and comply with
  RFC1035. Specifically, the name must be 1-63 characters long and match
  the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means the
  first character must be a lowercase letter, and all following
  characters must be a dash, lowercase letter, or digit, except the last
  character, which cannot be a dash.

* `port_name` -
  Name of backend port. The same name should appear in the instance
  groups referenced by this service. Required when the load balancing
  scheme is EXTERNAL.
  When the load balancing scheme is INTERNAL, this field is not used.

* `protocol` -
  The protocol this BackendService uses to communicate with backends.
  Possible values are HTTP, HTTPS, TCP, and SSL. The default is HTTP.
  For internal load balancing, the possible values are TCP and UDP, and
  the default is TCP.

* `region` -
  A reference to Region resource

* `session_affinity` -
  Type of session affinity to use. The default is NONE.
  When the load balancing scheme is EXTERNAL, can be NONE, CLIENT_IP, or
  GENERATED_COOKIE.
  When the load balancing scheme is INTERNAL, can be NONE, CLIENT_IP,
  CLIENT_IP_PROTO, or CLIENT_IP_PORT_PROTO.
  When the protocol is UDP, this field is not used.

* `timeout_sec` -
  How many seconds to wait for the backend before considering it a
  failed request. Default is 30 seconds. Valid range is [1, 86400].

#### Label
Set the `bs_label` property when attempting to set primary key
of this object. The primary key will always be referred to by the initials of
the resource followed by "_label"

### gcompute_disk_type
Represents a DiskType resource. A DiskType resource represents the type
of disk to use, such as a pd-ssd or pd-standard. To reference a disk
type, use the disk type's full or partial URL.


#### Example

```ruby
gcompute_disk_type 'pd-standard' do
  action :create
  zone 'us-central1-a'
  project 'google.com:graphite-playground'
  credential 'mycred'
end

```

#### Reference

```ruby
gcompute_disk_type 'id-for-resource' do
  creation_timestamp     time
  default_disk_size_gb   integer
  deprecated_deleted     time
  deprecated_deprecated  time
  deprecated_obsolete    time
  deprecated_replacement string
  deprecated_state       'DEPRECATED', 'OBSOLETE' or 'DELETED'
  description            string
  id                     integer
  name                   string
  valid_disk_size        string
  zone                   reference to gcompute_zone
  project                string
  credential             reference to gauth_credential
end
```

#### Actions

* `create` -
  Converges the `gcompute_disk_type` resource into the final
  state described within the block. If the resource does not exist, Chef will
  attempt to create it.
* `delete` -
  Ensures the `gcompute_disk_type` resource is not present.
  If the resource already exists Chef will attempt to delete it.

#### Properties

* `creation_timestamp` -
  Output only. Creation timestamp in RFC3339 text format.

* `default_disk_size_gb` -
  Output only. Server-defined default disk size in GB.

* `deprecated_deleted` -
  Output only. An optional RFC3339 timestamp on or after which the
  deprecation state
  of this resource will be changed to DELETED.

* `deprecated_deprecated` -
  Output only. An optional RFC3339 timestamp on or after which the
  deprecation state
  of this resource will be changed to DEPRECATED.

* `deprecated_obsolete` -
  Output only. An optional RFC3339 timestamp on or after which the
  deprecation state
  of this resource will be changed to OBSOLETE.

* `deprecated_replacement` -
  Output only. The URL of the suggested replacement for a deprecated
  resource. The
  suggested replacement resource must be the same kind of resource as
  the deprecated resource.

* `deprecated_state` -
  Output only. The deprecation state of this resource. This can be
  DEPRECATED,
  OBSOLETE, or DELETED. Operations which create a new resource using a
  DEPRECATED resource will return successfully, but with a warning
  indicating the deprecated resource and recommending its replacement.
  Operations which use OBSOLETE or DELETED resources will be rejected
  and result in an error.

* `description` -
  Output only. An optional description of this resource.

* `id` -
  Output only. The unique identifier for the resource.

* `name` -
  Name of the resource.

* `valid_disk_size` -
  Output only. An optional textual description of the valid disk size, such
  as
  "10GB-10TB".

* `zone` -
  Required. A reference to Zone resource

#### Label
Set the `dt_label` property when attempting to set primary key
of this object. The primary key will always be referred to by the initials of
the resource followed by "_label"

### gcompute_disk
Persistent disks are durable storage devices that function similarly to
the physical disks in a desktop or a server. Compute Engine manages the
hardware behind these devices to ensure data redundancy and optimize
performance for you. Persistent disks are available as either standard
hard disk drives (HDD) or solid-state drives (SSD).

Persistent disks are located independently from your virtual machine
instances, so you can detach or move persistent disks to keep your data
even after you delete your instances. Persistent disk performance scales
automatically with size, so you can resize your existing persistent disks
or add more persistent disks to an instance to meet your performance and
storage space requirements.

Add a persistent disk to your instance when you need reliable and
affordable storage with consistent performance characteristics.


#### Example

```ruby
gcompute_disk 'data-disk-1' do
  action :create
  size_gb 50
  disk_encryption_key({
    raw_key: 'SGVsbG8gZnJvbSBHb29nbGUgQ2xvdWQgUGxhdGZvcm0='
  })
  zone 'us-central1-a'
  project 'google.com:graphite-playground'
  credential 'mycred'
end

```

#### Reference

```ruby
gcompute_disk 'id-for-resource' do
  creation_timestamp             time
  description                    string
  disk_encryption_key            {
    raw_key string,
    sha256  string,
  }
  id                             integer
  last_attach_timestamp          time
  last_detach_timestamp          time
  licenses                       [
    string,
    ...
  ]
  name                           string
  size_gb                        integer
  source_image                   string
  source_image_encryption_key    {
    raw_key string,
    sha256  string,
  }
  source_image_id                string
  source_snapshot                string
  source_snapshot_encryption_key {
    raw_key string,
    sha256  string,
  }
  source_snapshot_id             string
  type                           string
  users                          [
    string,
    ...
  ]
  zone                           reference to gcompute_zone
  project                        string
  credential                     reference to gauth_credential
end
```

#### Actions

* `create` -
  Converges the `gcompute_disk` resource into the final
  state described within the block. If the resource does not exist, Chef will
  attempt to create it.
* `delete` -
  Ensures the `gcompute_disk` resource is not present.
  If the resource already exists Chef will attempt to delete it.

#### Properties

* `creation_timestamp` -
  Output only. Creation timestamp in RFC3339 text format.

* `description` -
  An optional description of this resource. Provide this property when
  you create the resource.

* `id` -
  Output only. The unique identifier for the resource.

* `last_attach_timestamp` -
  Output only. Last attach timestamp in RFC3339 text format.

* `last_detach_timestamp` -
  Output only. Last dettach timestamp in RFC3339 text format.

* `licenses` -
  Any applicable publicly visible licenses.

* `name` -
  Name of the resource. Provided by the client when the resource is
  created. The name must be 1-63 characters long, and comply with
  RFC1035. Specifically, the name must be 1-63 characters long and match
  the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means the
  first character must be a lowercase letter, and all following
  characters must be a dash, lowercase letter, or digit, except the last
  character, which cannot be a dash.

* `size_gb` -
  Size of the persistent disk, specified in GB. You can specify this
  field when creating a persistent disk using the sourceImage or
  sourceSnapshot parameter, or specify it alone to create an empty
  persistent disk.
  If you specify this field along with sourceImage or sourceSnapshot,
  the value of sizeGb must not be less than the size of the sourceImage
  or the size of the snapshot.

* `source_image` -
  The source image used to create this disk. If the source image is
  deleted, this field will not be set.
  To create a disk with one of the public operating system images,
  specify the image by its family name. For example, specify
  family/debian-8 to use the latest Debian 8 image:
  projects/debian-cloud/global/images/family/debian-8
  Alternatively, use a specific version of a public operating system
  image:
  projects/debian-cloud/global/images/debian-8-jessie-vYYYYMMDD
  To create a disk with a private image that you created, specify the
  image name in the following format:
  global/images/my-private-image
  You can also specify a private image by its image family, which
  returns the latest version of the image in that family. Replace the
  image name with family/family-name:
  global/images/family/my-private-family

* `type` -
  Output only. URL of the disk type resource describing which disk type to
  use to
  create the disk. Provide this when creating the disk.

* `users` -
  Output only. Links to the users of the disk (attached instances) in form:
  project/zones/zone/instances/instance

* `zone` -
  Required. A reference to Zone resource

* `disk_encryption_key` -
  Encrypts the disk using a customer-supplied encryption key.
  After you encrypt a disk with a customer-supplied key, you must
  provide the same key if you use the disk later (e.g. to create a disk
  snapshot or an image, or to attach the disk to a virtual machine).
  Customer-supplied encryption keys do not protect access to metadata of
  the disk.
  If you do not provide an encryption key when creating the disk, then
  the disk will be encrypted using an automatically generated key and
  you do not need to provide a key to use the disk later.

* `disk_encryption_key/raw_key`
  Specifies a 256-bit customer-supplied encryption key, encoded in
  RFC 4648 base64 to either encrypt or decrypt this resource.

* `disk_encryption_key/sha256`
  Output only. The RFC 4648 base64 encoded SHA-256 hash of the
  customer-supplied
  encryption key that protects this resource.

* `source_image_encryption_key` -
  The customer-supplied encryption key of the source image. Required if
  the source image is protected by a customer-supplied encryption key.

* `source_image_encryption_key/raw_key`
  Specifies a 256-bit customer-supplied encryption key, encoded in
  RFC 4648 base64 to either encrypt or decrypt this resource.

* `source_image_encryption_key/sha256`
  Output only. The RFC 4648 base64 encoded SHA-256 hash of the
  customer-supplied
  encryption key that protects this resource.

* `source_image_id` -
  Output only. The ID value of the image used to create this disk. This value
  identifies the exact image that was used to create this persistent
  disk. For example, if you created the persistent disk from an image
  that was later deleted and recreated under the same name, the source
  image ID would identify the exact version of the image that was used.

* `source_snapshot` -
  The source snapshot used to create this disk. You can provide this as
  a partial or full URL to the resource. For example, the following are
  valid values:
  * https://www.googleapis.com/compute/v1/projects/project/global/
  snapshots/snapshot
  * projects/project/global/snapshots/snapshot
  * global/snapshots/snapshot

* `source_snapshot_encryption_key` -
  The customer-supplied encryption key of the source snapshot. Required
  if the source snapshot is protected by a customer-supplied encryption
  key.

* `source_snapshot_encryption_key/raw_key`
  Specifies a 256-bit customer-supplied encryption key, encoded in
  RFC 4648 base64 to either encrypt or decrypt this resource.

* `source_snapshot_encryption_key/sha256`
  Output only. The RFC 4648 base64 encoded SHA-256 hash of the
  customer-supplied
  encryption key that protects this resource.

* `source_snapshot_id` -
  Output only. The unique ID of the snapshot used to create this disk. This
  value
  identifies the exact snapshot that was used to create this persistent
  disk. For example, if you created the persistent disk from a snapshot
  that was later deleted and recreated under the same name, the source
  snapshot ID would identify the exact version of the snapshot that was
  used.

#### Label
Set the `d_label` property when attempting to set primary key
of this object. The primary key will always be referred to by the initials of
the resource followed by "_label"

### gcompute_firewall
Each network has its own firewall controlling access to and from the
instances.

All traffic to instances, even from other instances, is blocked by the
firewall unless firewall rules are created to allow it.

The default network has automatically created firewall rules that are
shown in default firewall rules. No manually created network has
automatically created firewall rules except for a default "allow" rule for
outgoing traffic and a default "deny" for incoming traffic. For all
networks except the default network, you must create any firewall rules
you need.


#### Example

```ruby
gcompute_firewall 'test-fw-allow-ssh' do
  action :create
  allowed [
    {
      ip_protocol: 'tcp',
      ports: ['22']
    }
  ]
  target_tags [
    'test-ssh-server',
    'staging-ssh-server'
  ]
  project 'google.com:graphite-playground'
  credential 'mycred'
end

```

#### Reference

```ruby
gcompute_firewall 'id-for-resource' do
  allowed            [
    {
      ip_protocol string,
      ports       [
        string,
        ...
      ],
    },
    ...
  ]
  creation_timestamp time
  description        string
  id                 integer
  name               string
  network            string
  source_ranges      [
    string,
    ...
  ]
  source_tags        [
    string,
    ...
  ]
  target_tags        [
    string,
    ...
  ]
  project            string
  credential         reference to gauth_credential
end
```

#### Actions

* `create` -
  Converges the `gcompute_firewall` resource into the final
  state described within the block. If the resource does not exist, Chef will
  attempt to create it.
* `delete` -
  Ensures the `gcompute_firewall` resource is not present.
  If the resource already exists Chef will attempt to delete it.

#### Properties

* `allowed` -
  The list of ALLOW rules specified by this firewall. Each rule
  specifies a protocol and port-range tuple that describes a permitted
  connection.

* `allowed[]/ip_protocol`
  Required. The IP protocol to which this rule applies. The protocol type is
  required when creating a firewall rule. This value can either be
  one of the following well known protocol strings (tcp, udp,
  icmp, esp, ah, sctp), or the IP protocol number.

* `allowed[]/ports`
  An optional list of ports to which this rule applies. This field
  is only applicable for UDP or TCP protocol. Each entry must be
  either an integer or a range. If not specified, this rule
  applies to connections through any port.
  Example inputs include: ["22"], ["80","443"], and
  ["12345-12349"].

* `creation_timestamp` -
  Output only. Creation timestamp in RFC3339 text format.

* `description` -
  An optional description of this resource. Provide this property when
  you create the resource.

* `id` -
  Output only. The unique identifier for the resource.

* `name` -
  Name of the resource. Provided by the client when the resource is
  created. The name must be 1-63 characters long, and comply with
  RFC1035. Specifically, the name must be 1-63 characters long and match
  the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means the
  first character must be a lowercase letter, and all following
  characters must be a dash, lowercase letter, or digit, except the last
  character, which cannot be a dash.

* `network` -
  URL of the network resource for this firewall rule. If not specified
  when creating a firewall rule, the default network is used:
  global/networks/default
  If you choose to specify this property, you can specify the network as
  a full or partial URL. For example, the following are all valid URLs:
  https://www.googleapis.com/compute/v1/projects/myproject/global/
  networks/my-network
  projects/myproject/global/networks/my-network
  global/networks/default

* `source_ranges` -
  If source ranges are specified, the firewall will apply only to
  traffic that has source IP address in these ranges. These ranges must
  be expressed in CIDR format. One or both of sourceRanges and
  sourceTags may be set. If both properties are set, the firewall will
  apply to traffic that has source IP address within sourceRanges OR the
  source IP that belongs to a tag listed in the sourceTags property. The
  connection does not need to match both properties for the firewall to
  apply. Only IPv4 is supported.

* `source_tags` -
  If source tags are specified, the firewall will apply only to traffic
  with source IP that belongs to a tag listed in source tags. Source
  tags cannot be used to control traffic to an instance's external IP
  address. Because tags are associated with an instance, not an IP
  address. One or both of sourceRanges and sourceTags may be set. If
  both properties are set, the firewall will apply to traffic that has
  source IP address within sourceRanges OR the source IP that belongs to
  a tag listed in the sourceTags property. The connection does not need
  to match both properties for the firewall to apply.

* `target_tags` -
  A list of instance tags indicating sets of instances located in the
  network that may make network connections as specified in allowed[].
  If no targetTags are specified, the firewall rule applies to all
  instances on the specified network.

#### Label
Set the `f_label` property when attempting to set primary key
of this object. The primary key will always be referred to by the initials of
the resource followed by "_label"

### gcompute_global_address
Represents a Global Address resource. Global addresses are used for
HTTP(S) load balancing.


#### Example

```ruby
gcompute_global_address 'my-app-lb' do
  action :create
  project 'google.com:graphite-playground'
  credential 'mycred'
end

```

#### Reference

```ruby
gcompute_global_address 'id-for-resource' do
  address            string
  creation_timestamp time
  description        string
  id                 integer
  name               string
  region             reference to gcompute_region
  project            string
  credential         reference to gauth_credential
end
```

#### Actions

* `create` -
  Converges the `gcompute_global_address` resource into the final
  state described within the block. If the resource does not exist, Chef will
  attempt to create it.
* `delete` -
  Ensures the `gcompute_global_address` resource is not present.
  If the resource already exists Chef will attempt to delete it.

#### Properties

* `address` -
  Output only. The static external IP address represented by this resource.

* `creation_timestamp` -
  Output only. Creation timestamp in RFC3339 text format.

* `description` -
  An optional description of this resource.
  Provide this property when you create the resource.

* `id` -
  Output only. The unique identifier for the resource. This identifier is
  defined by
  the server.

* `name` -
  Name of the resource. Provided by the client when the resource is
  created. The name must be 1-63 characters long, and comply with
  RFC1035.  Specifically, the name must be 1-63 characters long and
  match the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means
  the first character must be a lowercase letter, and all following
  characters must be a dash, lowercase letter, or digit, except the last
  character, which cannot be a dash.

* `region` -
  Output only. A reference to Region resource

#### Label
Set the `ga_label` property when attempting to set primary key
of this object. The primary key will always be referred to by the initials of
the resource followed by "_label"

### gcompute_http_health_check
An HttpHealthCheck resource. This resource defines a template for how
individual VMs should be checked for health, via HTTP.


#### Example

```ruby
gcompute_http_health_check 'app-health-check' do
  action :create
  hhc_label 'my-app-http-hc'
  healthy_threshold 10
  port 8080
  timeout_sec 2
  unhealthy_threshold 5
  project 'google.com:graphite-playground'
  credential 'mycred'
end

```

#### Reference

```ruby
gcompute_http_health_check 'id-for-resource' do
  check_interval_sec  integer
  creation_timestamp  time
  description         string
  healthy_threshold   integer
  host                string
  id                  integer
  name                string
  port                integer
  request_path        string
  timeout_sec         integer
  unhealthy_threshold integer
  project             string
  credential          reference to gauth_credential
end
```

#### Actions

* `create` -
  Converges the `gcompute_http_health_check` resource into the final
  state described within the block. If the resource does not exist, Chef will
  attempt to create it.
* `delete` -
  Ensures the `gcompute_http_health_check` resource is not present.
  If the resource already exists Chef will attempt to delete it.

#### Properties

* `check_interval_sec` -
  How often (in seconds) to send a health check. The default value is 5
  seconds.

* `creation_timestamp` -
  Output only. Creation timestamp in RFC3339 text format.

* `description` -
  An optional description of this resource. Provide this property when
  you create the resource.

* `healthy_threshold` -
  A so-far unhealthy instance will be marked healthy after this many
  consecutive successes. The default value is 2.

* `host` -
  The value of the host header in the HTTP health check request. If
  left empty (default value), the public IP on behalf of which this
  health check is performed will be used.

* `id` -
  Output only. The unique identifier for the resource. This identifier is
  defined by
  the server.

* `name` -
  Name of the resource. Provided by the client when the resource is
  created. The name must be 1-63 characters long, and comply with
  RFC1035.  Specifically, the name must be 1-63 characters long and
  match the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means
  the first character must be a lowercase letter, and all following
  characters must be a dash, lowercase letter, or digit, except the
  last character, which cannot be a dash.

* `port` -
  The TCP port number for the HTTP health check request.
  The default value is 80.

* `request_path` -
  The request path of the HTTP health check request.
  The default value is /.

* `timeout_sec` -
  How long (in seconds) to wait before claiming failure.
  The default value is 5 seconds.  It is invalid for timeoutSec to have
  greater value than checkIntervalSec.

* `unhealthy_threshold` -
  A so-far healthy instance will be marked unhealthy after this many
  consecutive failures. The default value is 2.

#### Label
Set the `hhc_label` property when attempting to set primary key
of this object. The primary key will always be referred to by the initials of
the resource followed by "_label"

### gcompute_https_health_check
An HttpsHealthCheck resource. This resource defines a template for how
individual VMs should be checked for health, via HTTPS.


#### Example

```ruby
gcompute_https_health_check 'app-health-check' do
  action :create
  hhc_label 'my-app-https-hc'
  healthy_threshold 10
  port 8080
  timeout_sec 2
  unhealthy_threshold 5
  project 'google.com:graphite-playground'
  credential 'mycred'
end

```

#### Reference

```ruby
gcompute_https_health_check 'id-for-resource' do
  check_interval_sec  integer
  creation_timestamp  time
  description         string
  healthy_threshold   integer
  host                string
  id                  integer
  name                string
  port                integer
  request_path        string
  timeout_sec         integer
  unhealthy_threshold integer
  project             string
  credential          reference to gauth_credential
end
```

#### Actions

* `create` -
  Converges the `gcompute_https_health_check` resource into the final
  state described within the block. If the resource does not exist, Chef will
  attempt to create it.
* `delete` -
  Ensures the `gcompute_https_health_check` resource is not present.
  If the resource already exists Chef will attempt to delete it.

#### Properties

* `check_interval_sec` -
  How often (in seconds) to send a health check. The default value is 5
  seconds.

* `creation_timestamp` -
  Output only. Creation timestamp in RFC3339 text format.

* `description` -
  An optional description of this resource. Provide this property when
  you create the resource.

* `healthy_threshold` -
  A so-far unhealthy instance will be marked healthy after this many
  consecutive successes. The default value is 2.

* `host` -
  The value of the host header in the HTTPS health check request. If
  left empty (default value), the public IP on behalf of which this
  health check is performed will be used.

* `id` -
  Output only. The unique identifier for the resource. This identifier is
  defined by
  the server.

* `name` -
  Name of the resource. Provided by the client when the resource is
  created. The name must be 1-63 characters long, and comply with
  RFC1035.  Specifically, the name must be 1-63 characters long and
  match the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means
  the first character must be a lowercase letter, and all following
  characters must be a dash, lowercase letter, or digit, except the
  last character, which cannot be a dash.

* `port` -
  The TCP port number for the HTTPS health check request.
  The default value is 80.

* `request_path` -
  The request path of the HTTPS health check request.
  The default value is /.

* `timeout_sec` -
  How long (in seconds) to wait before claiming failure.
  The default value is 5 seconds.  It is invalid for timeoutSec to have
  greater value than checkIntervalSec.

* `unhealthy_threshold` -
  A so-far healthy instance will be marked unhealthy after this many
  consecutive failures. The default value is 2.

#### Label
Set the `hhc_label` property when attempting to set primary key
of this object. The primary key will always be referred to by the initials of
the resource followed by "_label"

### gcompute_health_check
An HealthCheck resource. This resource defines a template for how individual virtual machines should be checked for health, via one of the supported protocols.

#### Example

```ruby
gcompute_health_check 'app-health-check' do
  action :create
  type 'TCP'
  tcp_health_check(
    port: 6123,
    request: 'ping',
    response: 'pong'
  )
  healthy_threshold 10
  timeout_sec 2
  unhealthy_threshold 5
  project 'google.com:graphite-playground'
  credential 'mycred'
end

```

#### Reference

```ruby
gcompute_health_check 'id-for-resource' do
  check_interval_sec  integer
  creation_timestamp  time
  description         string
  healthy_threshold   integer
  http_health_check   {
    host         string,
    port         integer,
    port_name    string,
    proxy_header 'NONE' or 'PROXY_V1',
    request_path string,
  }
  https_health_check  {
    host         string,
    port         integer,
    port_name    string,
    proxy_header 'NONE' or 'PROXY_V1',
    request_path string,
  }
  id                  integer
  name                string
  ssl_health_check    {
    port         integer,
    port_name    string,
    proxy_header 'NONE' or 'PROXY_V1',
    request      string,
    response     string,
  }
  tcp_health_check    {
    port         integer,
    port_name    string,
    proxy_header 'NONE' or 'PROXY_V1',
    request      string,
    response     string,
  }
  timeout_sec         integer
  type                'TCP', 'SSL' or 'HTTP'
  unhealthy_threshold integer
  project             string
  credential          reference to gauth_credential
end
```

#### Actions

* `create` -
  Converges the `gcompute_health_check` resource into the final
  state described within the block. If the resource does not exist, Chef will
  attempt to create it.
* `delete` -
  Ensures the `gcompute_health_check` resource is not present.
  If the resource already exists Chef will attempt to delete it.

#### Properties

* `check_interval_sec` -
  How often (in seconds) to send a health check. The default value is 5
  seconds.

* `creation_timestamp` -
  Output only. Creation timestamp in RFC3339 text format.

* `description` -
  An optional description of this resource. Provide this property when
  you create the resource.

* `healthy_threshold` -
  A so-far unhealthy instance will be marked healthy after this many
  consecutive successes. The default value is 2.

* `id` -
  Output only. The unique identifier for the resource. This identifier is
  defined by
  the server.

* `name` -
  Name of the resource. Provided by the client when the resource is
  created. The name must be 1-63 characters long, and comply with
  RFC1035.  Specifically, the name must be 1-63 characters long and
  match the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means
  the first character must be a lowercase letter, and all following
  characters must be a dash, lowercase letter, or digit, except the
  last character, which cannot be a dash.

* `timeout_sec` -
  How long (in seconds) to wait before claiming failure.
  The default value is 5 seconds.  It is invalid for timeoutSec to have
  greater value than checkIntervalSec.

* `unhealthy_threshold` -
  A so-far healthy instance will be marked unhealthy after this many
  consecutive failures. The default value is 2.

* `type` -
  Specifies the type of the healthCheck, either TCP, SSL, HTTP or
  HTTPS. If not specified, the default is TCP. Exactly one of the
  protocol-specific health check field must be specified, which must
  match type field.

* `http_health_check` -
  A nested object resource

* `http_health_check/host`
  The value of the host header in the HTTP health check request.
  If left empty (default value), the public IP on behalf of which this health
  check is performed will be used.

* `http_health_check/request_path`
  The request path of the HTTP health check request.
  The default value is /.

* `http_health_check/port`
  The TCP port number for the HTTP health check request.
  The default value is 80.

* `http_health_check/port_name`
  Port name as defined in InstanceGroup#NamedPort#name. If both port and
  port_name are defined, port takes precedence.

* `http_health_check/proxy_header`
  Specifies the type of proxy header to append before sending data to the
  backend, either NONE or PROXY_V1. The default is NONE.

* `https_health_check` -
  A nested object resource

* `https_health_check/host`
  The value of the host header in the HTTPS health check request.
  If left empty (default value), the public IP on behalf of which this health
  check is performed will be used.

* `https_health_check/request_path`
  The request path of the HTTPS health check request.
  The default value is /.

* `https_health_check/port`
  The TCP port number for the HTTPS health check request.
  The default value is 443.

* `https_health_check/port_name`
  Port name as defined in InstanceGroup#NamedPort#name. If both port and
  port_name are defined, port takes precedence.

* `https_health_check/proxy_header`
  Specifies the type of proxy header to append before sending data to the
  backend, either NONE or PROXY_V1. The default is NONE.

* `tcp_health_check` -
  A nested object resource

* `tcp_health_check/request`
  The application data to send once the TCP connection has been
  established (default value is empty). If both request and response are
  empty, the connection establishment alone will indicate health. The request
  data can only be ASCII.

* `tcp_health_check/response`
  The bytes to match against the beginning of the response data. If left empty
  (the default value), any response will indicate health. The response data
  can only be ASCII.

* `tcp_health_check/port`
  The TCP port number for the TCP health check request.
  The default value is 443.

* `tcp_health_check/port_name`
  Port name as defined in InstanceGroup#NamedPort#name. If both port and
  port_name are defined, port takes precedence.

* `tcp_health_check/proxy_header`
  Specifies the type of proxy header to append before sending data to the
  backend, either NONE or PROXY_V1. The default is NONE.

* `ssl_health_check` -
  A nested object resource

* `ssl_health_check/request`
  The application data to send once the SSL connection has been
  established (default value is empty). If both request and response are
  empty, the connection establishment alone will indicate health. The request
  data can only be ASCII.

* `ssl_health_check/response`
  The bytes to match against the beginning of the response data. If left empty
  (the default value), any response will indicate health. The response data
  can only be ASCII.

* `ssl_health_check/port`
  The TCP port number for the SSL health check request.
  The default value is 443.

* `ssl_health_check/port_name`
  Port name as defined in InstanceGroup#NamedPort#name. If both port and
  port_name are defined, port takes precedence.

* `ssl_health_check/proxy_header`
  Specifies the type of proxy header to append before sending data to the
  backend, either NONE or PROXY_V1. The default is NONE.

#### Label
Set the `hc_label` property when attempting to set primary key
of this object. The primary key will always be referred to by the initials of
the resource followed by "_label"

### gcompute_instance_template
Defines an Instance Template resource that provides configuration settings
for your virtual machine instances. Instance templates are not tied to the
lifetime of an instance and can be used and reused as to deploy virtual
machines. You can also use different templates to create different virtual
machine configurations. Instance templates are required when you create a
managed instance group.

Tip: Disks should be set to autoDelete=true
so that leftover disks are not left behind on machine deletion.


#### Example

```ruby
# Power Tips:
#   1) Remember to define the resources needed to allocate the VM:
#      a) gcompute_disk_type (to be used in 'diskType' property)
#      b) gcompute_machine_type (to be used in 'machine_type' property)
#      c) gcompute_network (to be used in 'network_interfaces' property)
#      d) gcompute_subnetwork (to be used in the 'subnetwork' property)
#      e) gcompute_disk (to be used in the 'sourceDisk' property)
#   2) Don't forget to define a source_image for the OS of the boot disk
gcompute_instance_template 'instance-template-test' do
  action :create
  properties(
    machine_type: 'n1-standard-1',
    disks: [
      {
        # Tip: Auto delete will prevent disks from being left behind on
        # deletion.
        auto_delete: true,
        boot: true,
        initialize_params: {
          disk_size_gb: 100,
          source_image:
            gcompute_image_family('ubuntu-1604-lts', 'ubuntu-os-cloud')
        }
      }
    ],
    network_interfaces: [
      {
        access_configs: {
          name: 'test-config',
          type: 'ONE_TO_ONE_NAT',
        },
        network: 'mynetwork-test'
      }
    ]
  )
  project 'google.com:graphite-playground'
  credential 'mycred'
end

```

#### Reference

```ruby
gcompute_instance_template 'id-for-resource' do
  creation_timestamp time
  description        string
  id                 integer
  name               string
  properties         {
    can_ip_forward     boolean,
    description        string,
    disks              [
      {
        auto_delete         boolean,
        boot                boolean,
        device_name         string,
        disk_encryption_key {
          raw_key           string,
          rsa_encrypted_key string,
          sha256            string,
        },
        index               integer,
        initialize_params   {
          disk_name                   string,
          disk_size_gb                integer,
          disk_type                   reference to gcompute_disk_type,
          source_image                string,
          source_image_encryption_key {
            raw_key string,
            sha256  string,
          },
        },
        interface           'SCSI' or 'NVME',
        mode                'READ_WRITE' or 'READ_ONLY',
        source              reference to gcompute_disk,
        type                'SCRATCH' or 'PERSISTENT',
      },
      ...
    ],
    guest_accelerators [
      {
        accelerator_count integer,
        accelerator_type  string,
      },
      ...
    ],
    machine_type       reference to gcompute_machine_type,
    metadata           {
      items namevalues,
    },
    network_interfaces [
      {
        access_configs  [
          {
            name   string,
            nat_ip reference to gcompute_address,
            type   ONE_TO_ONE_NAT,
          },
          ...
        ],
        alias_ip_ranges [
          {
            ip_cidr_range         string,
            subnetwork_range_name string,
          },
          ...
        ],
        name            string,
        network         reference to gcompute_network,
        network_ip      string,
        subnetwork      reference to gcompute_subnetwork,
      },
      ...
    ],
    scheduling         {
      automatic_restart   boolean,
      on_host_maintenance string,
      preemptible         boolean,
    },
    service_accounts   [
      {
        email  boolean,
        scopes [
          string,
          ...
        ],
      },
      ...
    ],
    tags               {
      fingerprint string,
      items       [
        string,
        ...
      ],
    },
  }
  project            string
  credential         reference to gauth_credential
end
```

#### Actions

* `create` -
  Converges the `gcompute_instance_template` resource into the final
  state described within the block. If the resource does not exist, Chef will
  attempt to create it.
* `delete` -
  Ensures the `gcompute_instance_template` resource is not present.
  If the resource already exists Chef will attempt to delete it.

#### Properties

* `creation_timestamp` -
  Output only. Creation timestamp in RFC3339 text format.

* `description` -
  An optional description of this resource. Provide this property when
  you create the resource.

* `id` -
  Output only. The unique identifier for the resource. This identifier
  is defined by the server.

* `name` -
  Required. Name of the resource. The name is 1-63 characters long
  and complies with RFC1035.

* `properties` -
  The instance properties for this instance template.

* `properties/can_ip_forward`
  Enables instances created based on this template to send packets
  with source IP addresses other than their own and receive packets
  with destination IP addresses other than their own. If these
  instances will be used as an IP gateway or it will be set as the
  next-hop in a Route resource, specify true. If unsure, leave this
  set to false.

* `properties/description`
  An optional text description for the instances that are created
  from this instance template.

* `properties/disks`
  An array of disks that are associated with the instances that are
  created from this template.

* `properties/disks[]/auto_delete`
  Specifies whether the disk will be auto-deleted when the
  instance is deleted (but not when the disk is detached from
  the instance).
  Tip: Disks should be set to autoDelete=true
  so that leftover disks are not left behind on machine
  deletion.

* `properties/disks[]/boot`
  Indicates that this is a boot disk. The virtual machine will
  use the first partition of the disk for its root filesystem.

* `properties/disks[]/device_name`
  Specifies a unique device name of your choice that is
  reflected into the /dev/disk/by-id/google-* tree of a Linux
  operating system running within the instance. This name can
  be used to reference the device for mounting, resizing, and
  so on, from within the instance.

* `properties/disks[]/disk_encryption_key`
  Encrypts or decrypts a disk using a customer-supplied
  encryption key.

* `properties/disks[]/disk_encryption_key/raw_key`
  Specifies a 256-bit customer-supplied encryption key,
  encoded in RFC 4648 base64 to either encrypt or decrypt
  this resource.

* `properties/disks[]/disk_encryption_key/rsa_encrypted_key`
  Specifies an RFC 4648 base64 encoded, RSA-wrapped
  2048-bit customer-supplied encryption key to either
  encrypt or decrypt this resource.

* `properties/disks[]/disk_encryption_key/sha256`
  Output only. The RFC 4648 base64 encoded SHA-256 hash of the
  customer-supplied encryption key that protects this
  resource.

* `properties/disks[]/index`
  Assigns a zero-based index to this disk, where 0 is
  reserved for the boot disk. For example, if you have many
  disks attached to an instance, each disk would have a
  unique index number. If not specified, the server will
  choose an appropriate value.

* `properties/disks[]/initialize_params`
  Required. Specifies the parameters for a new disk that will be
  created alongside the new instance. Use initialization
  parameters to create boot disks or local SSDs attached to
  the new instance.

* `properties/disks[]/initialize_params/disk_name`
  Specifies the disk name. If not specified, the default
  is to use the name of the instance.

* `properties/disks[]/initialize_params/disk_size_gb`
  Specifies the size of the disk in base-2 GB.

* `properties/disks[]/initialize_params/disk_type`
  A reference to DiskType resource

* `properties/disks[]/initialize_params/source_image`
  The source image to create this disk. When creating a
  new instance, one of initializeParams.sourceImage or
  disks.source is required.  To create a disk with one of
  the public operating system images, specify the image
  by its family name.

* `properties/disks[]/initialize_params/source_image_encryption_key`
  The customer-supplied encryption key of the source
  image. Required if the source image is protected by a
  customer-supplied encryption key.
  Instance templates do not store customer-supplied
  encryption keys, so you cannot create disks for
  instances in a managed instance group if the source
  images are encrypted with your own keys.

* `properties/disks[]/initialize_params/source_image_encryption_key/raw_key`
  Specifies a 256-bit customer-supplied encryption
  key, encoded in RFC 4648 base64 to either encrypt
  or decrypt this resource.

* `properties/disks[]/initialize_params/source_image_encryption_key/sha256`
  Output only. The RFC 4648 base64 encoded SHA-256 hash of the
  customer-supplied encryption key that protects this
  resource.

* `properties/disks[]/interface`
  Specifies the disk interface to use for attaching this
  disk, which is either SCSI or NVME. The default is SCSI.
  Persistent disks must always use SCSI and the request will
  fail if you attempt to attach a persistent disk in any
  other format than SCSI.

* `properties/disks[]/mode`
  The mode in which to attach this disk, either READ_WRITE or
  READ_ONLY. If not specified, the default is to attach the
  disk in READ_WRITE mode.

* `properties/disks[]/source`
  A reference to Disk resource

* `properties/disks[]/type`
  Specifies the type of the disk, either SCRATCH or
  PERSISTENT. If not specified, the default is PERSISTENT.

* `properties/machine_type`
  Required. A reference to MachineType resource

* `properties/metadata`
  The metadata key/value pairs to assign to instances that are
  created from this template. These pairs can consist of custom
  metadata or predefined keys.

* `properties/metadata/items`
  An array of tags. Each tag must be 1-63 characters long, and
  comply with RFC1035.

* `properties/guest_accelerators`
  List of the type and count of accelerator cards attached to the
  instance

* `properties/guest_accelerators[]/accelerator_count`
  The number of the guest accelerator cards exposed to this
  instance.

* `properties/guest_accelerators[]/accelerator_type`
  Full or partial URL of the accelerator type resource to expose
  to this instance.

* `properties/network_interfaces`
  An array of configurations for this interface. This specifies
  how this interface is configured to interact with other
  network services, such as connecting to the internet. Only
  one network interface is supported per instance.

* `properties/network_interfaces[]/access_configs`
  An array of configurations for this interface. Currently, only
  one access config, ONE_TO_ONE_NAT, is supported. If there are no
  accessConfigs specified, then this instance will have no
  external internet access.

* `properties/network_interfaces[]/access_configs[]/name`
  Required. The name of this access configuration. The
  default and recommended name is External NAT but you can
  use any arbitrary string you would like. For example, My
  external IP or Network Access.

* `properties/network_interfaces[]/access_configs[]/nat_ip`
  Required. A reference to Address resource

* `properties/network_interfaces[]/access_configs[]/type`
  Required. The type of configuration. The default and only option is
  ONE_TO_ONE_NAT.

* `properties/network_interfaces[]/alias_ip_ranges`
  An array of alias IP ranges for this network interface. Can
  only be specified for network interfaces on subnet-mode
  networks.

* `properties/network_interfaces[]/alias_ip_ranges[]/ip_cidr_range`
  The IP CIDR range represented by this alias IP range.
  This IP CIDR range must belong to the specified
  subnetwork and cannot contain IP addresses reserved by
  system or used by other network interfaces. This range
  may be a single IP address (e.g. 10.2.3.4), a netmask
  (e.g. /24) or a CIDR format string (e.g. 10.1.2.0/24).

* `properties/network_interfaces[]/alias_ip_ranges[]/subnetwork_range_name`
  Optional subnetwork secondary range name specifying
  the secondary range from which to allocate the IP
  CIDR range for this alias IP range. If left
  unspecified, the primary range of the subnetwork will
  be used.

* `properties/network_interfaces[]/name`
  Output only. The name of the network interface, generated by the
  server. For network devices, these are eth0, eth1, etc

* `properties/network_interfaces[]/network`
  A reference to Network resource

* `properties/network_interfaces[]/network_ip`
  An IPv4 internal network address to assign to the
  instance for this network interface. If not specified
  by the user, an unused internal IP is assigned by the
  system.

* `properties/network_interfaces[]/subnetwork`
  A reference to Subnetwork resource

* `properties/scheduling`
  Sets the scheduling options for this instance.

* `properties/scheduling/automatic_restart`
  Specifies whether the instance should be automatically restarted
  if it is terminated by Compute Engine (not terminated by a user).
  You can only set the automatic restart option for standard
  instances. Preemptible instances cannot be automatically
  restarted.

* `properties/scheduling/on_host_maintenance`
  Defines the maintenance behavior for this instance. For standard
  instances, the default behavior is MIGRATE. For preemptible
  instances, the default and only possible behavior is TERMINATE.
  For more information, see Setting Instance Scheduling Options.

* `properties/scheduling/preemptible`
  Defines whether the instance is preemptible. This can only be set
  during instance creation, it cannot be set or changed after the
  instance has been created.

* `properties/service_accounts`
  A list of service accounts, with their specified scopes, authorized
  for this instance. Only one service account per VM instance is
  supported.

* `properties/service_accounts[]/email`
  Email address of the service account.

* `properties/service_accounts[]/scopes`
  The list of scopes to be made available for this service
  account.

* `properties/tags`
  A list of tags to apply to this instance. Tags are used to identify
  valid sources or targets for network firewalls and are specified by
  the client during instance creation. The tags can be later modified
  by the setTags method. Each tag within the list must comply with
  RFC1035.

* `properties/tags/fingerprint`
  Specifies a fingerprint for this request, which is essentially a
  hash of the metadata's contents and used for optimistic locking.
  The fingerprint is initially generated by Compute Engine and
  changes after every request to modify or update metadata. You
  must always provide an up-to-date fingerprint hash in order to
  update or change metadata.

* `properties/tags/items`
  An array of tags. Each tag must be 1-63 characters long, and
  comply with RFC1035.

#### Label
Set the `it_label` property when attempting to set primary key
of this object. The primary key will always be referred to by the initials of
the resource followed by "_label"

### gcompute_license
A License resource represents a software license. Licenses are used to
track software usage in images, persistent disks, snapshots, and virtual
machine instances.


#### Example

```ruby
gcompute_license 'test-license' do
  project 'google.com:graphite-playground'
  credential 'mycred'
end

```

#### Reference

```ruby
gcompute_license 'id-for-resource' do
  charges_use_fee boolean
  name            string
  project         string
  credential      reference to gauth_credential
end
```

#### Actions

* `create` -
  Converges the `gcompute_license` resource into the final
  state described within the block. If the resource does not exist, Chef will
  attempt to create it.
* `delete` -
  Ensures the `gcompute_license` resource is not present.
  If the resource already exists Chef will attempt to delete it.

#### Properties

* `name` -
  Output only. Name of the resource. The name is 1-63 characters long
  and complies with RFC1035.

* `charges_use_fee` -
  Output only. If true, the customer will be charged license fee for
  running software that contains this license on an instance.

#### Label
Set the `l_label` property when attempting to set primary key
of this object. The primary key will always be referred to by the initials of
the resource followed by "_label"

### gcompute_image
Represents an Image resource.

Google Compute Engine uses operating system images to create the root
persistent disks for your instances. You specify an image when you create
an instance. Images contain a boot loader, an operating system, and a
root file system. Linux operating system images are also capable of
running containers on Compute Engine.

Images can be either public or custom.

Public images are provided and maintained by Google, open-source
communities, and third-party vendors. By default, all projects have
access to these images and can use them to create instances.  Custom
images are available only to your project. You can create a custom image
from root persistent disks and other images. Then, use the custom image
to create an instance.


#### Example

```ruby
# Tip: Be sure to include a valid gcompute_disk object
gcompute_image 'test-image' do
  action :create
  source_disk 'data-disk-1'
  project 'google.com:graphite-playground'
  credential 'mycred'
end

```

#### Reference

```ruby
gcompute_image 'id-for-resource' do
  archive_size_bytes         integer
  creation_timestamp         time
  deprecated                 {
    deleted     time,
    deprecated  time,
    obsolete    time,
    replacement string,
    state       'DEPRECATED', 'OBSOLETE' or 'DELETED',
  }
  description                string
  disk_size_gb               integer
  family                     string
  guest_os_features          [
    {
      type VIRTIO_SCSI_MULTIQUEUE,
    },
    ...
  ]
  id                         integer
  image_encryption_key       {
    raw_key string,
    sha256  string,
  }
  licenses                   [
    string,
    ...
  ]
  name                       string
  raw_disk                   {
    container_type TAR,
    sha1_checksum  string,
    source         string,
  }
  source_disk                reference to gcompute_disk
  source_disk_encryption_key {
    raw_key string,
    sha256  string,
  }
  source_disk_id             string
  source_type                RAW
  project                    string
  credential                 reference to gauth_credential
end
```

#### Actions

* `create` -
  Converges the `gcompute_image` resource into the final
  state described within the block. If the resource does not exist, Chef will
  attempt to create it.
* `delete` -
  Ensures the `gcompute_image` resource is not present.
  If the resource already exists Chef will attempt to delete it.

#### Properties

* `archive_size_bytes` -
  Output only. Size of the image tar.gz archive stored in Google Cloud
  Storage (in
  bytes).

* `creation_timestamp` -
  Output only. Creation timestamp in RFC3339 text format.

* `deprecated` -
  Output only. The deprecation status associated with this image.

* `deprecated/deleted`
  An optional RFC3339 timestamp on or after which the state of this
  resource is intended to change to DELETED. This is only
  informational and the status will not change unless the client
  explicitly changes it.

* `deprecated/deprecated`
  An optional RFC3339 timestamp on or after which the state of this
  resource is intended to change to DEPRECATED. This is only
  informational and the status will not change unless the client
  explicitly changes it.

* `deprecated/obsolete`
  An optional RFC3339 timestamp on or after which the state of this
  resource is intended to change to OBSOLETE. This is only
  informational and the status will not change unless the client
  explicitly changes it.

* `deprecated/replacement`
  The URL of the suggested replacement for a deprecated resource.
  The suggested replacement resource must be the same kind of
  resource as the deprecated resource.

* `deprecated/state`
  The deprecation state of this resource. This can be DEPRECATED,
  OBSOLETE, or DELETED. Operations which create a new resource
  using a DEPRECATED resource will return successfully, but with a
  warning indicating the deprecated resource and recommending its
  replacement. Operations which use OBSOLETE or DELETED resources
  will be rejected and result in an error.

* `description` -
  An optional description of this resource. Provide this property when
  you create the resource.

* `disk_size_gb` -
  Size of the image when restored onto a persistent disk (in GB).

* `family` -
  The name of the image family to which this image belongs. You can
  create disks by specifying an image family instead of a specific
  image name. The image family always returns its latest image that is
  not deprecated. The name of the image family must comply with
  RFC1035.

* `guest_os_features` -
  A list of features to enable on the guest OS. Applicable for
  bootable images only. Currently, only one feature can be enabled,
  VIRTIO_SCSI_MULTIQUEUE, which allows each virtual CPU to have its
  own queue. For Windows images, you can only enable
  VIRTIO_SCSI_MULTIQUEUE on images with driver version 1.2.0.1621 or
  higher. Linux images with kernel versions 3.17 and higher will
  support VIRTIO_SCSI_MULTIQUEUE.
  For new Windows images, the server might also populate this field
  with the value WINDOWS, to indicate that this is a Windows image.
  This value is purely informational and does not enable or disable
  any features.

* `guest_os_features[]/type`
  The type of supported feature. Currenty only
  VIRTIO_SCSI_MULTIQUEUE is supported. For newer Windows images,
  the server might also populate this property with the value
  WINDOWS to indicate that this is a Windows image. This value is
  purely informational and does not enable or disable any
  features.

* `id` -
  Output only. The unique identifier for the resource. This identifier
  is defined by the server.

* `image_encryption_key` -
  Encrypts the image using a customer-supplied encryption key.
  After you encrypt an image with a customer-supplied key, you must
  provide the same key if you use the image later (e.g. to create a
  disk from the image)

* `image_encryption_key/raw_key`
  Specifies a 256-bit customer-supplied encryption key, encoded in
  RFC 4648 base64 to either encrypt or decrypt this resource.

* `image_encryption_key/sha256`
  Output only. The RFC 4648 base64 encoded SHA-256 hash of the
  customer-supplied encryption key that protects this resource.

* `licenses` -
  Any applicable license URI.

* `name` -
  Name of the resource; provided by the client when the resource is
  created. The name must be 1-63 characters long, and comply with
  RFC1035. Specifically, the name must be 1-63 characters long and
  match the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means
  the first character must be a lowercase letter, and all following
  characters must be a dash, lowercase letter, or digit, except the
  last character, which cannot be a dash.

* `raw_disk` -
  The parameters of the raw disk image.

* `raw_disk/container_type`
  The format used to encode and transmit the block device, which
  should be TAR. This is just a container and transmission format
  and not a runtime format. Provided by the client when the disk
  image is created.

* `raw_disk/sha1_checksum`
  An optional SHA1 checksum of the disk image before unpackaging.
  This is provided by the client when the disk image is created.

* `raw_disk/source`
  The full Google Cloud Storage URL where disk storage is stored
  You must provide either this property or the sourceDisk property
  but not both.

* `source_disk` -
  A reference to Disk resource

* `source_disk_encryption_key` -
  The customer-supplied encryption key of the source disk. Required if
  the source disk is protected by a customer-supplied encryption key.

* `source_disk_encryption_key/raw_key`
  Specifies a 256-bit customer-supplied encryption key, encoded in
  RFC 4648 base64 to either encrypt or decrypt this resource.

* `source_disk_encryption_key/sha256`
  Output only. The RFC 4648 base64 encoded SHA-256 hash of the
  customer-supplied encryption key that protects this resource.

* `source_disk_id` -
  The ID value of the disk used to create this image. This value may
  be used to determine whether the image was taken from the current
  or a previous instance of a given disk name.

* `source_type` -
  The type of the image used to create this disk. The default and
  only value is RAW

#### Label
Set the `i_label` property when attempting to set primary key
of this object. The primary key will always be referred to by the initials of
the resource followed by "_label"

### gcompute_instance
An instance is a virtual machine (VM) hosted on Google's infrastructure.


#### Example

```ruby
# Power Tips:
#   1) Remember to define the resources needed to allocate the VM:
#      a) gcompute_disk (to be used in 'disks' property)
#      b) gcompute_network (to be used in 'network' property)
#      c) gcompute_address (to be used in 'access_configs', if your machine
#         needs external ingress access)
#      d) gcompute_zone (to determine where the VM will be allocated)
#      e) gcompute_machine_type (to determine the kind of machine to be created)
#   2) Don't forget to define a source_image for the OS of the boot disk
#      a) You can use the provided gcompute_image_family function to specify the
#         latest version of an operating system of a given family
#         e.g. Ubuntu 16.04
gcompute_instance 'instance-test' do
  action :create
  machine_type 'n1-standard-1'
  disks [
    {
      boot: true,
      auto_delete: true,
      source: 'instance-test-os-1'
    }
  ]
  network_interfaces [
    {
      network: 'mynetwork-test',
      access_configs: [
        {
          name: 'External NAT',
          nat_ip: 'instance-test-ip',
          type: 'ONE_TO_ONE_NAT'
        }
      ]
    }
  ]
  zone 'us-west1-a'
  project 'google.com:graphite-playground'
  credential 'mycred'
end

```

#### Reference

```ruby
gcompute_instance 'id-for-resource' do
  can_ip_forward     boolean
  cpu_platform       string
  creation_timestamp string
  disks              [
    {
      auto_delete         boolean,
      boot                boolean,
      device_name         string,
      disk_encryption_key {
        raw_key           string,
        rsa_encrypted_key string,
        sha256            string,
      },
      index               integer,
      initialize_params   {
        disk_name                   string,
        disk_size_gb                integer,
        disk_type                   reference to gcompute_disk_type,
        source_image                string,
        source_image_encryption_key {
          raw_key string,
          sha256  string,
        },
      },
      interface           'SCSI' or 'NVME',
      mode                'READ_WRITE' or 'READ_ONLY',
      source              reference to gcompute_disk,
      type                'SCRATCH' or 'PERSISTENT',
    },
    ...
  ]
  guest_accelerators [
    {
      accelerator_count integer,
      accelerator_type  string,
    },
    ...
  ]
  id                 integer
  label_fingerprint  string
  machine_type       reference to gcompute_machine_type
  metadata           {
    items namevalues,
  }
  min_cpu_platform   string
  name               string
  network_interfaces [
    {
      access_configs  [
        {
          name   string,
          nat_ip reference to gcompute_address,
          type   ONE_TO_ONE_NAT,
        },
        ...
      ],
      alias_ip_ranges [
        {
          ip_cidr_range         string,
          subnetwork_range_name string,
        },
        ...
      ],
      name            string,
      network         reference to gcompute_network,
      network_ip      string,
      subnetwork      reference to gcompute_subnetwork,
    },
    ...
  ]
  scheduling         {
    automatic_restart   boolean,
    on_host_maintenance string,
    preemptible         boolean,
  }
  service_accounts   [
    {
      email  boolean,
      scopes [
        string,
        ...
      ],
    },
    ...
  ]
  status             string
  status_message     string
  tags               {
    fingerprint string,
    items       [
      string,
      ...
    ],
  }
  zone               reference to gcompute_zone
  project            string
  credential         reference to gauth_credential
end
```

#### Actions

* `create` -
  Converges the `gcompute_instance` resource into the final
  state described within the block. If the resource does not exist, Chef will
  attempt to create it.
* `delete` -
  Ensures the `gcompute_instance` resource is not present.
  If the resource already exists Chef will attempt to delete it.

#### Properties

* `can_ip_forward` -
  Allows this instance to send and receive packets with non-matching
  destination or source IPs. This is required if you plan to use this
  instance to forward routes.

* `cpu_platform` -
  Output only. The CPU platform used by this instance.

* `creation_timestamp` -
  Output only. Creation timestamp in RFC3339 text format.

* `disks` -
  An array of disks that are associated with the instances that are
  created from this template.

* `disks[]/auto_delete`
  Specifies whether the disk will be auto-deleted when the
  instance is deleted (but not when the disk is detached from
  the instance).
  Tip: Disks should be set to autoDelete=true
  so that leftover disks are not left behind on machine
  deletion.

* `disks[]/boot`
  Indicates that this is a boot disk. The virtual machine will
  use the first partition of the disk for its root filesystem.

* `disks[]/device_name`
  Specifies a unique device name of your choice that is
  reflected into the /dev/disk/by-id/google-* tree of a Linux
  operating system running within the instance. This name can
  be used to reference the device for mounting, resizing, and
  so on, from within the instance.

* `disks[]/disk_encryption_key`
  Encrypts or decrypts a disk using a customer-supplied
  encryption key.

* `disks[]/disk_encryption_key/raw_key`
  Specifies a 256-bit customer-supplied encryption key,
  encoded in RFC 4648 base64 to either encrypt or decrypt
  this resource.

* `disks[]/disk_encryption_key/rsa_encrypted_key`
  Specifies an RFC 4648 base64 encoded, RSA-wrapped
  2048-bit customer-supplied encryption key to either
  encrypt or decrypt this resource.

* `disks[]/disk_encryption_key/sha256`
  Output only. The RFC 4648 base64 encoded SHA-256 hash of the
  customer-supplied encryption key that protects this
  resource.

* `disks[]/index`
  Assigns a zero-based index to this disk, where 0 is
  reserved for the boot disk. For example, if you have many
  disks attached to an instance, each disk would have a
  unique index number. If not specified, the server will
  choose an appropriate value.

* `disks[]/initialize_params`
  Required. Specifies the parameters for a new disk that will be
  created alongside the new instance. Use initialization
  parameters to create boot disks or local SSDs attached to
  the new instance.

* `disks[]/initialize_params/disk_name`
  Specifies the disk name. If not specified, the default
  is to use the name of the instance.

* `disks[]/initialize_params/disk_size_gb`
  Specifies the size of the disk in base-2 GB.

* `disks[]/initialize_params/disk_type`
  A reference to DiskType resource

* `disks[]/initialize_params/source_image`
  The source image to create this disk. When creating a
  new instance, one of initializeParams.sourceImage or
  disks.source is required.  To create a disk with one of
  the public operating system images, specify the image
  by its family name.

* `disks[]/initialize_params/source_image_encryption_key`
  The customer-supplied encryption key of the source
  image. Required if the source image is protected by a
  customer-supplied encryption key.
  Instance templates do not store customer-supplied
  encryption keys, so you cannot create disks for
  instances in a managed instance group if the source
  images are encrypted with your own keys.

* `disks[]/initialize_params/source_image_encryption_key/raw_key`
  Specifies a 256-bit customer-supplied encryption
  key, encoded in RFC 4648 base64 to either encrypt
  or decrypt this resource.

* `disks[]/initialize_params/source_image_encryption_key/sha256`
  Output only. The RFC 4648 base64 encoded SHA-256 hash of the
  customer-supplied encryption key that protects this
  resource.

* `disks[]/interface`
  Specifies the disk interface to use for attaching this
  disk, which is either SCSI or NVME. The default is SCSI.
  Persistent disks must always use SCSI and the request will
  fail if you attempt to attach a persistent disk in any
  other format than SCSI.

* `disks[]/mode`
  The mode in which to attach this disk, either READ_WRITE or
  READ_ONLY. If not specified, the default is to attach the
  disk in READ_WRITE mode.

* `disks[]/source`
  A reference to Disk resource

* `disks[]/type`
  Specifies the type of the disk, either SCRATCH or
  PERSISTENT. If not specified, the default is PERSISTENT.

* `guest_accelerators` -
  List of the type and count of accelerator cards attached to the
  instance

* `guest_accelerators[]/accelerator_count`
  The number of the guest accelerator cards exposed to this
  instance.

* `guest_accelerators[]/accelerator_type`
  Full or partial URL of the accelerator type resource to expose
  to this instance.

* `id` -
  Output only. The unique identifier for the resource. This identifier is
  defined by
  the server.

* `label_fingerprint` -
  A fingerprint for this request, which is essentially a hash of the
  metadata's contents and used for optimistic locking. The fingerprint
  is initially generated by Compute Engine and changes after every
  request to modify or update metadata. You must always provide an
  up-to-date fingerprint hash in order to update or change metadata.

* `metadata` -
  The metadata key/value pairs to assign to instances that are
  created from this template. These pairs can consist of custom
  metadata or predefined keys.

* `metadata/items`
  An array of tags. Each tag must be 1-63 characters long, and
  comply with RFC1035.

* `machine_type` -
  A reference to MachineType resource

* `min_cpu_platform` -
  Specifies a minimum CPU platform for the VM instance. Applicable
  values are the friendly names of CPU platforms

* `name` -
  The name of the resource, provided by the client when initially
  creating the resource. The resource name must be 1-63 characters long,
  and comply with RFC1035. Specifically, the name must be 1-63
  characters long and match the regular expression
  [a-z]([-a-z0-9]*[a-z0-9])? which means the first character must be a
  lowercase letter, and all following characters must be a dash,
  lowercase letter, or digit, except the last character, which cannot
  be a dash.

* `network_interfaces` -
  An array of configurations for this interface. This specifies
  how this interface is configured to interact with other
  network services, such as connecting to the internet. Only
  one network interface is supported per instance.

* `network_interfaces[]/access_configs`
  An array of configurations for this interface. Currently, only
  one access config, ONE_TO_ONE_NAT, is supported. If there are no
  accessConfigs specified, then this instance will have no
  external internet access.

* `network_interfaces[]/access_configs[]/name`
  Required. The name of this access configuration. The
  default and recommended name is External NAT but you can
  use any arbitrary string you would like. For example, My
  external IP or Network Access.

* `network_interfaces[]/access_configs[]/nat_ip`
  Required. A reference to Address resource

* `network_interfaces[]/access_configs[]/type`
  Required. The type of configuration. The default and only option is
  ONE_TO_ONE_NAT.

* `network_interfaces[]/alias_ip_ranges`
  An array of alias IP ranges for this network interface. Can
  only be specified for network interfaces on subnet-mode
  networks.

* `network_interfaces[]/alias_ip_ranges[]/ip_cidr_range`
  The IP CIDR range represented by this alias IP range.
  This IP CIDR range must belong to the specified
  subnetwork and cannot contain IP addresses reserved by
  system or used by other network interfaces. This range
  may be a single IP address (e.g. 10.2.3.4), a netmask
  (e.g. /24) or a CIDR format string (e.g. 10.1.2.0/24).

* `network_interfaces[]/alias_ip_ranges[]/subnetwork_range_name`
  Optional subnetwork secondary range name specifying
  the secondary range from which to allocate the IP
  CIDR range for this alias IP range. If left
  unspecified, the primary range of the subnetwork will
  be used.

* `network_interfaces[]/name`
  Output only. The name of the network interface, generated by the
  server. For network devices, these are eth0, eth1, etc

* `network_interfaces[]/network`
  A reference to Network resource

* `network_interfaces[]/network_ip`
  An IPv4 internal network address to assign to the
  instance for this network interface. If not specified
  by the user, an unused internal IP is assigned by the
  system.

* `network_interfaces[]/subnetwork`
  A reference to Subnetwork resource

* `scheduling` -
  Sets the scheduling options for this instance.

* `scheduling/automatic_restart`
  Specifies whether the instance should be automatically restarted
  if it is terminated by Compute Engine (not terminated by a user).
  You can only set the automatic restart option for standard
  instances. Preemptible instances cannot be automatically
  restarted.

* `scheduling/on_host_maintenance`
  Defines the maintenance behavior for this instance. For standard
  instances, the default behavior is MIGRATE. For preemptible
  instances, the default and only possible behavior is TERMINATE.
  For more information, see Setting Instance Scheduling Options.

* `scheduling/preemptible`
  Defines whether the instance is preemptible. This can only be set
  during instance creation, it cannot be set or changed after the
  instance has been created.

* `service_accounts` -
  A list of service accounts, with their specified scopes, authorized
  for this instance. Only one service account per VM instance is
  supported.

* `service_accounts[]/email`
  Email address of the service account.

* `service_accounts[]/scopes`
  The list of scopes to be made available for this service
  account.

* `status` -
  Output only. The status of the instance. One of the following values:
  PROVISIONING, STAGING, RUNNING, STOPPING, SUSPENDING, SUSPENDED,
  and TERMINATED.

* `status_message` -
  Output only. An optional, human-readable explanation of the status.

* `tags` -
  A list of tags to apply to this instance. Tags are used to identify
  valid sources or targets for network firewalls and are specified by
  the client during instance creation. The tags can be later modified
  by the setTags method. Each tag within the list must comply with
  RFC1035.

* `tags/fingerprint`
  Specifies a fingerprint for this request, which is essentially a
  hash of the metadata's contents and used for optimistic locking.
  The fingerprint is initially generated by Compute Engine and
  changes after every request to modify or update metadata. You
  must always provide an up-to-date fingerprint hash in order to
  update or change metadata.

* `tags/items`
  An array of tags. Each tag must be 1-63 characters long, and
  comply with RFC1035.

* `zone` -
  Required. A reference to Zone resource

#### Label
Set the `i_label` property when attempting to set primary key
of this object. The primary key will always be referred to by the initials of
the resource followed by "_label"

### gcompute_instance_group
Represents an Instance Group resource. Instance groups are self-managed
and can contain identical or different instances. Instance groups do not
use an instance template. Unlike managed instance groups, you must create
and add instances to an instance group manually.


#### Example

```ruby
# Instance group requires a network and a region, so define them in your recipe:
#   - gcompute_network 'my-network' do ... end
#   - gcompute_zone 'my-zone' do ... end
gcompute_instance_group 'my-masters' do
  action :create
  named_ports [
    {
      name: 'test-port',
      port: 8141
    }
  ]
  network 'my-network'
  zone 'us-central1-a'
  project 'google.com:graphite-playground'
  credential 'mycred'
end

```

#### Reference

```ruby
gcompute_instance_group 'id-for-resource' do
  creation_timestamp time
  description        string
  id                 integer
  name               string
  named_ports        [
    {
      name string,
      port integer,
    },
    ...
  ]
  network            reference to gcompute_network
  region             reference to gcompute_region
  subnetwork         reference to gcompute_subnetwork
  zone               reference to gcompute_zone
  project            string
  credential         reference to gauth_credential
end
```

#### Actions

* `create` -
  Converges the `gcompute_instance_group` resource into the final
  state described within the block. If the resource does not exist, Chef will
  attempt to create it.
* `delete` -
  Ensures the `gcompute_instance_group` resource is not present.
  If the resource already exists Chef will attempt to delete it.

#### Properties

* `creation_timestamp` -
  Output only. Creation timestamp in RFC3339 text format.

* `description` -
  An optional description of this resource. Provide this property when
  you create the resource.

* `id` -
  Output only. A unique identifier for this instance group.

* `name` -
  The name of the instance group.
  The name must be 1-63 characters long, and comply with RFC1035.

* `named_ports` -
  Assigns a name to a port number.
  For example: {name: "http", port: 80}.
  This allows the system to reference ports by the assigned name
  instead of a port number. Named ports can also contain multiple
  ports.
  For example: [{name: "http", port: 80},{name: "http", port: 8080}]
  Named ports apply to all instances in this instance group.

* `named_ports[]/name`
  The name for this named port.
  The name must be 1-63 characters long, and comply with RFC1035.

* `named_ports[]/port`
  The port number, which can be a value between 1 and 65535.

* `network` -
  A reference to Network resource

* `region` -
  A reference to Region resource

* `subnetwork` -
  A reference to Subnetwork resource

* `zone` -
  Required. A reference to Zone resource

#### Label
Set the `ig_label` property when attempting to set primary key
of this object. The primary key will always be referred to by the initials of
the resource followed by "_label"

### gcompute_machine_type
Represents a MachineType resource. Machine types determine the virtualized
hardware specifications of your virtual machine instances, such as the
amount of memory or number of virtual CPUs.


#### Example

```ruby
gcompute_machine_type 'n1-standard-1' do
  action :create
  zone 'us-west1-a'
  project 'google.com:graphite-playground'
  credential 'mycred'
end

```

#### Reference

```ruby
gcompute_machine_type 'id-for-resource' do
  creation_timestamp               time
  deprecated                       {
    deleted     time,
    deprecated  time,
    obsolete    time,
    replacement string,
    state       'DEPRECATED', 'OBSOLETE' or 'DELETED',
  }
  description                      string
  guest_cpus                       integer
  id                               integer
  is_shared_cpu                    boolean
  maximum_persistent_disks         integer
  maximum_persistent_disks_size_gb integer
  memory_mb                        integer
  name                             string
  zone                             reference to gcompute_zone
  project                          string
  credential                       reference to gauth_credential
end
```

#### Actions

* `create` -
  Converges the `gcompute_machine_type` resource into the final
  state described within the block. If the resource does not exist, Chef will
  attempt to create it.
* `delete` -
  Ensures the `gcompute_machine_type` resource is not present.
  If the resource already exists Chef will attempt to delete it.

#### Properties

* `creation_timestamp` -
  Output only. Creation timestamp in RFC3339 text format.

* `deprecated` -
  Output only. The deprecation status associated with this machine type.

* `deprecated/deleted`
  Output only. An optional RFC3339 timestamp on or after which the state of
  this
  resource is intended to change to DELETED. This is only
  informational and the status will not change unless the client
  explicitly changes it.

* `deprecated/deprecated`
  Output only. An optional RFC3339 timestamp on or after which the state of
  this
  resource is intended to change to DEPRECATED. This is only
  informational and the status will not change unless the client
  explicitly changes it.

* `deprecated/obsolete`
  Output only. An optional RFC3339 timestamp on or after which the state of
  this
  resource is intended to change to OBSOLETE. This is only
  informational and the status will not change unless the client
  explicitly changes it.

* `deprecated/replacement`
  Output only. The URL of the suggested replacement for a deprecated resource.
  The suggested replacement resource must be the same kind of
  resource as the deprecated resource.

* `deprecated/state`
  Output only. The deprecation state of this resource. This can be DEPRECATED,
  OBSOLETE, or DELETED. Operations which create a new resource
  using a DEPRECATED resource will return successfully, but with a
  warning indicating the deprecated resource and recommending its
  replacement. Operations which use OBSOLETE or DELETED resources
  will be rejected and result in an error.

* `description` -
  Output only. An optional textual description of the resource.

* `guest_cpus` -
  Output only. The number of virtual CPUs that are available to the instance.

* `id` -
  Output only. The unique identifier for the resource.

* `is_shared_cpu` -
  Output only. Whether this machine type has a shared CPU. See Shared-core
  machine
  types for more information.

* `maximum_persistent_disks` -
  Output only. Maximum persistent disks allowed.

* `maximum_persistent_disks_size_gb` -
  Output only. Maximum total persistent disks size (GB) allowed.

* `memory_mb` -
  Output only. The amount of physical memory available to the instance,
  defined in
  MB.

* `name` -
  Name of the resource.

* `zone` -
  Required. A reference to Zone resource

#### Label
Set the `mt_label` property when attempting to set primary key
of this object. The primary key will always be referred to by the initials of
the resource followed by "_label"

### gcompute_network
Represents a Network resource.

Your Cloud Platform Console project can contain multiple networks, and
each network can have multiple instances attached to it. A network allows
you to define a gateway IP and the network range for the instances
attached to that network. Every project is provided with a default network
with preset configurations and firewall rules. You can choose to customize
the default network by adding or removing rules, or you can create new
networks in that project. Generally, most users only need one network,
although you can have up to five networks per project by default.

A network belongs to only one project, and each instance can only belong
to one network. All Compute Engine networks use the IPv4 protocol. Compute
Engine currently does not support IPv6. However, Google is a major
advocate of IPv6 and it is an important future direction.


#### Example

```ruby
gcompute_network 'mynetwork' do
  action :create
  auto_create_subnetworks true
  project 'google.com:graphite-playground'
  credential 'mycred'
end

```

#### Reference

```ruby
gcompute_network 'id-for-resource' do
  auto_create_subnetworks boolean
  creation_timestamp      time
  description             string
  gateway_ipv4            string
  id                      integer
  ipv4_range              string
  name                    string
  subnetworks             [
    string,
    ...
  ]
  project                 string
  credential              reference to gauth_credential
end
```

#### Actions

* `create` -
  Converges the `gcompute_network` resource into the final
  state described within the block. If the resource does not exist, Chef will
  attempt to create it.
* `delete` -
  Ensures the `gcompute_network` resource is not present.
  If the resource already exists Chef will attempt to delete it.

#### Properties

* `description` -
  An optional description of this resource. Provide this property when
  you create the resource.

* `gateway_ipv4` -
  A gateway address for default routing to other networks. This value is
  read only and is selected by the Google Compute Engine, typically as
  the first usable address in the IPv4Range.

* `id` -
  Output only. The unique identifier for the resource.

* `ipv4_range` -
  The range of internal addresses that are legal on this network. This
  range is a CIDR specification, for example: 192.168.0.0/16. Provided
  by the client when the network is created.

* `name` -
  Name of the resource. Provided by the client when the resource is
  created. The name must be 1-63 characters long, and comply with
  RFC1035. Specifically, the name must be 1-63 characters long and match
  the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means the
  first character must be a lowercase letter, and all following
  characters must be a dash, lowercase letter, or digit, except the last
  character, which cannot be a dash.

* `subnetworks` -
  Output only. Server-defined fully-qualified URLs for all subnetworks in
  this
  network.

* `auto_create_subnetworks` -
  When set to true, the network is created in "auto subnet mode". When
  set to false, the network is in "custom subnet mode".
  In "auto subnet mode", a newly created network is assigned the default
  CIDR of 10.128.0.0/9 and it automatically creates one subnetwork per
  region.

* `creation_timestamp` -
  Output only. Creation timestamp in RFC3339 text format.

#### Label
Set the `n_label` property when attempting to set primary key
of this object. The primary key will always be referred to by the initials of
the resource followed by "_label"

### gcompute_region
Represents a Region resource. A region is a specific geographical
location where you can run your resources. Each region has one or more
zones


#### Example

```ruby
gcompute_region 'us-west1' do
  action :create
  project 'google.com:graphite-playground'
  credential 'mycred'
end

```

#### Reference

```ruby
gcompute_region 'id-for-resource' do
  creation_timestamp     time
  deprecated_deleted     time
  deprecated_deprecated  time
  deprecated_obsolete    time
  deprecated_replacement string
  deprecated_state       'DEPRECATED', 'OBSOLETE' or 'DELETED'
  description            string
  id                     integer
  name                   string
  zones                  [
    string,
    ...
  ]
  project                string
  credential             reference to gauth_credential
end
```

#### Actions

* `create` -
  Converges the `gcompute_region` resource into the final
  state described within the block. If the resource does not exist, Chef will
  attempt to create it.
* `delete` -
  Ensures the `gcompute_region` resource is not present.
  If the resource already exists Chef will attempt to delete it.

#### Properties

* `creation_timestamp` -
  Output only. Creation timestamp in RFC3339 text format.

* `deprecated_deleted` -
  Output only. An optional RFC3339 timestamp on or after which the
  deprecation state
  of this resource will be changed to DELETED.

* `deprecated_deprecated` -
  Output only. An optional RFC3339 timestamp on or after which the
  deprecation state
  of this resource will be changed to DEPRECATED.

* `deprecated_obsolete` -
  Output only. An optional RFC3339 timestamp on or after which the
  deprecation state
  of this resource will be changed to OBSOLETE.

* `deprecated_replacement` -
  Output only. The URL of the suggested replacement for a deprecated
  resource. The
  suggested replacement resource must be the same kind of resource as
  the deprecated resource.

* `deprecated_state` -
  Output only. The deprecation state of this resource. This can be
  DEPRECATED,
  OBSOLETE, or DELETED. Operations which create a new resource using a
  DEPRECATED resource will return successfully, but with a warning
  indicating the deprecated resource and recommending its replacement.
  Operations which use OBSOLETE or DELETED resources will be rejected
  and result in an error.

* `description` -
  Output only. An optional description of this resource.

* `id` -
  Output only. The unique identifier for the resource.

* `name` -
  Name of the resource.

* `zones` -
  Output only. List of zones within the region

#### Label
Set the `r_label` property when attempting to set primary key
of this object. The primary key will always be referred to by the initials of
the resource followed by "_label"

### gcompute_route
Represents a Route resource.

A route is a rule that specifies how certain packets should be handled by
the virtual network. Routes are associated with virtual machines by tag,
and the set of routes for a particular virtual machine is called its
routing table. For each packet leaving a virtual machine, the system
searches that virtual machine's routing table for a single best matching
route.

Routes match packets by destination IP address, preferring smaller or more
specific ranges over larger ones. If there is a tie, the system selects
the route with the smallest priority value. If there is still a tie, it
uses the layer three and four packet headers to select just one of the
remaining matching routes. The packet is then forwarded as specified by
the next_hop field of the winning route -- either to another virtual
machine destination, a virtual machine gateway or a Compute
Engine-operated gateway. Packets that do not match any route in the
sending virtual machine's routing table will be dropped.

A Routes resources must have exactly one specification of either
nextHopGateway, nextHopInstance, nextHopIp, or nextHopVpnTunnel.


#### Example

```ruby
# Subnetwork requires a network and a region, so define them in your recipe:
#   - gcompute_network 'my-network' do ... end
#   - gcompute_region 'some-region' do ... end
gcompute_route 'corp-route' do
  action :create
  dest_range '192.168.6.0/24'
  next_hop_gateway 'global/gateways/default-internet-gateway'
  tags %w[backends databases] # %w[] best for single words. use ['.'] w/ spaces
  network 'my-network'
  project 'google.com:graphite-playground'
  credential 'mycred'
end

```

#### Reference

```ruby
gcompute_route 'id-for-resource' do
  dest_range          string
  name                string
  network             reference to gcompute_network
  next_hop_gateway    string
  next_hop_instance   string
  next_hop_ip         string
  next_hop_vpn_tunnel string
  priority            integer
  tags                [
    string,
    ...
  ]
  project             string
  credential          reference to gauth_credential
end
```

#### Actions

* `create` -
  Converges the `gcompute_route` resource into the final
  state described within the block. If the resource does not exist, Chef will
  attempt to create it.
* `delete` -
  Ensures the `gcompute_route` resource is not present.
  If the resource already exists Chef will attempt to delete it.

#### Properties

* `dest_range` -
  The destination range of outgoing packets that this route applies to.
  Only IPv4 is supported.

* `name` -
  Name of the resource. Provided by the client when the resource is
  created. The name must be 1-63 characters long, and comply with
  RFC1035.  Specifically, the name must be 1-63 characters long and
  match the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means
  the first character must be a lowercase letter, and all following
  characters must be a dash, lowercase letter, or digit, except the
  last character, which cannot be a dash.

* `network` -
  A reference to Network resource

* `priority` -
  The priority of this route. Priority is used to break ties in cases
  where there is more than one matching route of equal prefix length.
  In the case of two routes with equal prefix length, the one with the
  lowest-numbered priority value wins.
  Default value is 1000. Valid range is 0 through 65535.

* `tags` -
  A list of instance tags to which this route applies.

* `next_hop_gateway` -
  URL to a gateway that should handle matching packets.
  Currently, you can only specify the internet gateway, using a full or
  partial valid URL:
  * https://www.googleapis.com/compute/v1/projects/project/
  global/gateways/default-internet-gateway
  * projects/project/global/gateways/default-internet-gateway
  * global/gateways/default-internet-gateway

* `next_hop_instance` -
  URL to an instance that should handle matching packets.
  You can specify this as a full or partial URL. For example:
  * https://www.googleapis.com/compute/v1/projects/project/zones/zone/
  instances/instance
  * projects/project/zones/zone/instances/instance
  * zones/zone/instances/instance

* `next_hop_ip` -
  Network IP address of an instance that should handle matching packets.

* `next_hop_vpn_tunnel` -
  URL to a VpnTunnel that should handle matching packets.

#### Label
Set the `r_label` property when attempting to set primary key
of this object. The primary key will always be referred to by the initials of
the resource followed by "_label"

### gcompute_ssl_certificate
An SslCertificate resource. This resource provides a mechanism to upload
an SSL key and certificate to the load balancer to serve secure
connections from the user.


#### Example

```ruby
# *******
# WARNING: This recipe is for example purposes only. It is *not* advisable to
# have the key embedded like this because if you check this file into source
# control you are publishing the private key to whomever can access the source
# code.
# *******

gcompute_ssl_certificate 'my-site-ssl-cert' do
  action :create
  certificate(
    <<-CERTIFICATE
       -----BEGIN CERTIFICATE-----
       MIICqjCCAk+gAwIBAgIJAIuJ+0352Kq4MAoGCCqGSM49BAMCMIGwMQswCQYDVQQG
       EwJVUzETMBEGA1UECAwKV2FzaGluZ3RvbjERMA8GA1UEBwwIS2lya2xhbmQxFTAT
       BgNVBAoMDEdvb2dsZSwgSW5jLjEeMBwGA1UECwwVR29vZ2xlIENsb3VkIFBsYXRm
       b3JtMR8wHQYDVQQDDBZ3d3cubXktc2VjdXJlLXNpdGUuY29tMSEwHwYJKoZIhvcN
       AQkBFhJuZWxzb25hQGdvb2dsZS5jb20wHhcNMTcwNjI4MDQ1NjI2WhcNMjcwNjI2
       MDQ1NjI2WjCBsDELMAkGA1UEBhMCVVMxEzARBgNVBAgMCldhc2hpbmd0b24xETAP
       BgNVBAcMCEtpcmtsYW5kMRUwEwYDVQQKDAxHb29nbGUsIEluYy4xHjAcBgNVBAsM
       FUdvb2dsZSBDbG91ZCBQbGF0Zm9ybTEfMB0GA1UEAwwWd3d3Lm15LXNlY3VyZS1z
       aXRlLmNvbTEhMB8GCSqGSIb3DQEJARYSbmVsc29uYUBnb29nbGUuY29tMFkwEwYH
       KoZIzj0CAQYIKoZIzj0DAQcDQgAEHGzpcRJ4XzfBJCCPMQeXQpTXwlblimODQCuQ
       4mzkzTv0dXyB750fOGN02HtkpBOZzzvUARTR10JQoSe2/5PIwaNQME4wHQYDVR0O
       BBYEFKIQC3A2SDpxcdfn0YLKineDNq/BMB8GA1UdIwQYMBaAFKIQC3A2SDpxcdfn
       0YLKineDNq/BMAwGA1UdEwQFMAMBAf8wCgYIKoZIzj0EAwIDSQAwRgIhALs4vy+O
       M3jcqgA4fSW/oKw6UJxp+M6a+nGMX+UJR3YgAiEAvvl39QRVAiv84hdoCuyON0lJ
       zqGNhIPGq2ULqXKK8BY=
       -----END CERTIFICATE-----
       CERTIFICATE
       .split("\n").map(&:strip).join("\n")
  )
  private_key(
    <<-PRIVATE_KEY
       -----BEGIN EC PRIVATE KEY-----
       MHcCAQEEIObtRo8tkUqoMjeHhsOh2ouPpXCgBcP+EDxZCB/tws15oAoGCCqGSM49
       AwEHoUQDQgAEHGzpcRJ4XzfBJCCPMQeXQpTXwlblimODQCuQ4mzkzTv0dXyB750f
       OGN02HtkpBOZzzvUARTR10JQoSe2/5PIwQ==
       -----END EC PRIVATE KEY-----
       PRIVATE_KEY
       .split("\n").map(&:strip).join("\n")
  )
  project 'google.com:graphite-playground'
  credential 'mycred'
end

```

#### Reference

```ruby
gcompute_ssl_certificate 'id-for-resource' do
  certificate        string
  creation_timestamp time
  description        string
  id                 integer
  name               string
  private_key        string
  project            string
  credential         reference to gauth_credential
end
```

#### Actions

* `create` -
  Converges the `gcompute_ssl_certificate` resource into the final
  state described within the block. If the resource does not exist, Chef will
  attempt to create it.
* `delete` -
  Ensures the `gcompute_ssl_certificate` resource is not present.
  If the resource already exists Chef will attempt to delete it.

#### Properties

* `certificate` -
  The certificate in PEM format.
  The certificate chain must be no greater than 5 certs long.
  The chain must include at least one intermediate cert.

* `creation_timestamp` -
  Output only. Creation timestamp in RFC3339 text format.

* `description` -
  An optional description of this resource.

* `id` -
  Output only. The unique identifier for the resource.

* `name` -
  Name of the resource. Provided by the client when the resource is
  created. The name must be 1-63 characters long, and comply with
  RFC1035. Specifically, the name must be 1-63 characters long and match
  the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which means the
  first character must be a lowercase letter, and all following
  characters must be a dash, lowercase letter, or digit, except the last
  character, which cannot be a dash.

* `private_key` -
  The private key in PEM format.

#### Label
Set the `sc_label` property when attempting to set primary key
of this object. The primary key will always be referred to by the initials of
the resource followed by "_label"

### gcompute_subnetwork
A VPC network is a virtual version of the traditional physical networks
that exist within and between physical data centers. A VPC network
provides connectivity for your Compute Engine virtual machine (VM)
instances, Container Engine containers, App Engine Flex services, and
other network-related resources.

Each GCP project contains one or more VPC networks. Each VPC network is a
global entity spanning all GCP regions. This global VPC network allows VM
instances and other resources to communicate with each other via internal,
private IP addresses.

Each VPC network is subdivided into subnets, and each subnet is contained
within a single region. You can have more than one subnet in a region for
a given VPC network. Each subnet has a contiguous private RFC1918 IP
space. You create instances, containers, and the like in these subnets.
When you create an instance, you must create it in a subnet, and the
instance draws its internal IP address from that subnet.

Virtual machine (VM) instances in a VPC network can communicate with
instances in all other subnets of the same VPC network, regardless of
region, using their RFC1918 private IP addresses. You can isolate portions
of the network, even entire subnets, using firewall rules.


#### Example

```ruby
# Subnetwork requires a network and a region, so define them in your recipe:
#   - gcompute_network 'my-network' do ... end
#   - gcompute_region 'some-region' do ... end
gcompute_subnetwork 'servers' do
  action :create
  ip_cidr_range '172.16.0.0/16'
  network 'mynetwork-subnetwork'
  region 'some-region'
  project 'google.com:graphite-playground'
  credential 'mycred'
end

```

#### Reference

```ruby
gcompute_subnetwork 'id-for-resource' do
  creation_timestamp       time
  description              string
  gateway_address          string
  id                       integer
  ip_cidr_range            string
  name                     string
  network                  reference to gcompute_network
  private_ip_google_access boolean
  region                   reference to gcompute_region
  project                  string
  credential               reference to gauth_credential
end
```

#### Actions

* `create` -
  Converges the `gcompute_subnetwork` resource into the final
  state described within the block. If the resource does not exist, Chef will
  attempt to create it.
* `delete` -
  Ensures the `gcompute_subnetwork` resource is not present.
  If the resource already exists Chef will attempt to delete it.

#### Properties

* `creation_timestamp` -
  Output only. Creation timestamp in RFC3339 text format.

* `description` -
  An optional description of this resource. Provide this property when
  you create the resource. This field can be set only at resource
  creation time.

* `gateway_address` -
  The gateway address for default routes to reach destination addresses
  outside this subnetwork. This field can be set only at resource
  creation time.

* `id` -
  Output only. The unique identifier for the resource.

* `ip_cidr_range` -
  The range of internal addresses that are owned by this subnetwork.
  Provide this property when you create the subnetwork. For example,
  10.0.0.0/8 or 192.168.0.0/16. Ranges must be unique and
  non-overlapping within a network. Only IPv4 is supported.

* `name` -
  The name of the resource, provided by the client when initially
  creating the resource. The name must be 1-63 characters long, and
  comply with RFC1035. Specifically, the name must be 1-63 characters
  long and match the regular expression [a-z]([-a-z0-9]*[a-z0-9])? which
  means the first character must be a lowercase letter, and all
  following characters must be a dash, lowercase letter, or digit,
  except the last character, which cannot be a dash.

* `network` -
  A reference to Network resource

* `private_ip_google_access` -
  Whether the VMs in this subnet can access Google services without
  assigned external IP addresses.

* `region` -
  Required. A reference to Region resource

#### Label
Set the `s_label` property when attempting to set primary key
of this object. The primary key will always be referred to by the initials of
the resource followed by "_label"

### gcompute_zone
Represents a Zone resource.

#### Example

```ruby
gcompute_zone 'us-west1-a' do
  action :create
  project 'google.com:graphite-playground'
  credential 'mycred'
end

```

#### Reference

```ruby
gcompute_zone 'id-for-resource' do
  creation_timestamp time
  deprecated         {
    deleted     time,
    deprecated  time,
    obsolete    time,
    replacement string,
    state       'DEPRECATED', 'OBSOLETE' or 'DELETED',
  }
  description        string
  id                 integer
  name               string
  region             reference to gcompute_region
  status             'UP' or 'DOWN'
  project            string
  credential         reference to gauth_credential
end
```

#### Actions

* `create` -
  Converges the `gcompute_zone` resource into the final
  state described within the block. If the resource does not exist, Chef will
  attempt to create it.
* `delete` -
  Ensures the `gcompute_zone` resource is not present.
  If the resource already exists Chef will attempt to delete it.

#### Properties

* `creation_timestamp` -
  Output only. Creation timestamp in RFC3339 text format.

* `deprecated` -
  Output only. The deprecation status associated with this machine type.

* `deprecated/deleted`
  Output only. An optional RFC3339 timestamp on or after which the state of
  this
  resource is intended to change to DELETED. This is only
  informational and the status will not change unless the client
  explicitly changes it.

* `deprecated/deprecated`
  Output only. An optional RFC3339 timestamp on or after which the state of
  this
  resource is intended to change to DEPRECATED. This is only
  informational and the status will not change unless the client
  explicitly changes it.

* `deprecated/obsolete`
  Output only. An optional RFC3339 timestamp on or after which the state of
  this
  resource is intended to change to OBSOLETE. This is only
  informational and the status will not change unless the client
  explicitly changes it.

* `deprecated/replacement`
  Output only. The URL of the suggested replacement for a deprecated resource.
  The suggested replacement resource must be the same kind of
  resource as the deprecated resource.

* `deprecated/state`
  Output only. The deprecation state of this resource. This can be DEPRECATED,
  OBSOLETE, or DELETED. Operations which create a new resource
  using a DEPRECATED resource will return successfully, but with a
  warning indicating the deprecated resource and recommending its
  replacement. Operations which use OBSOLETE or DELETED resources
  will be rejected and result in an error.

* `description` -
  Output only. An optional textual description of the resource.

* `id` -
  Output only. The unique identifier for the resource.

* `name` -
  Name of the resource.

* `region` -
  Output only. A reference to Region resource

* `status` -
  Output only. The status of the zone.

#### Label
Set the `z_label` property when attempting to set primary key
of this object. The primary key will always be referred to by the initials of
the resource followed by "_label"

## Functions

### About Functions
In order to use these functions inside of a Chef recipe, you'll need to import
the function first. Before calling a function, add the following line:

```ruby
::Chef::Resource.send(:include, Google::Functions)
```

### `gcompute_address_ip`

  Retrieves the IP address associated with a gcompute_address static IP.

#### Arguments

  - `name`:
    the name of the static IP

  - `region`:
    the name of the region that hosts the address

  - `project`:
    the name of the project that hosts the address

  - `cred`:
    the credential to use to authorize the information request

#### Examples

```ruby
gcompute_address_ip('my-server', 'us-central1', 'myproject', fn_auth)
```

### `gcompute_image_family`

  Builds the family resource identifier required to uniquely identify the
  family, e.g. to create virtual machines based on it. You can use this
  function as `source_image` of a `gcompute_instance` resource.

#### Arguments

  - `family_name`:
    the name of the family, e.g. ubuntu-1604-lts

  - `project_name`:
    the name of the project that hosts the family,
    e.g. ubuntu-os-cloud

#### Examples

```ruby
gcompute_image_family('ubuntu-1604-lts', 'ubuntu-os-cloud')
```

```ruby
gcompute_image_family('my-web-server', 'my-project')
```


[google-gauth]: https://supermarket.chef.io/cookbooks/google-gauth
