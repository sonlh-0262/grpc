this_dir = File.expand_path(File.dirname(__FILE__))
proto_dir = File.join(this_dir.gsub('/clients', ''), 'proto')
$LOAD_PATH.unshift(proto_dir) unless $LOAD_PATH.include?(proto_dir)

require 'grpc'
require 'user_services_pb'
require 'securerandom'

def run
  hostname = 'localhost:50051'
  stub = User::UserService::Stub.new(hostname, :this_channel_is_insecure)

  request_user = {
    name: "name #{SecureRandom.hex(4)}",
    email: "email#{SecureRandom.hex(4)}"
  }

  begin
    user = stub.create(User::User.new(request_user))
    p "User created: #{user.inspect}"
  rescue GRPC::BadStatus => e
    abort "ERROR: #{e.message}"
  end
end

run
