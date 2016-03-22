# Base includes the Fedora Everything files from the initial release
class repo_fedora::fedora {

  include ::repo_fedora

  if $repo_fedora::enable_base {
    $enabled = '1'
  } else {
    $enabled = '0'
  }
  if $repo_fedora::enable_mirrorlist {
    $mirrorlist = "${repo_fedora::mirrorlisturl}/metalink?repo=fedora-$releasever&arch=$basearch"
    $baseurl = 'absent'
  } else {
    $mirrorlist = 'absent'
    $baseurl = "${repo_fedora::repourl}/\$releasever/Everything/\$basearch/os/"
  }

  # Yumrepo ensure only in Puppet >= 3.5.0
  if versioncmp($::puppetversion, '3.5.0') >= 0 {
    Yumrepo <| title == 'fedora' |> { ensure => $repo_fedora::ensure_base }
  }

  yumrepo { 'fedora':
    baseurl    => $baseurl,
    mirrorlist => $mirrorlist,
    descr      => 'fedora',
    enabled    => $enabled,
    gpgcheck   => '1',
    gpgkey     => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-${::repo_fedora::releasever}-\$basearch",
    #priority   => '1',
  }

}