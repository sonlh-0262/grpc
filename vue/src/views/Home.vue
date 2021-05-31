<template>
  <div class="home">
    <p>{{ username }}</p>
    <a  @click="testGrpc"> Test GRPCWeb</a>
    <HelloWorld msg="TEST | GRPC"/>
  </div>
</template>

<script lang="ts">
/* eslint-disable */
import { userClient } from '@/pb/user/UserServiceClientPb'
import { GetRequest, GetResponse } from '@/pb/user/user_pb'
import * as grpcWeb from 'grpc-web'
import { Options, Vue } from 'vue-class-component'
import HelloWorld from '@/components/HelloWorld.vue' // @ is an alias to /src

@Options({
  components: {
    HelloWorld
  }
})
export default class Home extends Vue {
  public username: string = ''

  public testGrpc (): void {
    const client = new userClient(
      'http://localhost:21308',
      null,
      null
    )
    const request = new GetRequest()
    request.setKeyword('1234')

    client.getUsers(request, {}, (err: grpcWeb.Error, response: GetResponse) => {
      if (response) {
        console.log(response)
        this.username = response.getUsersList()[0].getName()
      }
      console.log(response.getStatus())
    })
  }
}
</script>
