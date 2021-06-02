import logging
import grpc
import user_pb2
import user_pb2_grpc

def run():
  with grpc.insecure_channel('localhost:50051') as channel:
      stub = user_pb2_grpc.UserServiceStub(channel)
      response = stub.Index(user_pb2.Empty())
  print("Client received: ")
  print(response.users)

if __name__ == '__main__':
  logging.basicConfig()
  run()
