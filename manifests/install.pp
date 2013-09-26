class awstools::install {

  anchor{'awstools::install::begin':}

  class{'awstools::install::ami':
    require => Anchor['awstools::install::begin'],
    before  => Anchor['awstools::install::end']
  }

  class{'awstools::install::api':
    require => Anchor['awstools::install::begin'],
    before  => Anchor['awstools::install::end']
  }

  class{'awstools::install::elb':
    require => Anchor['awstools::install::begin'],
    before  => Anchor['awstools::install::end']
  }

  class{'awstools::install::cloudwatch':
    require => Anchor['awstools::install::begin'],
    before  => Anchor['awstools::install::end']
  }

  class{'awstools::install::autoscaling':
    require => Anchor['awstools::install::begin'],
    before  => Anchor['awstools::install::end']
  }

  class{'awstools::install::elasticcache':
    require => Anchor['awstools::install::begin'],
    before  => Anchor['awstools::install::end']
  }

  anchor{'awstools::install::end':}
}
