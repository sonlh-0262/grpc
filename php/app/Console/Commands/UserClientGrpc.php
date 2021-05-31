<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use User\userClient;
use User\GetRequest;
use Grpc\ChannelCredentials;

class UserClientGrpc extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'grpc:user';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'grpc connect user from server golang';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {
        $hostname = 'go:1308';
        $client = new userClient($hostname, [
            'credentials' => ChannelCredentials::createInsecure(),
        ]);

        $request = new GetRequest();
        $request->setKeyword("HELLO");

        list($response, $status) = $client->GetUsers($request)->wait();
        if ($status->code !== \Grpc\STATUS_OK) {
            echo "ERROR: " . $status->code . ", " . $status->details . PHP_EOL;
            exit(1);
        }

        var_dump($response->getUsers()[0]->getName());
    }
}
