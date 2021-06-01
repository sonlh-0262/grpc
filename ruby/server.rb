this_dir = File.expand_path(File.dirname(__FILE__))
proto_dir = File.join(this_dir, 'proto')
$LOAD_PATH.unshift(proto_dir) unless $LOAD_PATH.include?(proto_dir)

require 'grpc'
require 'user_services_pb'
require 'securerandom'
require 'pry'

class UserController < User::UserService::Service
  def index(request, _unused_call)
    User::UserList.new(users: users)
  end

  def create(request, _unused_call)
    data = request
    data.id = users.map{|u| u[:id]}.max.next
    # TODO insert data to users list

    User::User.new(
      id: data.id,
      name: data.name,
      email: data.email
    )
  end

  def show(request, _unused_call)
    user = users.find{|u| u[:id] == request.id}

    if user.nil? || user.empty?
      error = User::Error.new(
        code: GRPC::Core::StatusCodes::NOT_FOUND,
        message: 'Not found user'
      )
      User::UserResponse.new(error: error)
    else
      user_response = User::User.new(user)
      User::UserResponse.new(user: user)
    end
  end

  private

  def users
    @users ||= [
      { id: 1, name: 'user 1', email: 'user1@mail.com' },
      { id: 2, name: 'user 2', email: 'user2@mail.com' },
      { id: 3, name: 'user 3', email: 'user3@mail.com' }
    ]
  end
end

# run starts an RpcServer that receives requests to UserController at the sample
# server port.
def run
  s = GRPC::RpcServer.new
  s.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
  s.handle(UserController)
  # Runs the server with SIGHUP, SIGINT and SIGQUIT signal handlers to
  #   gracefully shutdown.
  # User could also choose to run server via call to run_till_terminated
  s.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
end

run
