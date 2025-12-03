package main

import (
	"encoding/json"
	"log"
	"net/http"
	"os"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/joho/godotenv"
)

func main() {
	if err := godotenv.Load(); err != nil {
		log.Println("No .env file found or error loading it")
	}

	port := os.Getenv("PORT")
	if port == "" {
		port = "3000"
	}

	r := chi.NewRouter()
	r.Use(middleware.Logger)

	r.Get("/health", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		err := json.NewEncoder(w).Encode(map[string]string{"status": "ok"})

		if err != nil {
			log.Printf("Error encoding health check response: %v", err)
			return
		}
	})

	r.Get("/", func(w http.ResponseWriter, r *http.Request) {
		http.Redirect(w, r, "https://www.linkedin.com/in/egodzb", http.StatusFound)
	})

	fileServer := http.FileServer(http.Dir("./static"))
	r.Handle("/*", fileServer)

	log.Printf("Server starting on port %s", port)

	err := http.ListenAndServe(":"+port, r)

	if err != nil {
		log.Printf("Error starting server: %v", err)
		return
	}
}
