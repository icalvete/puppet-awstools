class awstools::install::autoscaling {

  $autoscaling_package_name = 'ec2-as-tools'

  exec {'download_autoscaling_awstool':
    cwd     => '/tmp',
    command => "/usr/bin/curl -o ${autoscaling_package_name}.zip  \$CURL_OPTS --max-time 60 ${awstools::params::autoscaling_package_url}",
    unless  => "/bin/readlink -e /usr/local/${autoscaling_package_name}"
  }

  exec {'unzip_autoscaling_awstool':
    cwd     => '/usr/local',
    command => "/usr/bin/unzip /tmp/${autoscaling_package_name}.zip",
    require => Exec['download_autoscaling_awstool'],
    unless  => "/bin/readlink -e /usr/local/${autoscaling_package_name}"
  }

  exec {'format_autoscaling_awstool':
    cwd     => '/usr/local',
    command => "/bin/mv AutoScaling* `echo AutoScaling*  |tr '[:upper:]' '[:lower:]'`",
    require => Exec['unzip_autoscaling_awstool'],
    unless  => "/bin/readlink -e /usr/local/${autoscaling_package_name}"
  }

  exec {'link_autoscaling_awstool':
    cwd     => '/usr/local',
    command => "/bin/ln -svf `find . -type d -name autoscaling*` ${autoscaling_package_name}",
    require => Exec['format_autoscaling_awstool'],
    unless  => "/bin/readlink -e /usr/local/${autoscaling_package_name}"
  }

  exec {'set_permision_autoscaling_awstool':
    cwd     => '/usr/local',
    command => "/bin/chmod -R go-rwsx ${autoscaling_package_name}* && rm -rvf /tmp/${autoscaling_package_name}*",
    require => Exec['link_autoscaling_awstool'],
  }

  exec {'link_permision_autoscaling_awstool_path':
    cwd     => '/usr/bin',
    command => "/bin/ln -sf /usr/local/${autoscaling_package_name}/bin/* /usr/bin/",
    require => Exec['set_permision_autoscaling_awstool'],
    unless  => '/bin/readlink -e as-version'
  }
}
