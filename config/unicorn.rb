
APP_PATH = "/home/administrator/rails_projects/cs-201310-ipad-app-web"

worker_processes 8

timeout 90

working_directory APP_PATH
listen APP_PATH + "/tmp/sockets/.unicorn.sock", :backlog => 64
listen 8080, :tcp_nopush => true
stderr_path APP_PATH + "/log/unicorn.stderr.log"
stdout_path APP_PATH + "/log/unicorn.stderr.log"
pid APP_PATH + "/tmp/pids/unicorn.pid"

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
    GC.copy_on_write_friendly = true

check_client_connection false

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.connection.disconnect!
end


after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.establish_connection
end


