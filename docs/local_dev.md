# Brain Local Dev

Modo local para correr el Brain sin tocar `/data/clawbrain` ni `/srv/projects` del host.

## Que crea

- Datos persistentes: `./.local/data`
- Repo demo: `./.local/projects/demo`
- Token local: `./.local/data/secrets/api_token`
- API local: `http://127.0.0.1:18088`

## Levantar

```bash
cd /srv/clawbrain/clawbrain-brain
./scripts/local_up.sh
```

## Verificar

```bash
./scripts/verify_brain_local.sh
```

## Bajar

```bash
./scripts/local_down.sh
```

## Notas de codex tasks

- Esta variante usa `runner/Dockerfile.local` e instala `@openai/codex` dentro del runner.
- Si quieres ejecutar tareas `type=codex`, exporta `OPENAI_API_KEY` antes de `local_up.sh`.
- Sin credenciales, los tasks `type=codex` pueden terminar en `failed/blocked` segun el error del CLI.

## MCP local

Para `scripts/clawbrain-mcp-server-auto`, usa:

```bash
export CLAWBRAIN_MCP_ENV_FILE=/srv/clawbrain/clawbrain-brain/.env.mcp.local
```

Contenido sugerido de `.env.mcp.local`:

```bash
CLAWBRAIN_IDE_SERVER_URL=http://127.0.0.1:18088
CLAWBRAIN_IDE_TOKEN_FILE=/srv/clawbrain/clawbrain-brain/.local/data/secrets/api_token
```
