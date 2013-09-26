class awstools::install::cloudwatch {

  $cloudwatch_package_name = 'ec2-cw-tools'

  exec {'download_cloudwatch_awstool':
    cwd     => '/tmp',
    command => "/usr/bin/curl -o ${cloudwatch_package_name}.zip  \$CURL_OPTS --max-time 60 ${awstools::params::cloudwatch_package_url}",
    unless  => "/bin/readlink -e /usr/local/${cloudwatch_package_name}"
  }

  exec {'unzip_cloudwatch_awstool':
    cwd     => '/usr/local',
    command => "/usr/bin/unzip /tmp/${cloudwatch_package_name}.zip",
    require => Exec['download_cloudwatch_awstool'],
    unless  => "/bin/readlink -e /usr/local/${cloudwatch_package_name}"
  }

  exec {'format_cloudwatch_awstool':
    cwd     => '/usr/local',
    command => "/bin/mv CloudWatch* `echo CloudWatch*  |tr '[:upper:]' '[:lower:]'`",
    require => Exec['unzip_cloudwatch_awstool'],
    unless  => "/bin/readlink -e /usr/local/${cloudwatch_package_name}"
  }

  exec {'link_cloudwatch_awstool':
    cwd     => '/usr/local',
    command => "/bin/ln -svf `find . -type d -name  cloudwatch*` ${cloudwatch_package_name}",
    require => Exec['format_cloudwatch_awstool'],
    unless  => "/bin/readlink -e /usr/local/${cloudwatch_package_name}"
  }

  exec {'set_permision_cloudwatch_awstool':
    cwd     => '/usr/local',
    command => "/bin/chmod -R go-rwsx ${cloudwatch_package_name}* && rm -rvf /tmp/${cloudwatch_package_name}*",
    require => Exec['link_cloudwatch_awstool'],
  }

  exec {'link_permision_cloudwatch_awstool_path':
    cwd     => '/usr/bin',
    command => "/bin/ln -sf /usr/local/${cloudwatch_package_name}/bin/* /usr/bin/",
    require => Exec['set_permision_cloudwatch_awstool'],
    unless  => '/bin/readlink -e mon-version'
  }
}
