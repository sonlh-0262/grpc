from concurrent import futures
import logging
import grpc
import user_pb2
import user_pb2_grpc

class UserController(user_pb2_grpc.UserServiceServicer):
  def Index(self, request, context):
    fake_users = self._fake_users()
    users = []
    for user in fake_users:
      users.append(user_pb2.User(id=user['id'], name=user['name'], email=user['email']))
    return user_pb2.UserList(users=users)

  def Show(self, request, context):
    fake_users = self._fake_users()
    user = None
    for _user in fake_users:
      if _user['id'] == request.id:
        user = _user
        break

    if user == None:
      error = user_pb2.Error(code=grpc.Core.StatusCodes.NOT_FOUND, message='Not found user')
      return user_pb2.UserResponse(error=error)
    else:
      user_response = user_pb2.User(id=user['id'], name=user['name'], email=user['email'])
      return user_pb2.UserResponse(user=user_response)

  def _fake_users(self):
    return [
      { 'id': 1, 'name': 'user 1', 'email': 'user1@mail.com' },
      { 'id': 2, 'name': 'user 2', 'email': 'user2@mail.com' },
      { 'id': 3, 'name': 'user 3', 'email': 'user3@mail.com' }
    ]

def serve():
  server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
  user_pb2_grpc.add_UserServiceServicer_to_server(UserController(), server)
  server.add_insecure_port('[::]:50051')
  server.start()
  server.wait_for_termination()


if __name__ == '__main__':
  logging.basicConfig()
  serve()
