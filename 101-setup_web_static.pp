# install nginx

package { 'nginx':
  ensure  => 'installed',
}

# create files drwxr-xr-x

file { '/data/':
  ensure => directory,
  mode   => '0755',
  owner  => 'ubuntu',
  group  => 'ubuntu',
}

file { '/data/web_static':
  ensure => directory,
  mode   => '0755',
  owner  => 'ubuntu',
  group  => 'ubuntu',
}

file { '/data/web_static/releases/':
  ensure => directory,
  mode   => '0755',
  owner  => 'ubuntu',
  group  => 'ubuntu',
}

file { '/data/web_static/shared/':
  ensure => directory,
  mode   => '0755',
  owner  => 'ubuntu',
  group  => 'ubuntu',
}

file { '/data/web_static/releases/test/':
  ensure => directory,
  mode   => '0755',
  owner  => 'ubuntu',
  group  => 'ubuntu',
}

# html

file { '/data/web_static/releases/test/index.html':
  ensure  => file,
  mode    => '0755',
  content => "<html>\n\t<head>\n\t</head>\n\t<body>\n\t\tHolberton School\n\t</body>\n</html>\n",
  owner  => 'ubuntu',
  group  => 'ubuntu',
}

# create symbolic link

file { '/data/web_static/current':
  ensure => link,
  target => '/data/web_static/releases/test',
  mode   => '0777',
  owner  => 'ubuntu',
  group  => 'ubuntu',
}

# config

file_line { 'config_file':
  path    => '/etc/nginx/sites-available/default',
  line    => "\tlocation /hbnb_static {\n\t\talias /data/web_static/current/;\n\t}\n",
  after   => 'listen 80 default_server;',
}

# start server.

exec { 'restart':
  command => 'sudo service nginx restart',
  path    => ['/usr/bin', '/bin'],
}
