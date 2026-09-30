FROM python:3.12-slim

WORKDIR /app

# Install dependencies first (cached layer)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source
COPY src/ ./src/

# Pre-bake the static catalog so discovery is instant on startup
COPY src/static_catalog.json ./src/static_catalog.json

# stdio transport — no ports needed
# All config via environment variables:
#   GDP_HOST, GDP_PORT, GDP_CLIENT_ID, GDP_CLIENT_SECRET,
#   GDP_USERNAME, GDP_PASSWORD, GDP_VERIFY_SSL,
#   GDP_DISCOVERY_TIMEOUT (default 0 = skip live discovery, use static catalog)
#   GDP_CLI_PASS, GDP_CLI_HOST, GDP_CLI_PORT, GDP_CLI_USER (optional, for Guard CLI)

ENV GDP_DISCOVERY_TIMEOUT=0

ENTRYPOINT ["python", "-m", "src"]
