class tomcat::service {

  service { $::tomcat::service_name :
    ensure  => $::tomcat::service_state,
    enable  => true,
    require => Class['tomcat::install'],
  }
}