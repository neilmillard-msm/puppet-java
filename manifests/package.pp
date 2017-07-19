class java::package{

  package{ 'unzip':
    ensure => installed,
  }

  package{ 'zip':
    ensure => installed,
  }
}