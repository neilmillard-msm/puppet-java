class java::create-truststore($hostname = '', $port = 443, $passphrase = ''){

  file {"/usr/java/default/lib/InstallCert.java":
    source => "puppet:///modules/java/InstallCert/InstallCert.java",
    owner => "root",
    group => "root",
    mode => 0644
  }

  exec {"Compile InstallCert.java":
    command => "javac InstallCert.java",
    cwd => "/usr/java/default/lib/",
    path => "/usr/java/default/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin",
    subscribe => File["/usr/java/default/lib/InstallCert.java"],
    environment => ["JAVA_HOME=/usr/java/default/"],
    creates => "/usr/java/default/lib/InstallCert.class",
    require => File["/usr/java/default/lib/InstallCert.java"],
  } ->

  exec {"create-trustore":
    command => "java InstallCert $hostname:$port $passphrase",
    cwd => "/usr/java/default/lib",
    environment => ["JAVA_HOME=/usr/java/default/"],
    path => "/usr/java/default/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin",
  }
}

