class awstools::install::elb {

  $elb_package_name = 'ec2-elb-tool'

  exec {'download_elb_awstool':
    cwd     => '/tmp',
    command => "/usr/bin/curl -o ${elb_package_name}.zip  \$CURL_OPTS --max-time 60 ${awstools::params::elb_package_url}",
    unless  => "/bin/readlink -e /usr/local/${elb_package_name}"
  }

  exec {'unzip_elb_awstool':
    cwd     => '/usr/local',
    command => "/usr/bin/unzip /tmp/${elb_package_name}.zip",
    require => Exec['download_elb_awstool'],
    unless  => "/bin/readlink -e /usr/local/${elb_package_name}"
  }

  exec {'format_elb_awstool':
    cwd     => '/usr/local',
    command => "/bin/mv ElasticLoadBalancing* `echo ElasticLoadBalancing*  |tr '[:upper:]' '[:lower:]'`",
    require => Exec['unzip_elb_awstool'],
    unless  => "/bin/readlink -e /usr/local/${elb_package_name}"
  }

  exec {'link_elb_awstool':
    cwd     => '/usr/local',
    command => "/bin/ln -svf `find . -type d -name elasticloadbalancing*` ${elb_package_name}",
    require => Exec['format_elb_awstool'],
    unless  => "/bin/readlink -e /usr/local/${elb_package_name}"
  }

  exec {'set_permision_elb_awstool':
    cwd     => '/usr/local',
    command => "/bin/chmod -R go-rwsx ${elb_package_name}* && rm -rvf /tmp/${elb_package_name}*",
    require => Exec['link_elb_awstool'],
  }

  exec {'link_permision_elb_awstool_path':
    cwd     => '/usr/bin',
    command => "/bin/ln -sf /usr/local/${elb_package_name}/bin/* /usr/bin/",
    require => Exec['set_permision_elb_awstool'],
    unless  => '/bin/readlink -e elb-version'
  }
}
