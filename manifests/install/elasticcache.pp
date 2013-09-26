class awstools::install::elasticcache {

  $elasticcache_package_name = 'ec2-ec-tool'

  exec {'download_elasticcache_awstool':
    cwd     => '/tmp',
    command => "/usr/bin/curl -o ${elasticcache_package_name}.zip  \$CURL_OPTS --max-time 60 ${awstools::params::elasticcache_package_url}",
    unless  => "/bin/readlink -e /usr/local/${elasticcache_package_name}"
  }

  exec {'unzip_elasticcache_awstool':
    cwd     => '/usr/local',
    command => "/usr/bin/unzip /tmp/${elasticcache_package_name}.zip",
    require => Exec['download_elasticcache_awstool'],
    unless  => "/bin/readlink -e /usr/local/${elasticcache_package_name}"
  }

  exec {'format_elasticcache_awstool':
    cwd     => '/usr/local',
    command => "/bin/mv AmazonElastiCacheCli* `echo AmazonElastiCacheCli*| tr '[:upper:]' '[:lower:]'`",
    require => Exec['unzip_elasticcache_awstool'],
    unless  => "/bin/readlink -e /usr/local/${elasticcache_package_name}"
  }

  exec {'link_elasticcache_awstool':
    cwd     => '/usr/local',
    command => "/bin/ln -svf `find . -type d -name amazonelasticachecl*` ${elasticcache_package_name}",
    require => Exec['format_elasticcache_awstool'],
    unless  => "/bin/readlink -e /usr/local/${elasticcache_package_name}"
  }

  exec {'set_permision_elasticcache_awstool':
    cwd     => '/usr/local',
    command => "/bin/chmod -R go-rwsx ${elasticcache_package_name}* && rm -rvf /tmp/${elasticcache_package_name}*",
    require => Exec['link_elasticcache_awstool'],
  }

  exec {'link_permision_elasticcache_awstool_path':
    cwd     => '/usr/bin',
    command => "/bin/ln -sf /usr/local/${elasticcache_package_name}/bin/* /usr/bin/",
    require => Exec['set_permision_elasticcache_awstool'],
    unless  => '/bin/readlink -e elasticache-version'
  }
}
