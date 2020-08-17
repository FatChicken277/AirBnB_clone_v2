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

file { '/data/web_static/shared/':
    ensure  =>  directory,
}

file { '/data/web_static/releases/test/':
    ensure  =>  directory,
}

# html

file { '/data/web_static/releases/test/index.html':
  ensure  => file,
  content => "<html>\n\t<head>\n\t</head>\n\t<body>\n\t\tHolberton School\n\t</body>\n</html>"
}

# create symbolic link

file { '/data/web_static/current':
  ensure  => link,
  target  => '/data/web_static/releases/test/',
}

# Change owner and group

exec { 'owne_group':
  command => 'chown -R ubuntu:ubuntu /data/',
  path    => ['/usr/bin', '/bin'],
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
