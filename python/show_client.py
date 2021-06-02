import sys
import logging
import grpc
import user_pb2
import user_pb2_grpc

def run():
  try:
    user_id = int(sys.argv[1])
  except:
    print('Please input user id')
    return

  with grpc.insecure_channel('localhost:50051') as channel:
    stub = user_pb2_grpc.UserServiceStub(channel)
    response = stub.Show(user_pb2.UserRequestId(id=user_id))

  if response.user != None:
    print('User received: ')
    print(response.user)
  else:
    print('Error: ')
    print(response.error)

if __name__ == '__main__':
  logging.basicConfig()
  run()
