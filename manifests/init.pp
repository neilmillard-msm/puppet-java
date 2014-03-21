class java (
  
  $source_url, 
  $java_major_version, 
  $java_minor_version,

  ) inherits java::params {
 
  $java_filename = "jdk-${java_major_version}u${java_minor_version}-linux-x64.rpm"

  # Download the jdk from our S3 bucket
  include wget
  wget::fetch { 'jdk':
    source      => "${source}/$java_filename",
    destination => "/usr/local/$java_filename",
    timeout     => 0,
    verbose     => false,
  }

  # Install the jdk
  package {'jdk':
    provider => rpm,
    ensure   => "1.${java_major_version}.0_${java_minor_version}-fcs",
    source   => "/usr/local/$java_filename",
    require  => Wget::Fetch['jdk'],
  }

}