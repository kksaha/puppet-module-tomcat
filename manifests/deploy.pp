define tomcat::deploy(
  $deploy_path = $::tomcat::deploy_path,
  $deploy_url,
  $checksum_value,
  $checksum = 'md5',
) {

   file {"${deploy_path}/${name}.war":
     source         => "${deploy_url}",
     owner          => "$::tomcat::user",
     group          => "$::tomcat::group",
     checksum       => "${checksum}",
     checksum_value => "${checksum_value}",
     notify         => Exec['purge_context'],
   }
   
   exec { "purge_context":
     path        => ['/bin', '/usr/bin', '/usr/sbin'],
     command     => "rm -rf ${deploy_path}/${name}",
     refreshonly => true,
     notify      => Service['tomcat'],
   }

}