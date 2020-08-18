# install nginx

exec { 'update':
  command => 'sudo apt-get update',
  path    => ['/usr/bin', '/bin'],
}

package { 'nginx':
  ensure  => 'installed',
  require => Exec['update'],
}

# create files drwxr-xr-x

file { '/data':
  ensure  => directory,
  mode    => '0755',
  owner   => 'ubuntu',
  group   => 'ubuntu',
  require => Package['nginx'],
}

file { '/data/web_static':
  ensure  => directory,
  mode    => '0755',
  owner   => 'ubuntu',
  group   => 'ubuntu',
  require => File['/data'],
}

file { '/data/web_static/releases':
  ensure  => directory,
  mode    => '0755',
  owner   => 'ubuntu',
  group   => 'ubuntu',
  require => File['/data/web_static'],
}

file { '/data/web_static/shared':
  ensure  => directory,
  mode    => '0755',
  owner   => 'ubuntu',
  group   => 'ubuntu',
  require => File['/data/web_static'],
}

file { '/data/web_static/releases/test':
  ensure  => directory,
  mode    => '0755',
  owner   => 'ubuntu',
  group   => 'ubuntu',
  require => File['/data/web_static/releases'],
}

# html

file { '/data/web_static/releases/test/index.html':
  ensure  => file,
  mode    => '0755',
  content => "<html>\n\t<head>\n\t</head>\n\t<body>\n\t\tHolberton School\n\t</body>\n</html>\n",
  owner   => 'ubuntu',
  group   => 'ubuntu',
  require => File['/data/web_static/releases/test'],
}

# create symbolic link

file { '/data/web_static/current':
  ensure  => link,
  target  => '/data/web_static/releases/test',
  mode    => '0777',
  owner   => 'ubuntu',
  group   => 'ubuntu',
  require => File['/data/web_static', '/data/web_static/releases/test']
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
