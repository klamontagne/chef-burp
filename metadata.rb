name 'burp'
maintainer 'Kevin Lamontagne'
maintainer_email 'kevinlamontagne@gmail.com'
license 'MIT'
description <<-EOF
Installs & configures a BURP ( http://burp.grke.org/ ) backup server and
its clients. Adds resources to backup or exclude paths, and "plugin" scripts to execute before and/or
after a backup. (such as dumping a database)
EOF
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url "https://github.com/klamontagne/chef-burp" if respond_to?(:source_url)
issues_url "https://github.com/klamontagne/chef-burp/issues" if respond_to?(:issues_url)

version '0.2.3'

supports 'ubuntu', '>= 12.04'

depends 'apt'
depends 'build-essential', '>= 2.0.0'
depends 'git'
depends 'partial_search', '~> 1.0.8'
