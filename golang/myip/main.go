package main

import (
	"context"
	"fmt"
	"log"

	"github.com/aws/aws-lambda-go/lambda"
)

func HandleRequest(ctx context.Context, event interface{}) (string, error) {
	log.Println(ctx)
	return fmt.Sprintln(event), nil
}

func main() {
	lambda.Start(HandleRequest)
}
