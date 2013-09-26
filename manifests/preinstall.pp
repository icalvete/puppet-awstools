class awstools::preinstall {

  realize Package['openjdk-7-jre']
  realize Package['unzip']

  common::add_env{'CURL_OPTS':
    key   => 'CURL_OPTS',
    value => '-silent --retry 1 --retry-delay 1 --retry-max-time 1'
  }
}
