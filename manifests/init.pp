class java (  
  $source_url = "https://download.oracle.com/otn-pub/java/jdk/7u51-b13", 
  $java_major_version = 7, 
  $java_minor_version = 51,
  ) {
 
  $java_filename = "jdk-${java_major_version}u${java_minor_version}-linux-x64.rpm"

  # Download the jdk from location of choice
  include wget
  wget::fetch { 'jdk':
    source      => "${source_url}/$java_filename",
    destination => "/usr/local/$java_filename",
    timeout     => 0,
    verbose     => false,
  }

  # Install the jdk
  exec {"remove.any.openjdk":
    command => "/bin/rpm -qa | /bin/grep openjdk | /usr/bin/xargs /bin/rpm -ev || continue"
  }->
  exec {"remove.any.jdk":
    command => "/bin/rpm -qa | /bin/grep jdk | /usr/bin/xargs /bin/rpm -ev || continue"
  }->
  package {'jdk':
    provider => rpm,
    ensure   => "1.${java_major_version}.0_${java_minor_version}-fcs",
    source   => "/usr/local/$java_filename",
    require  => Wget::Fetch['jdk'],
  }

  # Configure JAVA_HOME globlly.
  file { '/etc/profile.d/java.sh':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => 644,
    content => "export JAVA_HOME=/usr/java/default",
  }

}
