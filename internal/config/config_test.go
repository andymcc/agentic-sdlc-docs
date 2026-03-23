package config

import (
	"log/slog"
	"testing"
)

func TestLoadDefaults(t *testing.T) {
	t.Setenv("PORT", "")
	t.Setenv("LOG_LEVEL", "")

	cfg := Load()

	if cfg.Port != "8080" {
		t.Errorf("expected default port 8080, got %s", cfg.Port)
	}
	if cfg.LogLevel != slog.LevelInfo {
		t.Errorf("expected default log level Info, got %v", cfg.LogLevel)
	}
}

func TestLoadCustom(t *testing.T) {
	t.Setenv("PORT", "3000")
	t.Setenv("LOG_LEVEL", "debug")

	cfg := Load()

	if cfg.Port != "3000" {
		t.Errorf("expected port 3000, got %s", cfg.Port)
	}
	if cfg.LogLevel != slog.LevelDebug {
		t.Errorf("expected log level Debug, got %v", cfg.LogLevel)
	}
}
