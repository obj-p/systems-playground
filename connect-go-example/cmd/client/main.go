package main

import (
    "context"
    "log"
    "net/http"

    greetv1 "example/gen/greet/v1"
    "example/gen/greet/v1/greetv1connect"

    "connectrpc.com/connect"
)

func main() {
    client := greetv1connect.NewGreetServiceClient(
        http.DefaultClient,
        "http://localhost:8080",
		// connect.WithGRPC(), // to use gRPC protocol instead of Connect protocol
    )
    res, err := client.Greet(
        context.Background(),
        connect.NewRequest(&greetv1.GreetRequest{Name: "Jane"}),
    )
    if err != nil {
        log.Println(err)
        return
    }
    log.Println(res.Msg.Greeting)
}
