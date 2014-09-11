[![Build Status](https://travis-ci.org/klamontagne/chef-burp.svg?branch=master)](https://travis-ci.org/klamontagne/chef-burp)

# Description

Installs & configures a [BURP](http://burp.grke.org/) backup server and
its clients. Adds
[definitions](https://docs.getchef.com/essentials_cookbook_definitions.html) to
add paths to backup or exclude, and "plugin" scripts to execute before and/or
after a backup. (such as dumping a database)


# Requirements

## Platform:

* Ubuntu (>= 12.04)

## Cookbooks:

* apt
* build-essential (>= 2.0.0)
* git
* partial_search (~> 1.0.8)

# Attributes

* `node['burp']['restrict_search_environment']` - Whether to restrict the search for clients to the same environment as the
server. Defaults to `"false"`.
* `node['burp']['servername']` - The server adress or name that clients are expected to connect to. Defaults to `"node['fqdn']"`.

# Recipes

## burp::client

Install BURP and setup a client configuration with a random password.
Sets the server to the content of ```node['burp']['server']```.
Set this attribute in a
[wrapper cookbook](http://www.getchef.com/blog/2013/12/03/doing-wrapper-cookbooks-right/),
or in an environment, for example.

## burp::common

Retrieve burp [from Github](https://github.com/grke/burp), compile and install the binaries.
Also installs build dependencies
*librsync-dev*,
*libz-dev*,
*libssl-dev*,
*uthash-dev*.

## burp::server

Install BURP and setup a server configuration in /etc/burp-server.
Searches for clients and installs an individual config file for each one in
*/etc/burp-server/clientconfdir*.

# Definitions

## burp_include

Add a path to be backed up by the BURP client.
The path is added to node attributes during
[compile time](http://docs.getchef.com/essentials_nodes_chef_run.html),
so the burp::client recipe can be added at any point in your run_list.

Example:

```ruby
burp_include '/var/backups'
```

## burp_exclude

Add a path to be excluded by the BURP client.
The path is added to node attributes during
[compile time](http://docs.getchef.com/essentials_nodes_chef_run.html),
so the burp::client recipe can be added at any point in your run_list.

Example:

```ruby
burp_exclude '/var/lib/mysoftware/cache'
```

## burp_exclude_regex

Add a regex to be excluded by the BURP client.
The regex is added to node attributes during
[compile time](http://docs.getchef.com/essentials_nodes_chef_run.html),
so the burp::client recipe can be added at any point in your run_list.
See the [man page](http://burp.grke.org/docs/manpage.html) for the
exclude_regex configuration item.

Example:

```ruby
burp_exclude_regex '.*/bundle/.*'
burp_exclude_regex '.*/cache/.*'
```

# Resources

## burp_plugin

Copies a pair of scripts from a Chef template resource to be used as actions
before/after a backup runs.

### Actions

- create: Default action.

### Attribute Parameters

- name: A name for the plugin. Be creative and avoid duplicates.
ex.: ```mycompany_mysql_backup```
Only accepts valid Debian cron script names (```^[a-zA-Z0-9_-]+$```)
- cookbook: The cookbook in which to find the templates.
- pre_template: The script to run before starting to backup files. if it exits with a non-zero
status, the backup is interrupted. Can be ```nil``` if no script is to be
installed.
 Defaults to```'pre_backup.sh'```
- post_template: The script to run after the backup completes. If it exits with a non-zero
status, the other plugins **will still run**. Can be ```nil``` if no script is
to be installed. Defaults to ```'post_backup.sh'```

Examples:

```ruby
burp_plugin 'cassandra' do
  cookbook 'mycompany-cassandra'
  pre_template 'scripts/snapshot.sh'
  post_template 'clear snapshot'
end

burp_plugin 'mysql' do
  cookbook 'mycompany-mysql'
  pre_template 'dump.sh'
  post_template nil
end
```

# License and Maintainer

Maintainer:: Kevin Lamontagne (<kevinlamontagne@gmail.com>)

License:: MIT
