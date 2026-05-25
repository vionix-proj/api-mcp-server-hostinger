# Docker usage

This repository is dockerized for HTTP MCP transport and is ready for onboarding to the Vionix multi-arch Docker CI/CD workflow.

## Build locally

```bash
docker build -t api-mcp-server-hostinger .
```

## Run locally

HTTP transport requires `HOSTINGER_API_TOKEN`.

```bash
docker run --rm \
  -p 8100:8100 \
  -e HOSTINGER_API_TOKEN="$HOSTINGER_API_TOKEN" \
  api-mcp-server-hostinger
```

Health check:

```bash
curl http://localhost:8100/health
```

## Docker Compose

```bash
HOSTINGER_API_TOKEN="$HOSTINGER_API_TOKEN" docker compose up --build
```

## Vionix multi-arch CI/CD

The workflow file is staged at `github/workflows/docker-multiarch.yml` because this repository does not currently allow creating files under `.github`. To activate it as a GitHub Actions workflow, move it to `.github/workflows/docker-multiarch.yml` when permissions allow.
