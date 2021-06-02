## Setup

bundle install

## Generate proto:

./gen_proto.sh  user.proto

## Run server

ruby server.rb

## Run clients

### Get index users

ruby clients/index.rb

### Get show user

ruby clients/show.rb userID

### Create user

ruby clients/create.rb
