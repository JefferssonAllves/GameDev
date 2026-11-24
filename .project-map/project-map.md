# Project Map

<!-- project-map: {"analyzer": "0.3.0", "generated_at": "2026-11-24T01:58:19+00:00", "git_commit": "3a76d6192af471adc2c21ea5cafd294130091a76", "source_fingerprint": "d79366c467c46605cec9873c5347608f7a2333c68f4987c9b50adad276f9860e"} -->
This is a generated navigation index. Validate it before relying on it; read source files before editing. FRESH means the indexed files match, not that every repository file is covered.

## Snapshot

- Analyzer: `0.3.0`
- Generated (UTC): `2026-11-24T01:58:19+00:00`
- Git commit: `3a76d6192af471adc2c21ea5cafd294130091a76`
- Source fingerprint: `d79366c467c46605cec9873c5347608f7a2333c68f4987c9b50adad276f9860e`
- Indexed files: `18`
- Declared project versions: `none detected`
- Source hashes and analysis cache: `.project-map/project-map.manifest.json`

## Coverage

- Indexed languages in this map: `javascript: 3`, `python: 1`, `shell: 13`, `typescript: 1`
- Discoverable source types: Python (`.py`, `.pyi`); JavaScript/TypeScript (`.js`, `.jsx`, `.mjs`, `.cjs`, `.ts`, `.tsx`); Shell (`.sh`, `.bash`, `.zsh`, `.fish`, and extensionless shell shebang files); systemd (`.service`, `.socket`, `.timer`, `.target`, `.mount`, `.path`).
- Selected project files: `pyproject.toml`, `setup.py`, `setup.cfg`, `requirements.txt`, `package.json`, `tsconfig.json`, `Cargo.toml`, `manage.py`, `Dockerfile`, `Makefile`, Compose files, `CMakeLists.txt`, Go modules, Maven/Gradle files, and `Procfile`.
- Freshness scope: only files listed in this map and manifest. Unlisted repository files are not validated.
- Parsing scope: Python uses the standard-library AST; JavaScript/TypeScript, Shell, and systemd relationships are conservative and may be incomplete.

## Changes Since Previous Map

- Previous Git commit: `9af8ee82c4fdc7c21185d76a8dcee7a993e7d0c3`
- Current Git commit: `3a76d6192af471adc2c21ea5cafd294130091a76`
- Added: none
- Changed: none
- Removed: none

## Components

- `.agents`: project component; 14 indexed file(s); javascript, python, shell, typescript
- `.githooks`: project component; 4 indexed file(s); shell

## Repository Tree

```text
├── .agents/
│   ├── scripts/
│   │   └── project_map.py [python, 38876 bytes]
│   └── skills/
│       ├── brainstorming/
│       │   └── scripts/
│       │       ├── helper.js [javascript, 5615 bytes]
│       │       ├── server.cjs [javascript, 25699 bytes]
│       │       ├── start-server.sh [shell, 7315 bytes]
│       │       └── stop-server.sh [shell, 3263 bytes]
│       ├── executing-plans/
│       │   └── scripts/
│       │       ├── task-done [shell, 1900 bytes]
│       │       └── task-start [shell, 1185 bytes]
│       ├── subagent-driven-development/
│       │   └── scripts/
│       │       ├── review-package [shell, 2444 bytes]
│       │       ├── sdd-repo [shell, 2356 bytes]
│       │       ├── sdd-workspace [shell, 4823 bytes]
│       │       └── task-brief [shell, 4769 bytes]
│       ├── systematic-debugging/
│       │   ├── condition-based-waiting-example.ts [typescript, 5054 bytes]
│       │   └── find-polluter.sh [shell, 1986 bytes]
│       └── writing-skills/
│           └── render-graphs.js [javascript, 4968 bytes]
└── .githooks/
    ├── import-godot [shell, 465 bytes]
    ├── post-merge [shell, 85 bytes]
    ├── post-rewrite [shell, 142 bytes]
    └── setup [shell, 374 bytes]
```

## Entry Points

- No conventional entry point detected.

## Module Relationships

- `.agents/skills/executing-plans/scripts/task-done` -> `.agents/skills/subagent-driven-development/scripts/sdd-workspace`
- `.agents/skills/executing-plans/scripts/task-start` -> `.agents/skills/subagent-driven-development/scripts/task-brief`
- `.githooks/post-merge` -> `.githooks/import-godot`
- `.githooks/post-rewrite` -> `.githooks/import-godot`
- `.githooks/setup` -> `.githooks/import-godot`

## Dependency Trees

```text
.agents/skills/executing-plans/scripts/task-done
└── .agents/skills/subagent-driven-development/scripts/sdd-workspace
.agents/skills/executing-plans/scripts/task-start
└── .agents/skills/subagent-driven-development/scripts/task-brief
.githooks/post-merge
└── .githooks/import-godot
.githooks/post-rewrite
└── .githooks/import-godot
.githooks/setup
└── .githooks/import-godot
```

## Change Hotspots

- `.githooks/import-godot`: imported by 3 indexed module(s)
- `.agents/skills/subagent-driven-development/scripts/sdd-workspace`: imported by 1 indexed module(s)
- `.agents/skills/subagent-driven-development/scripts/task-brief`: imported by 1 indexed module(s)

## Symbols

### `.agents/scripts/project_map.py`
- `class Symbol` (L57-L63)
- `class FileInfo` (L67-L74)
- `function symbol_to_record` (L77-L85)
- `function symbol_from_record` (L88-L109)
- `function file_to_record` (L112-L120)
- `function file_from_record` (L123-L153)
- `function run_git` (L156-L167)
- `function git_files` (L170-L176)
- `function discover_files` (L179-L201)
- `function read_text` (L204-L205)
- `function is_shell_script` (L208-L218)
- `function digest` (L221-L226)
- `function source_fingerprint` (L229-L236)
- `function project_versions` (L239-L269): Read declared project versions without importing project code.
- `function clean_doc` (L272-L275)
- `function python_symbols` (L278-L295)
- `function python_imports` (L298-L309)
- `function line_for` (L321-L322)
- `function javascript_data` (L325-L339)
- `function shell_tokens` (L354-L358)
- `function looks_like_local_reference` (L361-L370)
- `function shell_data` (L373-L397)
- `function systemd_data` (L400-L433)
- `function analyze_file` (L436-L458)
- `function git_commit` (L461-L462)
- `function git_change_candidates` (L465-L490): Return paths Git says may differ, including working tree changes.
- `function rel_import` (L493-L550)
- `function render_symbol` (L553-L564)
- `function tree_lines` (L567-L592)
- `function component_lines` (L595-L611)
- `function dependency_trees` (L614-L659)
- `function hotspot_lines` (L662-L670)
- `function display_path` (L673-L677)
- `function build_map` (L680-L809)
- `function manifest_for` (L812-L822)
- `function output_paths` (L825-L828)
- `function write_outputs` (L831-L845)
- `function generate` (L848-L864)
- `function load_manifest` (L867-L872)
- `function update` (L875-L946)
- `function parse_map_meta` (L949-L958)
- `function validate` (L961-L1017)
- `function main` (L1020-L1035)

### `.agents/skills/brainstorming/scripts/helper.js`
- `function nextReconnectDelay` (L7)
- `function sessionKey` (L24)
- `function websocketUrl` (L31)
- `function reloadAfterRecovery` (L36)
- `function setStatus` (L47)
- `function showTombstone` (L62)
- `function connect` (L76)
- `function sendEvent` (L119)

### `.agents/skills/brainstorming/scripts/server.cjs`
- `function computeAcceptKey` (L11)
- `function encodeFrame` (L15)
- `function decodeFrame` (L39)
- `function preferredPort` (L89)
- `function generateToken` (L124)
- `function chmodOwnerOnly` (L127)
- `function initialToken` (L131)
- `function waitingPage` (L160)
- `function bootstrapPage` (L187)
- `function readSuperpowersVersion` (L207)
- `function isTruthyEnv` (L226)
- `function escapeHtmlText` (L233)
- `function brandMarkup` (L241)
- `function renderBranding` (L253)
- `function isFullDocument` (L257)
- `function wrapInFrame` (L262)
- `function getNewestScreen` (L266)
- `function urlHostForHttp` (L279)
- `function companionUrl` (L285)
- `function browserLauncherForPlatform` (L289)
- `function isRegularFileInsideContentDir` (L303)
- `function timingSafeEqualStr` (L320)
- `function parseCookies` (L327)
- `function isAuthorized` (L341)
- `function pathnameOf` (L354)
- `function queryKey` (L359)
- `function securityHeaders` (L365)
- `function isAllowedWebSocketOrigin` (L376)
- `function handleRequest` (L386)
- `function handleUpgrade` (L443)
- `function handleMessage` (L502)
- `function broadcast` (L518)
- `function maybeOpenBrowser` (L530)
- `function touchActivity` (L565)
- `function startServer` (L575)
- `function shutdown` (L615)
- `function ownerAlive` (L633)
- `function onListen` (L662)

### `.agents/skills/brainstorming/scripts/start-server.sh`
- `function is_windows_like_shell` (L81)

### `.agents/skills/brainstorming/scripts/stop-server.sh`
- `function mark_stopped` (L19)
- `function read_expected_server_id` (L25)
- `function command_line_for_pid` (L33)
- `function command_has_server_id` (L42)
- `function is_brainstorm_server` (L65)

### `.agents/skills/subagent-driven-development/scripts/review-package`
- `function fi` (L48)

### `.agents/skills/subagent-driven-development/scripts/sdd-workspace`
- `function owns` (L80)

### `.agents/skills/subagent-driven-development/scripts/task-brief`
- `function intask` (L81)
- `function END` (L82)

### `.agents/skills/systematic-debugging/condition-based-waiting-example.ts`
- `function waitForEvent` (L20)
- `function waitForEventCount` (L60)
- `function waitForEventMatch` (L111)

### `.agents/skills/writing-skills/render-graphs.js`
- `function extractDotBlocks` (L19)
- `function extractGraphBody` (L37)
- `function combineGraphs` (L50)
- `function renderToSvg` (L69)
- `function main` (L83)

## Change Guide

1. Run `project_map.py check .` after changing branches or before structural edits.
2. Use the tree and relationships to find candidate modules, then read those files directly.
3. Run `project_map.py update .` after source changes to reuse unchanged analysis.
4. Treat a stale or unknown snapshot as untrusted.

