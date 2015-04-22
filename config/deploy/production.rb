# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.
set :rails_env, 'production'                  # If the environment differs from the stage name
set :branch, 'production'

# set :unicorn_pid, shared_path.join("tmp/pids/unicorn.pid")
# set :unicorn_config, shared_path.join("config/unicorn.rb")
set :unicorn_workers, 4
# set :unicorn_service,

set :nginx_server_name, '54.200.157.85'
set :nginx_location, "/etc/nginx"
set :nginx_pid, "/run/nginx.pid"

role :app, %w{54.200.157.85}
role :web, %w{54.200.157.85}
role :db,  %w{54.200.157.85}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

server '54.200.157.85', user: 'ers', roles: %w{web app db}#, my_property: :my_value


# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# And/or per server (overrides global)
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
