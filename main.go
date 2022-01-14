package main

import (
	"log"
	"net/http"
)

func main() {
	http.Handle("/", http.HandlerFunc(func(rw http.ResponseWriter, r *http.Request) {
		rw.Write([]byte("Hello, World!"))
	}))

	log.Println("Serving on port 8000")
	err := http.ListenAndServe(":8000", nil)
	if err != nil {
		log.Fatalf("Server exited with: %v", err)
	}
}
