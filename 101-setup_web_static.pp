# install nginx

exec { 'update':
  command => 'sudo apt-get update',
  path    => ['/usr/bin', '/bin'],
}

package { 'nginx':
  ensure   => 'installed',
  name     => 'nginx',
  provider => 'apt',
  require  => Exec['update'],
}

# create files

file { '/data/':
    ensure =>  directory,
    owner  => 'ubuntu',
    group  => 'ubuntu',
}

file { '/data/web_static/':
    ensure  =>  directory,
    owner   => 'ubuntu',
    group   => 'ubuntu',
    require => File['/data/'],
}

file { '/data/web_static/releases/':
    ensure  =>  directory,
    owner   => 'ubuntu',
    group   => 'ubuntu',
    require => File['/data/web_static/'],
}

file { '/data/web_static/shared/':
    ensure  =>  directory,
    owner   => 'ubuntu',
    group   => 'ubuntu',
    require => File['/data/web_static/'],
}

file { '/data/web_static/releases/test/':
    ensure  =>  directory,
    owner   => 'ubuntu',
    group   => 'ubuntu',
    require => File['/data/web_static/releases'],
}

# html

file { '/data/web_static/releases/test/index.html':
  ensure  => file,
  owner   => 'ubuntu',
  group   => 'ubuntu',
  content => "<html>\n\t<head>\n\t</head>\n\t<body>\n\t\tHolberton School\n\t</body>\n</html>"
  require => File['/data/web_static/releases/test'],
}

# create symbolic link

file { '/data/web_static/current':
  ensure  => link,
  target  => '/data/web_static/releases/test/',
  require => File['/data/web_static/releases/test'],
}

# config

file_line { 'config_file':
  path    => '/etc/nginx/sites-available/default',
  line    => "\tlocation /hbnb_static {\n\t\talias /data/web_static/current/;\n\t}\n",
  after   => 'listen 80 default_server;',
  require => Package['nginx'],
}

# start server.

exec { 'restart':
  command => 'sudo service nginx restart',
  path    => ['/usr/bin', '/bin'],
  require => File_line['config_file'],
}
