# Always use bash as the shell.
SHELL:=bash

# Enable bash strict mode.
.SHELLFLAGS:=-eu -o pipefail -c

# Delete it's target file if a Make rule fails.
.DELETE_ON_ERROR:

MAKEFLAGS += --no-builtin-rules

.DEFAULT_GOAL:=help

DC:=docker compose

HELP_TARGET:=\033[32m%-20s\033[0m %s\n

CN_APP:=app

.PHONY: help
help:
	@printf "\033[33mUsage:\033[0m\n  make [target] [arg=\"val\"...]\n\n\033[33mTargets:\033[0m\n"
	@printf " $(HELP_TARGET)" "help" "Afiseaza acest help"
	@printf " $(HELP_TARGET)" ".env" "Genereaza fisierul .env"
	@printf " $(HELP_TARGET)" "start" "Porneste containerele"
	@printf " $(HELP_TARGET)" "start-build" "Porneste containerele insa inainte, forteaza reconstruirea lor"
	@printf " $(HELP_TARGET)" "stop" "Opreste containerele"
	@printf " $(HELP_TARGET)" "stop-rmi" "Opreste containerele si sterge imaginile docker"
	@printf " $(HELP_TARGET)" "ps" "Afiseaza o lista cu containerele pornite"
	@printf " $(HELP_TARGET)" "ps-a" "Afiseaza o lista cu toate containerele indiferent daca sunt pornite sau nu"
	@printf " $(HELP_TARGET)" "build" "Construieste containerele"
	@printf " $(HELP_TARGET)" "build-nc" "Construieste containerele fara a folosi cache-ul"
	@printf " $(HELP_TARGET)" "composer-i" "Instaleaza dependintele composer"
	@printf " $(HELP_TARGET)" "dump-autoload" "Reconstruieste autoloaderul composer"
	@printf " $(HELP_TARGET)" "clear-env" "Sterge fisierul .env"
	@printf " $(HELP_TARGET)" "clear-vendor" "Sterge folderul vendor"
	@printf " $(HELP_TARGET)" "clear-vendor-lock" "Sterge folderul vendor si fisierul composer.lock"
	@printf " $(HELP_TARGET)" "sh-app" "Obtine un shell in containerul care ruleaza applicatia"
	@printf " $(HELP_TARGET)" "sh-db" "Obtine un shell in containerul care baza de date"

.env:
	@cp .env.dist .env
