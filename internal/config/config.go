package config

import (
	"log/slog"
	"os"
)

type Config struct {
	Port     string
	LogLevel slog.Level
}

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
