#!/bin/sh

# Get current folder name
FULL_NAME=$(basename "$PWD")

# Extract short name (after timestamp)
PROJECT_NAME="${FULL_NAME##*-}"

echo "Creating Go project: $PROJECT_NAME"

# Initialize go module with short name
go mod init "$PROJECT_NAME"

# Create folders
mkdir -p cmd/"$PROJECT_NAME"
mkdir -p bin

# Create main.go
cat <<EOF > cmd/"$PROJECT_NAME"/main.go
package main

import (
	"context"
    "log"

	"$PROJECT_NAME"
)

func main() {
    if err := $PROJECT_NAME.Run(context.Background()); err != nil {
		log.Fatal(err)
    }
}
EOF

# Create root-level .go file with Run() function
cat <<EOF > "$PROJECT_NAME".go
// Package $PROJECT_NAME ...
package $PROJECT_NAME

import (
	"context"
	"log/slog"
	"os"

	"github.com/golang-cz/devslog"
)

func Run(ctx context.Context) error {
    logger := slog.New(devslog.NewHandler(os.Stdout, nil))
	logger.InfoContext(ctx, "Running $PROJECT_NAME!")

    return nil
}
EOF

# Create Makefile with PROJECT = short name
cat <<EOF > Makefile
PROJECT := $PROJECT_NAME

run:
	go run ./cmd/\$(PROJECT)/main.go

rerun:
	go run github.com/goware/rerun/cmd/rerun -watch ./ -run \
		'go build -o ./bin/\$(PROJECT) ./cmd/\$(PROJECT)/main.go && ./bin/\$(PROJECT)'
EOF

go get -tool github.com/goware/rerun/cmd/rerun
go get github.com/golang-cz/devslog@latest
go mod tidy

echo "Project '$PROJECT_NAME' created."
echo "Root-level file created: $PROJECT_NAME.go with Run() function."
