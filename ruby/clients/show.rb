this_dir = File.expand_path(File.dirname(__FILE__))
proto_dir = File.join(this_dir.gsub('/clients', ''), 'proto')
$LOAD_PATH.unshift(proto_dir) unless $LOAD_PATH.include?(proto_dir)

require 'grpc'
require 'user_services_pb'

def run
  hostname = 'localhost:50051'
  stub = User::UserService::Stub.new(hostname, :this_channel_is_insecure)
  user_id = ARGV[0]
  abort "ERROR user_id" if user_id.nil?

  begin
    response = stub.show(User::UserRequestId.new(id: user_id.to_i))

    if response.user.nil?
      p "User error: #{response.error.inspect}"
    else
      p "User: #{response.user.inspect}"
    end
  rescue GRPC::BadStatus => e
    abort "ERROR: #{e.message}"
  end
end

run
