class awstools::install::ami {

  $ami_package_name = 'ec2-ami-tools'

  exec {'download_ami_awstool':
    cwd     => '/tmp',
    command => "/usr/bin/curl -o ${ami_package_name}.zip  \$CURL_OPTS --max-time 60 ${awstools::params::ami_package_url}",
    unless  => "/bin/readlink -e /usr/local/${ami_package_name}"
  }

  exec {'unzip_ami_awstool':
    cwd     => '/usr/local',
    command => "/usr/bin/unzip /tmp/${ami_package_name}.zip",
    require => Exec['download_ami_awstool'],
    unless  => "/bin/readlink -e /usr/local/${ami_package_name}"
  }

  exec {'link_ami_awstool':
    cwd     => '/usr/local',
    command => "/bin/ln -svf `find . -type d -name ${ami_package_name}*` ${ami_package_name}",
    require => Exec['unzip_ami_awstool'],
    unless  => "/bin/readlink -e /usr/local/${ami_package_name}"
  }

  exec {'set_permision_ami_awstool':
    cwd     => '/usr/local',
    command => "/bin/chmod -R go-rwsx ${ami_package_name}* && rm -rvf /tmp/${ami_package_name}*",
    require => Exec['link_ami_awstool'],
  }

  exec {'link_permision_ami_awstool_path':
    cwd     => '/usr/bin',
    command => "/bin/ln -sf /usr/local/${ami_package_name}/bin/* /usr/bin/",
    require => Exec['set_permision_ami_awstool'],
    unless  => '/bin/readlink -e ec2-ami-tools-version'
  }
}
