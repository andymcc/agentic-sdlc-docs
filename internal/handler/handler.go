package handler

import (
	"encoding/json"
	"net/http"
)

// Register adds all HTTP handlers to the given mux.
func Register(mux *http.ServeMux) {
	mux.HandleFunc("GET /healthz", handleHealth)
}

func handleHealth(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	_ = json.NewEncoder(w).Encode(map[string]string{"status": "ok"})
}
