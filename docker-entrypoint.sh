#!/bin/bash
set -e

echo "*** Environment Variables ***"
# source /app/.envrc

echo "*** Installing & Compiling Dependencies ***"
mix deps.get
mix deps.compile
mix compile

echo "*** Setting up DB ***"
mix ecto.create || true
echo "*** Migrating DB ***"
mix ecto.migrate
echo "*** Running seeds ***"
mix run skeleton_key/priv/repo/seeds.exs || true

echo "*** Starting Phoenix ***"
exec mix phx.server
