#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /rails_docker/tmp/pids/server.pid

echo "run db:migrate"
bin/rails db:migrate

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
