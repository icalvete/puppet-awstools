class awstools::config {

  file {"awstools::params::aws_cerficate_dir_${awstools::tenant}":
    ensure => directory,
    path   => $awstools::params::aws_cerficate_dir,
    owner  => 'root',
    group  => 'root',
    mode   => '0700',
    before => [File["load_aws_certificate_${awstools::tenant}"], File["load_aws_key_${awstools::tenant}"]]
  }

  file {"load_aws_certificate_${awstools::tenant}":
    ensure => present,
    path   => "${awstools::params::aws_cerficate_dir}/${awstools::ec2_cert}",
    source => "puppet:///modules/${awstools::tenant}/${awstools::ec2_cert}",
    owner  => 'root',
    group  => 'root',
    mode   => '0440',
  }

  file {"load_aws_key_${awstools::tenant}":
    ensure => present,
    path   => "${awstools::params::aws_cerficate_dir}/${awstools::ec2_private_key}",
    source => "puppet:///modules/${awstools::tenant}/${awstools::ec2_private_key}",
    owner  => 'root',
    group  => 'root',
    mode   => '0440',
  }

  common::add_env{'EC2_PRIVATE_KEY':
    key   => 'EC2_PRIVATE_KEY',
    value => "${awstools::params::aws_cerficate_dir}/${awstools::ec2_private_key}"
  }

  common::add_env{'EC2_CERT':
    key   => 'EC2_CERT',
    value => "${awstools::params::aws_cerficate_dir}/${awstools::ec2_cert}"
  }

  common::add_env{'EC2_REGION':
    key   => 'EC2_REGION',
    value => $awstools::ec2_region
  }

  common::add_env{'EC2_URL':
    key   => 'EC2_URL',
    value => $awstools::ec2_url
  }

  common::add_env{'EC2_HOME':
    key   => 'EC2_HOME',
    value => $awstools::ec2_home
  }

  common::add_env{'AWS_AUTO_SCALING_HOME':
    key   => 'AWS_AUTO_SCALING_HOME',
    value => $awstools::aws_auto_scaling_home
  }

  common::add_env{'AWS_ELB_HOME':
    key   => 'AWS_ELB_HOME',
    value => $awstools::aws_elb_home
  }

  common::add_env{'AWS_CLOUDWATCH_HOME':
    key   => 'AWS_CLOUDWATCH_HOME',
    value => $awstools::aws_cloudwatch_home
  }

  common::add_env{'AWS_ELASTICACHE_HOME':
    key   => 'AWS_ELASTICACHE_HOME',
    value => $awstools::aws_elasticcache_home
  }

  common::add_env{'AWS_CALLING_FORMAT':
    key   => 'AWS_CALLING_FORMAT',
    value => $awstools::aws_calling_format
  }

  common::add_env{'JAVA_HOME':
    key   => 'JAVA_HOME',
    value => $awstools::jre_home
  }
}
