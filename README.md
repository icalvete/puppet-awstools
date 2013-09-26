#puppet-awstools

Puppet manifest to install aws [AWS (Amazon Web Services)](http://aws.amazon.com/) tools

[![Build Status](https://secure.travis-ci.org/icalvete/puppet-awstools.png)](http://travis-ci.org/icalvete/puppet-awstools)

##Actions:

Install and configure AWS (Amazon Web Services) tools

##Requires:

* [hiera](http://docs.puppetlabs.com/hiera/1/index.html)
* https://github.com/icalvete/puppet-common but really only need:
  + common::add_env define
  + Any java package

##Example:

**Password, keys, certificates... are dummy**

    node fourandgo {
      $tenant = 'fourandgo'
    
      class {'common': stage => 'pre'}
      
      common::add_env{'TENANT':
        key     => 'TENANT',
        value   => $tenant,
        require => Class['common']
      }
    }
     
    node 'fag01.smartpurposes.com' inherits fourandgo {
      $environment = 'PRO'
      
      common::add_env{'environment':
        key     => 'environment',
        value   => $environment,
        require => Class['common']
      }
    
      class {'awstools':
        tenant          => $tenant,
        ec2_private_key => 'pk-VGOWNGW3ZI7GQCOKBH42WKDQ7OCK2PVA.pem',
        ec2_cert        => 'cert-VGOWNGW3ZI7GQCOKBH42WKDQ7OCK2PVA.pem',
      }
    }

Keys will be in $config_dir/$tenant/files. **This module should not be public.**

##Authors:

Israel Calvete Talavera <icalvete@gmail.com>
