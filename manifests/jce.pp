class java::jce (
  $java_major_version,
  $jdk_path,
  $source,
) {
  # puppet_java creates standard java home
  # export JAVA_HOME=/usr/java/default

  # Requires
  require java::package

  $repo_url    = 'https://artifactory3-eu1.moneysupermarket.com/artifactory'
  $driver_repo = 'ext-release-local'

  wget::fetch { "${repo_url}/${driver_repo}/oracle/security/UnlimitedJCEPolicyJDK7.zip":
    destination => '/tmp/UnlimitedJCEPolicyJDK7.zip',
  } ->
  exec { 'unzip-jce':
    cwd     => '/usr/java/default/jre/lib/security',
    path    => '/bin/:/usr/bin',
    command => 'unzip -jo /tmp/UnlimitedJCEPolicyJDK7.zip',
    require => Package['unzip'],
  } ->
  exec { 'chmod-jce-files':
    cwd     => '/usr/java/default/jre/lib/security',
    path    => '/bin/:/usr/bin',
    command => 'chmod 0644 local_policy.jar US_export_policy.jar',
  }
}