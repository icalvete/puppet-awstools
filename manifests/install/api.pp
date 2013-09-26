class awstools::install::api {

  $api_package_name = 'ec2-api-tools'

  exec {'download_api_awstool':
    cwd     => '/tmp',
    command => "/usr/bin/curl -o ${api_package_name}.zip  \$CURL_OPTS --max-time 60 ${awstools::params::api_package_url}",
    unless  => "/bin/readlink -e /usr/local/${api_package_name}"
  }

  exec {'unzip_api_awstool':
    cwd     => '/usr/local',
    command => "/usr/bin/unzip /tmp/${api_package_name}.zip",
    require => Exec['download_api_awstool'],
    unless  => "/bin/readlink -e /usr/local/${api_package_name}"
  }

  exec {'link_api_awstool':
    cwd     => '/usr/local',
    command => "/bin/ln -svf `find . -type d -name ${api_package_name}*` ${api_package_name}",
    require => Exec['unzip_api_awstool'],
    unless  => "/bin/readlink -e /usr/local/${api_package_name}"
  }

  exec {'set_permision_api_awstool':
    cwd     => '/usr/local',
    command => "/bin/chmod -R go-rwsx ${api_package_name}* && rm -rvf /tmp/${api_package_name}*",
    require => Exec['link_api_awstool'],
  }

  exec {'link_permision_api_awstool_path':
    cwd     => '/usr/bin',
    command => "/bin/ln -sf /usr/local/${api_package_name}/bin/* /usr/bin/",
    require => Exec['set_permision_api_awstool'],
    unless  => '/bin/readlink -e ec2-version'
  }
}
