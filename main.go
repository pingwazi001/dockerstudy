package main

import (
	"log"
	"net/http"
	"time"
)

func main() {
	http.HandleFunc("/ping", func(rw http.ResponseWriter, r *http.Request) {
		log.Println("ok")
		rw.Write([]byte("ok"))
	})
	http.HandleFunc("/", func(rw http.ResponseWriter, r *http.Request) {
		rw.Write([]byte(time.Now().String()))
	})
	log.Fatal(http.ListenAndServe(":8080", nil))
}
