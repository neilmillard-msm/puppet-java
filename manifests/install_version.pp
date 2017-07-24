#
#
define java::install_version (
  $major_minor  = $title,
  $package_name = '',
  $rpm_filename = '',
  $source       = $java::source_url,
  $add_jce      = true,
) {
  $split_out = split($major_minor, '_')
  $major = $split_out[0]
  $minor = $split_out[1]

  if ($rpm_filename != '') {
    $java_filename = $rpm_filename
  } else {
    $java_filename = "jdk-${major}u${minor}-linux-x64.rpm"
  }

  if ($package_name != '') {
    $package_root_name = $package_name
  } else {
    if ($major == '7') {
      $package_root_name = 'jdk'
    } else {
      $package_root_name = "jdk1.${major}.0_${minor}"
    }
  }

  # Download the jdk from location of choice
  wget::fetch { "jdk ${source}/${java_filename}":
    source      => "${source}/${java_filename}",
    destination => "/usr/local/${java_filename}",
    timeout     => 0,
    verbose     => false,
  }

  package {"jdk 1.${major}.0_${minor}-fcs":
    ensure   => "1.${major}.0_${minor}-fcs",
    name     => $package_root_name,
    provider => rpm,
    source   => "/usr/local/${java_filename}",
    require  => Wget::Fetch["jdk ${source}/${java_filename}"],
  }

  # Add JCE
  class { 'java::jce':
    java_major_version => "$major",
    jdk_path           => "/usr/java/jdk1.${major}.0_${minor}",
    repo_url           => $source,
    require            => Package["jdk 1.${major}.0_${minor}-fcs"]
  }

}