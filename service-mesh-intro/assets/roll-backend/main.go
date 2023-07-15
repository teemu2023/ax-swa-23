package main

import (
	"encoding/json"
	"log"
	"math/rand"
	"net/http"
	"time"
)

type Response struct {
	Roll int
}

func main() {
	http.HandleFunc("/roll", func(w http.ResponseWriter, r *http.Request) {
		roll := rand.Intn(20) + 1
		log.Println("OK - 200")
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(Response{roll})
	})

	rand.Seed(time.Now().UnixNano())
	log.Println("Listening on 9300")
	http.ListenAndServe(":9300", nil)
}
