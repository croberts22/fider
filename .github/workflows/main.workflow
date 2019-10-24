name: fider

on: [push]

jobs:
  build:
    name: build and test
    runs-on: ubuntu-latest

    steps:
      - name: checkout code
        uses: actions/checkout@v1

      - name: install go 1.13.3
        uses: actions/setup-go@v1
        with:
          go-version: '1.13.3'

      - name: install cli tools
        run: |
          export PATH=$PATH:$(go env GOPATH)/bin
          go get github.com/joho/godotenv/cmd/godotenv
          go get github.com/magefile/mage
          go get github.com/cosmtrek/air/cmd/air

      - name: install go dependencies
        run: go mod download

      - uses: actions/setup-node@v1
        with:
          node-version: 12.x

      - run: npm ci
      - run: mage test:ui