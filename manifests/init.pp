# == Class: awstools
#
# === Parameters:
#
# [*tenant*]
#   Tenant parameter is used to get certs from files dir.
#   Default: undef
#
# [*ec2_private_key*]
#   ec2_private_key.
#   Default: undef
#
# [*ec2_cert*]
#   ec2_cert.
#   Default: undef
#
# [*ec2_region*]
#   eu-west-1.
#   Default: eu-west-1
#
# [*ec2_url*]
#   AWS API endpoint.
#   Default: https://ec2.${ec2_region}.amazonaws.com
#
# [*ec2_home*]
#   ec2_home.
#   Default: /usr/local/ec2-api-tools
#
# [*aws_auto_scaling_home*]
#   aws_auto_scaling_home.
#   Default: /usr/local/ec2-as-tools
#
# [*aws_elb_home*]
#   aws_elb_home.
#   Default: /usr/local/ec2-elb-tools
#
# [*aws_cloudwatch_home*]
#   aws_cloudwatch_home.
#   Default: /usr/local/ec2-cw-tools
#
# [*aws_elasticcache_home*]
#   aws_elasticcache_home.
#   Default: /usr/local/ec2-ec-tools
#
# [*aws_calling_format*]
#   aws_calling_format.
#   Default: SUBDOMAIN
#
# [*jre_home*]
#   JRE_HOME.
#   Default: undef
#
# === Actions:
#
# Install and configure AWS Tools
#
# === Requires:
#
# https://github.com/icalvete/puppet-common
#
# Really only need:
#   - common::add_env define
#   - Any java package
#
# === Authors:
#
# Israel Calvete Talavera <icalvete@gmail.com>
#
# === Copyright:
#
# Copyright (C) 2012 Israel Calvete Talavera
#
class awstools (

  $tenant                = undef,
  $ec2_private_key       = undef,
  $ec2_cert              = undef,
  $ec2_region            = 'eu-west-1',
  $ec2_url               = 'https://ec2.eu-west-1.amazonaws.com',
  $ec2_home              = '/usr/local/ec2-api-tools',
  $aws_auto_scaling_home = '/usr/local/ec2-as-tools',
  $aws_elb_home          = '/usr/local/ec2-elb-tools',
  $aws_cloudwatch_home   = '/usr/local/ec2-cw-tools',
  $aws_elasticcache_home = '/usr/local/ec2-ec-tools',
  $aws_calling_format    = 'SUBDOMAIN',
  $jre_home              = '/usr/lib/jvm/java-7-openjdk-amd64/jre/'

) inherits awstools::params {

  if ! $tenant {
    fail('tenant is mandatory.')
  }

  if ! $ec2_private_key {
    fail('ec2_private_key is mandatory.')
  }

  if ! $ec2_cert {
    fail('ec2_cert is mandatory.')
  }

  if ! $jre_home {
    fail('jre_home is mandatory.')
  }

  anchor{'awstools::begin':
    before  => Class['awstools::preinstall']
  }

  class{'awstools::preinstall':
    require => Anchor['awstools::begin']
  }

  class{'awstools::install':
    require => Class['awstools::preinstall']
  }

  class{'awstools::config':
    require => Class['awstools::install']
  }

  anchor{'awstools::end':
    require => Class['awstools::config']
  }
}
