package main

import "net/http"

func main() {
	http.HandleFunc("GET /", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Add("Content-Type", "text/plain")
		w.Write([]byte("Hello from Advent of DevOps!"))
		w.WriteHeader(http.StatusOK)
	})

	http.ListenAndServe(":8000", nil)
}
