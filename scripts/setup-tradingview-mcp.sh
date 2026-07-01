#!/usr/bin/env bash
# Clones tradesdontlie/tradingview-mcp into mcp-servers/tradingview-mcp and installs
# its dependencies, so it can be launched via this repo's .mcp.json config.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_DIR="$REPO_ROOT/mcp-servers/tradingview-mcp"

if [ -d "$TARGET_DIR/.git" ]; then
  echo "tradingview-mcp already cloned at $TARGET_DIR, pulling latest..."
  git -C "$TARGET_DIR" pull
else
  echo "Cloning tradesdontlie/tradingview-mcp into $TARGET_DIR..."
  git clone https://github.com/tradesdontlie/tradingview-mcp.git "$TARGET_DIR"
fi

echo "Installing dependencies..."
(cd "$TARGET_DIR" && npm install)

echo "Done. Next steps:"
echo "  1. Launch TradingView Desktop with remote debugging enabled:"
echo "     macOS:   $TARGET_DIR/scripts/launch_tv_debug_mac.sh"
echo "     Linux:   $TARGET_DIR/scripts/launch_tv_debug_linux.sh"
echo "     Windows: $TARGET_DIR\\scripts\\launch_tv_debug.bat"
echo "  2. Start Claude Code in this repo - it will pick up .mcp.json automatically."
echo "  3. Ask Claude to run tv_health_check to verify the connection."
