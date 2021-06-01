this_dir = File.expand_path(File.dirname(__FILE__))
proto_dir = File.join(this_dir.gsub('/clients', ''), 'proto')
$LOAD_PATH.unshift(proto_dir) unless $LOAD_PATH.include?(proto_dir)

require 'grpc'
require 'user_services_pb'

def run
  hostname = ARGV.size > 1 ?  ARGV[1] : 'localhost:50051'
  stub = User::UserService::Stub.new(hostname, :this_channel_is_insecure)

  begin
    users = stub.index(User::Empty.new).users
    p "Users: #{users.inspect}"
  rescue GRPC::BadStatus => e
    abort "ERROR: #{e.message}"
  end
end

run
