# Load environment variables from .env if present
ifneq (,$(wildcard .env))
  include .env
  export
endif

# Default/fallback values (can be overridden by .env or shell env)
MVN := mvn -B -ntp
DOCKER := docker

.DEFAULT_GOAL := help

.PHONY: help install clean lint test build docker-build ci check-env

help:
	@echo ""
	@echo "Available targets:"
	@echo "  make help         - Show this help"
	@echo "  make install      - Download dependencies (offline cache warm-up)"
	@echo "  make clean        - Clean build artifacts"
	@echo "  make lint         - Run linting (fails on lint errors)"
	@echo "  make test         - Run tests (fails on test errors)"
	@echo "  make build        - Build the application jar (fails on errors)"
	@echo "  make docker-build - Build Docker image $(APP_NAME):latest"
	@echo "  make ci           - Run install + lint + test + build + docker-build"
	@echo ""

check-env:
	@set -e; \
	if [ -z "$(APP_NAME)" ]; then \
		echo "ERROR: APP_NAME is not set. Add APP_NAME=your-app-name to .env (or export it in your shell)."; \
		exit 1; \
	fi

install: check-env
	@set -e; \
	echo "==> Installing dependencies (offline cache warm-up)"; \
	if [ ! -f pom.xml ]; then echo "ERROR: pom.xml not found in project root."; exit 1; fi; \
	$(MVN) -Dstyle.color=always -DskipTests dependency:go-offline; \
	echo "==> Done."

clean: check-env
	@set -e; \
	echo "==> Cleaning project"; \
	if [ ! -f pom.xml ]; then echo "ERROR: pom.xml not found in project root."; exit 1; fi; \
	$(MVN) -Dstyle.color=always clean; \
	echo "==> Done."

lint: check-env
	@set -e; \
	echo "==> Running lint (Checkstyle + SpotBugs)"; \
	if [ ! -f pom.xml ]; then echo "ERROR: pom.xml not found in project root."; exit 1; fi; \
	if grep -q "<artifactId>maven-checkstyle-plugin</artifactId>" pom.xml; then \
		echo "==> Checkstyle plugin found; running checkstyle:check"; \
		$(MVN) -Dstyle.color=always -DskipTests checkstyle:check; \
	else \
		echo "ERROR: Checkstyle plugin not found in pom.xml. Add maven-checkstyle-plugin to enable linting."; \
		exit 1; \
	fi; \
	if grep -q "<artifactId>spotbugs-maven-plugin</artifactId>" pom.xml; then \
		echo "==> SpotBugs plugin found; running spotbugs:check"; \
		$(MVN) -Dstyle.color=always -DskipTests spotbugs:check; \
	else \
		echo "ERROR: SpotBugs plugin not found in pom.xml. Add spotbugs-maven-plugin to enable linting."; \
		exit 1; \
	fi; \
	echo "==> Lint passed."

test: check-env
	@set -e; \
	echo "==> Running tests"; \
	if [ ! -f pom.xml ]; then echo "ERROR: pom.xml not found in project root."; exit 1; fi; \
	$(MVN) -Dstyle.color=always test; \
	echo "==> Tests passed."

build: check-env
	@set -e; \
	echo "==> Building application"; \
	if [ ! -f pom.xml ]; then echo "ERROR: pom.xml not found in project root."; exit 1; fi; \
	$(MVN) -Dstyle.color=always -DskipTests clean package; \
	echo "==> Build complete. (Jar in target/)"

docker-build: check-env
	@set -e; \
	echo "==> Building Docker image: $(APP_NAME):latest"; \
	if [ ! -f Dockerfile ]; then echo "ERROR: Dockerfile not found in project root."; exit 1; fi; \
	$(DOCKER) build -t $(APP_NAME):latest .; \
	echo "==> Docker image built: $(APP_NAME):latest"

ci: check-env
	@set -e; \
	echo "==> CI pipeline started"; \
	$(MAKE) install; \
	$(MAKE) lint; \
	$(MAKE) test; \
	$(MAKE) build; \
	$(MAKE) docker-build; \
	echo "==> CI pipeline finished successfully"
