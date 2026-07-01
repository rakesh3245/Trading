# Trading

## TradingView MCP setup

This repo is configured to use [tradingview-mcp](https://github.com/tradesdontlie/tradingview-mcp), an MCP server that bridges Claude Code with a locally running TradingView Desktop app (via Chrome DevTools Protocol) for chart analysis, Pine Script development, and workflow automation.

### Prerequisites

- TradingView Desktop app with a paid subscription
- Node.js 18+
- Claude Code with MCP support
- macOS, Windows, or Linux (all data stays local — nothing is sent to TradingView's servers)

### Setup

1. Clone the server and install its dependencies:

   ```bash
   ./scripts/setup-tradingview-mcp.sh
   ```

   This clones `tradesdontlie/tradingview-mcp` into `mcp-servers/tradingview-mcp` and runs `npm install`. This repo's `.mcp.json` already points Claude Code at `mcp-servers/tradingview-mcp/src/server.js`, so no manual config is needed once the clone exists.

2. Launch TradingView Desktop with the remote debugging port open (9222):

   ```bash
   ./mcp-servers/tradingview-mcp/scripts/launch_tv_debug_mac.sh     # macOS
   ./mcp-servers/tradingview-mcp/scripts/launch_tv_debug_linux.sh   # Linux
   mcp-servers\tradingview-mcp\scripts\launch_tv_debug.bat          # Windows
   ```

   Or launch manually with `--remote-debugging-port=9222`.

3. Start Claude Code from this repo's root — it auto-loads `.mcp.json` and starts the `tradingview` MCP server.

4. Verify the connection by asking Claude to run `tv_health_check`.

### Notes

- `mcp-servers/tradingview-mcp` is gitignored (it's a third-party clone, not vendored source) — run the setup script again after pulling this repo on a new machine.
- The tool talks to TradingView exclusively over `localhost:9222`; no external network calls are made.
