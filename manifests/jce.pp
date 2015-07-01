class java::jce (
    $java_major_version,
    $jdk_path
  ) {

  # puppet_java creates standard java home
  # export JAVA_HOME=/usr/java/default

  file { "$jdk_path/jre/lib/security/README.txt":
    source => "puppet:///modules/java/jce/$java_major_version/README.txt",
    mode   => '0644',
    owner  => 'root',
    group  => 'root'
  }

  file { "$jdk_path/jre/lib/security/local_policy.jar":
    source => "puppet:///modules/java/jce/$java_major_version/local_policy.jar",
    mode   => '0644',
    owner  => 'root',
    group  => 'root'
  }

  file { "$jdk_path/jre/lib/security/US_export_policy.jar":
    source => "puppet:///modules/java/jce/$java_major_version/US_export_policy.jar",
    mode   => '0644',
    owner  => 'root',
    group  => 'root'
  }
}