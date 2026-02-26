# Uso en Chat Codex (VS Code/Cursor) por MCP

## Estado real

Si, esta implementado y usable por MCP stdio.

Componentes:
- Server MCP: `scripts/clawbrain-mcp-server`
- Implementacion MCP: `ide_client/mcp_server.py`
- Tools expuestas:
  - `clawbrain.create_task`
  - `clawbrain.get_task`
  - `clawbrain.get_logs`
  - `clawbrain.get_diff`
  - `clawbrain.list_agents`
  - `clawbrain.apply_patch_local`
  - tools PM (`clawbrain.pm_*`)

## Variables requeridas

```bash
export CLAWBRAIN_IDE_SERVER_URL="http://127.0.0.1:8088"
export CLAWBRAIN_IDE_TOKEN="<token>"
```

## Configuracion MCP en IDE

Ejemplo generico (ajustar al formato exacto del cliente):

```json
{
  "mcpServers": {
    "clawbrain": {
      "command": "/srv/clawbrain/clawbrain-brain/scripts/clawbrain-mcp-server",
      "env": {
        "CLAWBRAIN_IDE_SERVER_URL": "http://127.0.0.1:8088",
        "CLAWBRAIN_IDE_TOKEN": "<token>"
      }
    }
  }
}
```

## Flujo de uso en chat

1. Pides al chat crear task en ClawBrain.
2. El chat usa `clawbrain.create_task`.
3. Esperas estado con `clawbrain.get_task`.
4. Revisas logs/diff con `clawbrain.get_logs` y `clawbrain.get_diff`.
5. Aplicas patch local con `clawbrain.apply_patch_local` (confirmado).

## Validacion tecnica

Puedes verificar el MCP server con un harness local:
- `scripts/verify_mcp_server.sh` en el repo origen completo.
- En este repo Brain-only, valida al menos arranque del servidor:

```bash
CLAWBRAIN_IDE_SERVER_URL=http://127.0.0.1:8088 \
CLAWBRAIN_IDE_TOKEN=<token> \
python3 -m ide_client.mcp_server
```

