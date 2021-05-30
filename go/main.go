package main

import (
	pb "github.com/dao.anh.dung/grpc/serve/pb/user"
	"golang.org/x/net/context"
	"google.golang.org/grpc"
	"log"
	"net"
)

type server struct {
	request []*pb.GetRequest
}

func (s *server) GetUsers(ctx context.Context, req *pb.GetRequest) (*pb.GetResponse, error) {
	users := &pb.GetResponse{
		Status: "success",
		Users: []*pb.User{
			&pb.User{
				Id:   "1",
				Name: req.Keyword,
			},
		},
	}
	return users, nil
}

func main() {
	// tcp listener
	lis, err := net.Listen("tcp", ":1308")
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	srv := grpc.NewServer()
	pb.RegisterUserServer(srv, &server{})
	srv.Serve(lis)
}
