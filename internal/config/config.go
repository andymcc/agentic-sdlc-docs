package config

import (
	"log/slog"
	"os"
)

// Config holds application configuration loaded from environment variables.
type Config struct {
	Port     string
	LogLevel slog.Level
}

// Load reads configuration from environment variables with sensible defaults.
func Load() Config {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	level := slog.LevelInfo
	if os.Getenv("LOG_LEVEL") == "debug" {
		level = slog.LevelDebug
	}

	return Config{
		Port:     port,
		LogLevel: level,
	}
}
