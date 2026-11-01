# Context Directive Records

Context Directive Records tracking approved contributions to team-ai-directives.

> **Memory Engineering**: This index tracks directive freshness. Run `/levelup.validate` to update verification timestamps.

## CDR Index

| ID | Target Module | Type | Status | Created | Verified | Age | Descriptor |
|----|---------------|------|--------|---------|----------|-----|------------|
| CDR-CONST-001 | `context_modules/constitution.md` | Constitution Amendment | Accepted | 2026-11-01 | 2026-11-01 | 0d | Team Constitution v1.1.0: single choke points, boundary fail-loud validation, human oversight reinforcement |
| CDR-001 | `context_modules/rules/framework/python_startup_validation.md` | Rule | Accepted | 2026-11-01 | 2026-11-01 | 0d | Startup validation for static configuration, schemas, and fixtures with dedicated domain exceptions |
| CDR-002 | `context_modules/rules/framework/python_report_projection_parity.md` | Rule | Accepted | 2026-11-01 | 2026-11-01 | 0d | Single canonical report projection with automated parity across HTML, Markdown, and JSON export formats |
| CDR-003 | `context_modules/rules/framework/python_human_review_gate.md` | Rule | Accepted | 2026-11-01 | 2026-11-01 | 0d | Idempotent human-in-the-loop review gate with atomic first-write-wins and HTTP status contract |
| CDR-004 | `context_modules/rules/framework/python_sse_live_progress.md` | Rule | Accepted | 2026-11-01 | 2026-11-01 | 0d | Server-Sent Events streaming contract with multi-line HTML fragments, keep-alives, and reconnect snapshots |
| CDR-005 | `context_modules/rules/testing/python_async_asgi_test_harness.md` | Rule | Accepted | 2026-11-01 | 2026-11-01 | 0d | Fast async ASGI test harness using app factories, in-memory transport, time-compressed fixtures, and deadline polling |
| CDR-006 | `context_modules/rules/framework/python_llm_access_boundary.md` | Rule | Accepted | 2026-11-01 | 2026-11-01 | 0d | Single LLM access factory choke point with abstract model tiers, early credential checks, and centralized tracing |
| CDR-007 | `context_modules/rules/devops/python_zero_cost_credential_check.md` | Rule | Accepted | 2026-11-01 | 2026-11-01 | 0d | Preflight credential verification using zero-credit API endpoints and single minimal LLM smoke call |
| CDR-008 | `context_modules/examples/python/async_asgi_test_harness.md` | Example | Accepted | 2026-11-01 | 2026-11-01 | 0d | Working code example for async ASGI test harness pairing with CDR-005 testing rule |
| CDR-INC-001 | `context_modules/rules/style-guides/python/pep8_and_docstrings.md` | Rule (Style Guide Amendment) | Accepted | 2026-11-01 | 2026-11-01 | 0d | Standardisation on enum.StrEnum for typed string constants in Python 3.12+ codebases |
| CDR-INC-002 | `context_modules/rules/testing/ui_assertion_strategy.md` | Rule | Accepted | 2026-11-01 | 2026-11-01 | 0d | UI test assertion strategy mandating semantic contracts and forbidding brittle CSS property literals |

**Stats**: 11 CDRs | Last Updated: 2026-11-01

---

## CDR-CONST-001: Constitution Amendment — Boundary Discipline and Single Choke Points

### Status

**Accepted**

### Dates

- **Created**: 2026-11-01
- **Modified**: 2026-11-01
- **Verified**: 2026-11-01
- **Age**: 0 days

### Source

tech-pioneer

### Target Module

`context_modules/constitution.md`

### Context Type

Constitution Amendment

### Descriptor

Team Constitution v1.1.0: single choke points, boundary fail-loud validation, human oversight reinforcement

### Signal Gate

✓ Team-wide applicable | ✓ High value | ✓ Unique | ✓ Concrete evidence

### Context

**Discovery Evidence:**

- Three sub-systems independently route a cross-cutting concern through exactly one module: report rendering (`gui/reports.py`), run lifecycle (`gui/runner.py`), LLM access (`pioneer_pipeline/llm.py`), tracing (`pioneer_pipeline/observability.py`), store ownership (`gui/store.py`), and verification (`scripts/verify_setup.py`).
- Every sub-system also refuses to continue on invalid input: fixtures fail at app construction, a missing API key raises before any request, and the verification script exits non-zero when any check fails.

**Problem Statement:**

The team constitution states *what* good systems do (observability, security, tests) but not *how* to structure the boundaries where those qualities are enforced. Agents therefore re-invent access layers and validation points per project, which is how credential leaks, dual render paths, and silent partial successes appear.

**Forces:**

- Reuse: a rule that names the structural pattern is portable across languages.
- Simplicity: one more abstraction must earn its keep; the evidence shows it prevents real defects.
- Enforcement: principles must be checkable in review, not aspirational.

### Decision

Append a new section to the team constitution with two derived principles and one reinforcement note. Do not rewrite existing principles; preserve all 14.

**Proposed Content:**

```markdown

### Evidence

- `pioneer_pipeline/llm.py:15-28`, `pioneer_pipeline/observability.py:14-21`
- `gui/app.py:42-47`, `gui/reports.py:16-23`, `gui/app.py:214-220`, `gui/fixtures.py:76-194`
- `scripts/verify_setup.py:132-151`
- Commit `07a985d` (pioneer_pipeline, scripts); `gui/` currently untracked in the working tree.

### Feature Implementation Evidence

**Feature**: `002-mocked-eval-gui` — Mocked Evaluation GUI
**Branch**: `module-2-start` (feature artifacts in `specs/002-mocked-eval-gui/`)
**Added**: 2026-11-01

**Spec References**:
- FR-013: "System MUST keep all run state in memory only … no database, no auth, and no real pipeline/LLM calls."
- Brief constraint: "do not modify `pioneer_pipeline/config.py`, `llm.py`, `observability.py`" and "no importing/calling `pioneer_pipeline.llm` or LiteLLM; no LangFuse in GUI."

**Implementation Evidence**:
- Both cross-cutting principles are directly load-bearing in this feature: `gui/reports.py` is the only report producer, `gui/runner.py` the only owner of per-run tasks, `gui/store.py` the only run store.
- The feature's hard boundary (GUI may not import the LLM module) is the strongest single data point for "single choke point per external concern": a sub-system was successfully forbidden from bypassing another sub-system's boundary.
- Fail-loud behaviour: `create_app` validates fixtures before serving (`gui/app.py:42-47`); non-exportable runs return 404 for exports (`gui/app.py:214-220`).
- Tasks: T006, T016, T026, T035.

**Commit Evidence**:
- `07a985d` covers `pioneer_pipeline/` and `scripts/` only. `gui/` is untracked in the working tree — commit once the feature branch is finalised so this evidence is durable.

**Validation**:
- [x] Pattern implemented successfully
- [x] Tests pass (`uv run pytest -q` → 70 passed in 3.91s)
- [x] Boundary audited (T035: no `llm`/`langfuse` imports in `gui/`)
- [ ] Amendment ratified by the team

---

## CDR-001: Validate Static Configuration at Startup

### Status

**Accepted**

### Dates

- **Created**: 2026-11-01
- **Modified**: 2026-11-01
- **Verified**: 2026-11-01
- **Age**: 0 days

### Source

tech-pioneer

### Target Module

`context_modules/rules/framework/python_startup_validation.md`

### Context Type

Rule

### Descriptor

Startup validation for static configuration, schemas, and fixtures with dedicated domain exceptions

### Signal Gate

✓ Team-wide applicable | ✓ High value | ✓ Unique | ✓ Concrete evidence

### Context

**Discovery Evidence:**

- `gui/fixtures.py` validates every field with explicit type checks, rejects `bool` where numbers are expected (`isinstance(x, bool)` guards at lines 105, 115, 139), enforces the five-stage order, requires scenario-specific blocks, rejects stray blocks, and checks filename/field agreement.
- `create_app` calls `load_all()` before constructing routes, so malformed fixtures fail at import/startup rather than mid-run.
- `scripts/verify_setup.py` accumulates check results and exits non-zero when any fail.

**Problem Statement:**

Agents commonly write `data["key"]` deep inside request handlers or startup paths and let `KeyError`/`TypeError` surface later. There is no team rule saying that static config must be validated wholly, once, at the boundary, with a dedicated error type.

**Forces:**

- UX: a demo that half-works is worse than one that refuses to start.
- Testability: a pure `parse_*` function is trivially unit-testable; scattered access is not.
- Cost: validation code is boring and gets skipped under time pressure.

### Decision

Add a framework rule requiring total, explicit validation of static configuration at startup, with a dedicated exception and actionable messages.

**Proposed Content:**

- Load every required static artifact (fixtures, YAML config, seed data) before the application begins serving.
- Validate the whole artifact in one pure function; return a typed object, never a raw `dict`.
- Checks MUST include: presence, type (booleans are not numbers), allowed values, ordering, cross-field invariants, and file-name/identifier agreement.
- Raise a dedicated exception type (e.g. `FixtureError(ValueError)`) carrying file + field + expected value.
- Do not validate lazily on first request; do not silently default a missing required field.
- Keep the validator pure so it can be called from tests without starting the app.

### Evidence

- `gui/fixtures.py:63-65` (`_require`), `76-194` (`parse_scenario`), `197-222` (`load_scenario`/`load_all`)
- `gui/app.py:42-47` (startup validation)
- `gui/tests/test_fixtures.py` (20+ negative cases: duration, stage name/order/count, missing report fields, bare/empty flag, stray flag/failure, unknown scenario, invalid JSON, missing file, filename mismatch)
- Commit `07a985d` covers the pipeline-side precedent; `gui/` is untracked in the working tree.

### Feature Implementation Evidence

**Feature**: `002-mocked-eval-gui` — Mocked Evaluation GUI
**Branch**: `module-2-start`
**Added**: 2026-11-01

**Spec References**:
- FR-011: "System MUST validate empty/missing name or description with inline errors and create no run."
- `data-model.md` (fixture schema): "Schema validated at startup + in `test_fixtures.py` (unknown stage names, negative durations, missing report block → loud startup error, never silent)."
- Edge case: "What happens when the failure scenario triggers mid-run? (Run stops at the failing stage … no partial report presented as final.)"

**Implementation Evidence**:
- `gui/fixtures.py:76-194` — total schema validation: five-stage order, positive numeric durations, scenario-specific `flag`/`failure` blocks, filename/field agreement, unknown keys preserved as `extras`.
- `gui/app.py:42-47` — `load_all()` runs inside `create_app`, so bad fixtures fail at startup, not mid-run.
- Tasks: T006 (fixture loader + schema validation), T007 (author three fixtures), T010 (schema unit tests).

**Commit Evidence**:
- None for `gui/` (untracked). The pipeline-side precedent is in `07a985d`.

**Validation**:
- [x] Pattern implemented successfully
- [x] Tests pass (`gui/tests/test_fixtures.py`: 20+ negative cases, all green)
- [x] Startup failure demonstrated by the invalid-JSON and missing-file tests

---

## CDR-002: One Report Projection, Many Renderings (Export Parity)

### Status

**Accepted**

### Dates

- **Created**: 2026-11-01
- **Modified**: 2026-11-01
- **Verified**: 2026-11-01
- **Age**: 0 days

### Source

tech-pioneer

### Target Module

`context_modules/rules/framework/python_report_projection_parity.md`

### Context Type

Rule

### Descriptor

Single canonical report projection with automated parity across HTML, Markdown, and JSON export formats

### Signal Gate

✓ Team-wide applicable | ✓ High value | ✓ Unique | ✓ Concrete evidence

### Context

**Discovery Evidence:**

- `gui/reports.py` opens with an explicit invariant: "the HTML page, the Markdown download, and the JSON download all render from the same mapping, so the three representations cannot drift apart."
- `build_report` is the only producer; `to_markdown` / `to_json` are pure functions over its output; the template receives the same mapping.
- `_verdict` overrides source metadata for terminal states so a rejected run never reads as a pass.
- `test_reports.py` asserts JSON round-trips to the projection, Markdown and HTML contain the same fields, stage order matches, rejected verdict/note appear in all three, failures omit scores, and Markdown escapes `|`.

**Problem Statement:**

Multi-format exports are usually implemented as parallel walkers over the domain object, which drift the moment one renderer adds a field or applies a different rule. There is no team directive requiring a single projection or parity tests.

**Forces:**

- Correctness: three outputs that disagree erode trust faster than one missing output.
- Effort: a projection layer is ~20 extra lines.
- Format quirks: escaping differs per format (Markdown pipes, HTML escaping, JSON numbers).

### Decision

Add a rule: derive every human- and machine-readable view from one canonical projection function, and test parity across formats.

**Proposed Content:**

- Define exactly one `build_*` projection from the domain object to a plain mapping. It MUST be pure.
- Every renderer (HTML template, Markdown, JSON, CSV) consumes only that mapping; renderers MUST NOT read the domain object directly.
- Terminal domain state overrides stale source metadata inside the projection (e.g. a rejected run renders `rejected`, never the fixture's `pass`).
- Normalise absent values in the projection (e.g. `None` → `null` in JSON, `—` in Markdown), not in each renderer.
- Apply format-specific escaping in the renderer (Markdown table pipes, HTML autoescape).
- Add one parity test per export format asserting the same field set and the same domain-override behaviour; round-trip JSON and compare to the projection.

### Evidence

- `gui/reports.py:1-6` (invariant docstring), `16-23` (`_verdict` override), `26-58` (`build_report`), `67-112` (`to_markdown`), `115-118` (`to_json`)
- `gui/templates/partials/report.html` (renders `report`, not `run`)
- `gui/tests/test_reports.py:49-132` (parity suite)
- `gui/app.py:222-244` (both download routes call `build_report`)

### Feature Implementation Evidence

**Feature**: `002-mocked-eval-gui` — Mocked Evaluation GUI
**Branch**: `module-2-start`
**Added**: 2026-11-01

**Spec References**:
- FR-008: "System MUST provide Markdown and JSON report downloads whose content matches the displayed report."
- SC-004: "Exported Markdown and JSON reports match the on-screen report content on every completed run (scores, verdict, review outcome)."
- `research.md` Decision 4: "Separate per-format builders — rejected (parity bugs guaranteed)."

**Implementation Evidence**:
- `gui/reports.py:26-58` — `build_report` is the sole projection; `16-23` — `_verdict` forces `rejected`/`error` for terminal states.
- `gui/templates/partials/report.html` renders `report`, never `run`.
- `gui/app.py:222-244` — both downloads call `build_report`; terminal gate via `exportable_run`.
- Tasks: T024 (parity tests), T026 (reports module), T027 (report section), T028 (export routes).

**Commit Evidence**:
- None for `gui/` (untracked).

**Validation**:
- [x] Pattern implemented successfully
- [x] Tests pass (`gui/tests/test_reports.py`, `test_export_downloads_match_report_and_run`)
- [x] Rejection override verified (`test_rejected_run_verdict_and_note_match_everywhere`)

---

## CDR-003: Idempotent Human Review Gate

### Status

**Accepted**

### Dates

- **Created**: 2026-11-01
- **Modified**: 2026-11-01
- **Verified**: 2026-11-01
- **Age**: 0 days

### Source

tech-pioneer

### Target Module

`context_modules/rules/framework/python_human_review_gate.md`

### Context Type

Rule

### Descriptor

Idempotent human-in-the-loop review gate with atomic first-write-wins and HTTP status contract

### Signal Gate

✓ Team-wide applicable | ✓ High value | ✓ Unique | ✓ Concrete evidence

### Context

**Discovery Evidence:**

- `record_review` returns `False` when a decision already exists, so duplicate submissions are idempotent rather than overwriting the original judgment.
- `submit_review` returns 409 when the run is not awaiting review, 422 for invalid decisions/over-long notes, and 200 (no mutation) for a duplicate after the run reached a terminal state.
- The runner waits on `review_signal` rather than polling, and has a defensive branch that fails the run loudly if the signal fires without a recorded decision.
- Tests cover: pause holds with no autonomous progress, approve resumes and completes, reject terminates, first decision wins, duplicate after terminal is a no-op.

**Problem Statement:**

Human-in-the-loop gates are often coded as a mutable flag guarded by "if approved" checks. Double-clicks, back-button resubmissions, or two reviewers race and the last write wins, which means the recorded decision may not be the one the reviewer made. No team rule exists for the mechanics.

**Forces:**

- Accountability: the recorded decision is the audit artifact; it must be the first, deliberate one.
- UX: duplicates should look successful, not error.
- Determinism: the worker must not poll or time out into auto-approval.

### Decision

Add a framework rule for idempotent, state-guarded human decision gates.

**Proposed Content:**

- Model the gate as (a) an explicit `AWAITING_*` lifecycle state and (b) a one-shot signal the worker waits on.
- Record-decision MUST be first-write-wins: if a decision exists, return `False` and leave the stored decision untouched.
- Classify responses explicitly: wrong lifecycle state → `409`, invalid decision/over-long note → `422`, duplicate after terminal → `200` with no mutation, accepted decision → `303` redirect.
- Validate the decision against a closed set (enum/frozenset) before recording; trim free-text and cap its length.
- The worker MUST `await` the signal; no polling, no timeout, no auto-approval on abandonment.
- If the signal fires with no recorded decision, fail the operation loudly instead of guessing.
- Tests MUST cover: pause holds, approve resumes, reject terminates, first decision wins, duplicate is a no-op.

### Evidence

- `gui/runner.py:121-134` (`record_review`), `86-110` (pause/resume/reject/defensive branch)
- `gui/app.py:170-212` (`submit_review` response matrix), `181-183` (duplicate no-op)
- `gui/models.py:56-58` (`VALID_DECISIONS`), `41-54` (lifecycle + terminal sets)
- `gui/tests/test_runner.py:56-124`, `gui/tests/test_routes.py:242-337`

### Feature Implementation Evidence

**Feature**: `002-mocked-eval-gui` — Mocked Evaluation GUI
**Branch**: `module-2-start`
**Added**: 2026-11-01

**Spec References**:
- FR-005: "System MUST require an explicit Approve or Reject decision … the run MUST NOT complete without it."
- SC-003: "100% of flagged runs require and record an explicit Approve/Reject decision before completing — zero bypasses."
- Edge case: "How does the system handle a review submitted twice …? (Second submission is ignored; single recorded decision wins.)"
- `research.md` Decision 2: "Double review POSTs are idempotent (first decision wins, second returns current state)."

**Implementation Evidence**:
- `gui/runner.py:121-134` — `record_review` returns `False` when a decision exists; first write wins.
- `gui/app.py:170-212` — 409 non-awaiting, 422 invalid/long, 200 duplicate no-op, 303 accepted.
- `gui/runner.py:86-110` — waits on `review_signal`, fails loudly if the signal arrives without a decision.
- Tasks: T008 (ticker + idempotent resume), T019 (review contract tests), T020 (pause/resume/idempotency tests), T021 (review route), T023 (review event wiring).

**Commit Evidence**:
- None for `gui/` (untracked).

**Validation**:
- [x] Pattern implemented successfully
- [x] Tests pass (`test_first_review_decision_wins`, `test_duplicate_review_after_terminal_is_noop`, `test_review_on_running_run_conflicts`)
- [x] Zero-bypass criterion (SC-003) covered by tests

---

## CDR-004: SSE Contract for Long-Running Operations

### Status

**Accepted**

### Dates

- **Created**: 2026-11-01
- **Modified**: 2026-11-01
- **Verified**: 2026-11-01
- **Age**: 0 days

### Source

tech-pioneer

### Target Module

`context_modules/rules/framework/python_sse_live_progress.md`

### Context Type

Rule

### Descriptor

Server-Sent Events streaming contract with multi-line HTML fragments, keep-alives, and reconnect snapshots

### Signal Gate

✓ Team-wide applicable | ✓ High value | ✓ Unique | ✓ Concrete evidence

### Context

**Discovery Evidence:**

- `_sse_frame` prefixes every line of a multi-line HTML fragment with `data: ` and emits `event: <kind>`.
- The stream sends `: keep-alive` every 15 seconds when idle (`asyncio.wait_for` timeout), so proxies do not drop the connection.
- `_snapshot_event` means a client connecting after completion receives exactly one closing frame and the stream ends; without it, reconnect would hang on keep-alives.
- The stream returns after `done`/`failed`, so browser reconnects do not accumulate open streams.
- The client uses htmx `sse-connect` + four `sse-swap` targets (stage/review/done/failed).

**Problem Statement:**

SSE is easy to demo and easy to get subtly wrong: multi-line payloads break framing, idle connections get dropped, reconnects hang, and completed streams never close. There is no team rule capturing the contract.

**Forces:**

- Simplicity: no WebSocket infrastructure needed for one-way progress.
- Durability: proxies and browsers will drop idle connections.
- UX: refresh/reconnect must not duplicate or hang.

### Decision

Add a framework rule describing the minimum correct SSE contract for server-rendered progress.

**Proposed Content:**

- One stream endpoint per operation (`GET /runs/{id}/events`), `media_type="text/event-stream"`, `Cache-Control: no-cache`.
- Every frame is a complete HTML fragment for a named swap target: `event: <kind>\ndata: <fragment>\n\n`.
- For multi-line fragments, prefix **every** line with `data: `.
- Emit a `: keep-alive` comment at a fixed interval (≤15s) when idle.
- On connect to an already-terminal operation, emit exactly one closing frame and end the stream.
- End the generator after the terminal event; do not leave completed streams open.
- Keep event kinds in a shared module; the web layer owns rendering, the worker owns emission.
- Test: stage + terminal frames arrive, reconnect-after-terminal yields exactly one frame, multi-line payloads survive framing.

### Evidence

- `gui/app.py:35-39` (`_sse_frame`), `139-168` (stream + keep-alive + close), `249-258` (`_snapshot_event`), `30` (`KEEPALIVE_SECONDS`)
- `gui/runner.py:23-27` (event kinds), `64-66` (`_emit`)
- `gui/templates/run.html:14-35` (htmx wiring)
- `gui/tests/test_routes.py:195-222, 412-422` (stream + reconnect tests)

### Feature Implementation Evidence

**Feature**: `002-mocked-eval-gui` — Mocked Evaluation GUI
**Branch**: `module-2-start`
**Added**: 2026-11-01

**Spec References**:
- FR-002: live progress through five fixed stages with per-stage status.
- Brief rule 2: "SSE stream (`GET /runs/{id}/events` as `text/event-stream`) driving an HTMX-updated stage list."
- `research.md` Decision 1: "each event carries a rendered `partials/stages.html` HTML fragment plus a terminal `event: done`/`review`/`failed`."
- Contracts: "`: keep-alive` comments every ~15s; stream closes after terminal event."

**Implementation Evidence**:
- `gui/app.py:35-39` (`_sse_frame` multi-line `data:` prefixing), `139-168` (queue wait, 15s keep-alive, terminal close), `249-258` (reconnect snapshot).
- `gui/templates/run.html:14-35` — one `sse-connect` and four `sse-swap` targets.
- Tasks: T016 (SSE stream), T017 (stages fragment), T023 (review event), T031 (refresh re-attach).

**Commit Evidence**:
- None for `gui/` (untracked).

**Validation**:
- [x] Pattern implemented successfully
- [x] Tests pass (`test_sse_stream_emits_stage_and_done_frames`, reconnect-after-terminal and reconnect-after-failure tests)
- [x] Refresh mid-run re-attaches without duplicate report (T031)

---

## CDR-005: Async ASGI Test Harness with Time Compression

### Status

**Accepted**

### Dates

- **Created**: 2026-11-01
- **Modified**: 2026-11-01
- **Verified**: 2026-11-01
- **Age**: 0 days

### Source

tech-pioneer

### Target Module

`context_modules/rules/testing/python_async_asgi_test_harness.md`

### Context Type

Rule

### Descriptor

Fast async ASGI test harness using app factories, in-memory transport, time-compressed fixtures, and deadline polling

### Signal Gate

✓ Team-wide applicable | ✓ High value | ✓ Unique | ✓ Concrete evidence

### Context

**Discovery Evidence:**

- Production fixtures use human-scale durations (≥1s per stage) so the demo feels real. Tests clone them and rewrite `duration_s` to 0.02s (0.005–0.4s for specific scenarios), keeping the suite at ~4s for 70 tests.
- `make_client` constructs the app per test through the factory, wraps `httpx.ASGITransport`, and guarantees `runner.cancel_all()` in `finally`.
- `wait_for` polls a predicate with a monotonic deadline and fails with a message instead of sleeping a fixed time.
- `anyio_backend` fixture pins `asyncio`; `pytestmark = pytest.mark.anyio` applies to async modules.
- Parametrised validation cases carry explicit `ids` so failures are readable.

**Problem Statement:**

Async web apps are commonly tested with fixed `sleep()` calls and a shared global app, which produces flaky, slow suites and leaks background tasks between tests. Team directives cover pytest generally but not this harness shape.

**Forces:**

- Speed: waiting real durations makes suites unusable.
- Determinism: fixed sleeps are the main source of flake.
- Isolation: background tasks outlive a test unless explicitly cancelled.

### Decision

Add a testing rule for async ASGI apps: factory-built app per test, time-compressed fixtures, deadline polling, and guaranteed task teardown.

**Proposed Content:**

- Build the app per test through its factory; never share module-level app state across tests.
- Drive it with `httpx.AsyncClient(transport=ASGITransport(app))`; no network socket.
- Compress time in test data, not in production code: clone fixtures and rewrite durations to milliseconds.
- Never `await asyncio.sleep(<real duration>)` to wait for a state change; poll a predicate with a monotonic deadline and fail with a diagnostic message.
- Register `anyio_backend = "asyncio"` and mark async modules with `pytest.mark.anyio` (or `pytest-asyncio` equivalent).
- Always tear down background work in a `finally` block (cancel tasks, close clients).
- Give parametrised cases explicit `ids`.
- Keep a small set of slow, realistic-timing tests if timing itself is the behaviour under test; mark them.

### Evidence

- `gui/tests/conftest.py:27-39` (`scaled_fixtures`), `42-52` (`make_client`), `68-81` (`wait_for`), `84-108` (`run_id_from`, `start_run`, `wait_for_status`)
- `gui/tests/test_routes.py:15` (`pytestmark`), `74-92` (parametrised ids)
- `gui/tests/test_runner.py:22-24` (store/runner factory)
- Full suite: 70 tests in 3.91s (`uv run pytest -q`, 2026-11-01)

### Feature Implementation Evidence

**Feature**: `002-mocked-eval-gui` — Mocked Evaluation GUI
**Branch**: `module-2-start`
**Added**: 2026-11-01

**Spec References**:
- `research.md` Decision 6: "Fixture-timing tests use scaled-down durations so the suite stays under ~10s."
- `quickstart.md`: "Expected: all green; runner tests finish in <10s (scaled fixture timing)."
- `plan.md` Testing: "pytest with httpx `ASGITransport` for route/contract tests + fixture-validation unit tests."

**Implementation Evidence**:
- `gui/tests/conftest.py:27-39` (`scaled_fixtures`), `42-52` (`make_client` + guaranteed `cancel_all`), `68-81` (`wait_for` deadline polling).
- Tasks: T012 (runner timing test with scaled fixture), T020 (pause/resume), T024/T025 (parity + export tests), T034 (suite green).
- The harness is the concrete answer to the plan's "runner tests finish in <10s" constraint; the measured suite is ~4s for 70 tests.

**Commit Evidence**:
- None for `gui/` (untracked).

**Validation**:
- [x] Pattern implemented successfully
- [x] Tests pass (`uv run pytest -q` → 70 passed in 3.91s, no network calls)
- [x] Time-compression approach documented in `conftest.py` docstring

---

## CDR-006: Single LLM Access Boundary (Tiers, Credentials, Tracing)

### Status

**Accepted**

### Dates

- **Created**: 2026-11-01
- **Modified**: 2026-11-01
- **Verified**: 2026-11-01
- **Age**: 0 days

### Source

tech-pioneer

### Target Module

`context_modules/rules/framework/python_llm_access_boundary.md`

### Context Type

Rule

### Descriptor

Single LLM access factory choke point with abstract model tiers, early credential checks, and centralized tracing

### Signal Gate

✓ Team-wide applicable | ✓ High value | ✓ Unique | ✓ Concrete evidence

### Context

**Discovery Evidence:**

- `config.py` defines `ModelTier` (CHEAP/BALANCED/PREMIUM) and an env-overridable `DEFAULT_MODELS` map, so agents never hardcode a model name and routing changes in one place.
- `llm.py` is the only module importing `langchain_openai`; it reads `LITELLM_API_KEY`, raises a `RuntimeError` naming the missing variable and where to set it, and reads `LITELLM_PROXY_URL` with a documented default.
- `observability.py` is the only module importing `langfuse`; it re-exports `observe` and the client so the rest of the codebase has one tracing entrypoint.
- The GUI proves the boundary is enforceable: it is explicitly forbidden from importing the LLM module and does not.

**Problem Statement:**

LLM codebases accumulate direct provider SDKs, scattered model strings, and per-module tracing setup. Rotating a key or model then becomes a grep-and-pray exercise, and tracing is missing wherever someone forgot the decorator. No team rule defines the boundary.

**Forces:**

- Security: one place to supply, rotate, and audit credentials.
- Operability: model routing must be changeable without touching agents.
- Observability: tracing must be impossible to forget.

### Decision

Add a framework rule defining a single application-level LLM boundary.

**Proposed Content:**

- Agents and features MUST request a **tier** (`cheap`/`balanced`/`premium`), never a provider or model string.
- Exactly one module constructs the chat client. It owns: credential lookup, base URL, timeout/retry policy, and provider-specific options.
- Credentials are read from the environment and asserted before construction; the error MUST name the variable and how to set it.
- Tier→model mapping is data, overridable by environment variables, with one documented default per tier.
- Exactly one module exports tracing (`observe`, client). Application code imports tracing from there, never from the vendor package.
- No other module may import a provider SDK. Enforce by review checklist (or a lint rule) rather than convention.
- Tests MUST NOT hit a real provider; inject a fake client or patch the factory.

### Evidence

- `pioneer_pipeline/config.py:12-22` (tiers + env-overridable map)
- `pioneer_pipeline/llm.py:1-28` (sole client construction; actionable error)
- `pioneer_pipeline/observability.py:1-21` (sole tracing entrypoint, `__all__`)
- `scripts/verify_setup.py:117-129` (factory used as smoke test)
- Commit `07a985d`.

### Feature Implementation Evidence

**Feature**: `002-mocked-eval-gui` — Mocked Evaluation GUI
**Branch**: `module-2-start`
**Added**: 2026-11-01

**Spec References**:
- FR-013: "no database, no auth, and no real pipeline/LLM calls."
- Brief constraint: "no importing/calling `pioneer_pipeline.llm` or LiteLLM; no LangFuse in GUI."
- `plan.md` Constraints: "never import `pioneer_pipeline.llm`".

**Implementation Evidence**:
- The boundary was treated as an enforceable contract, not a convention: T035 is an explicit grep audit that `gui/` contains no `llm`/`langfuse` imports.
- `pioneer_pipeline/llm.py:15-28` is the only client-construction site; `observability.py:14-21` the only tracing entrypoint; `config.py:12-22` the only tier map.
- `scripts/verify_setup.py:117-129` exercises the factory for the live smoke test rather than building its own client.
- Tasks: T035 (boundary audit).

**Commit Evidence**:
- `07a985d` — `pioneer_pipeline/config.py`, `llm.py`, `observability.py`, `scripts/verify_setup.py`.

**Validation**:
- [x] Pattern implemented successfully
- [x] Boundary respect audited (T035)
- [x] Tests pass without any LLM/network access
- [ ] Tier differentiation untested (all three tiers currently resolve to the same default model)

---

## CDR-007: Zero-Cost Credential Verification

### Status

**Accepted**

### Dates

- **Created**: 2026-11-01
- **Modified**: 2026-11-01
- **Verified**: 2026-11-01
- **Age**: 0 days

### Source

tech-pioneer

### Target Module

`context_modules/rules/devops/python_zero_cost_credential_check.md`

### Context Type

Rule

### Descriptor

Preflight credential verification using zero-credit API endpoints and single minimal LLM smoke call

### Signal Gate

✓ Team-wide applicable | ✓ High value | ✓ Unique | ✓ Concrete evidence

### Context

**Discovery Evidence:**

- `check_tavily_key` calls `https://api.tavily.com/usage`, which validates the key without spending a search credit (docstring states this explicitly).
- `check_github_token` calls `https://api.github.com/rate_limit`, validating the token without consuming quota.
- `check_llm_call` performs one minimal `llm.invoke("Say 'ok'.")` — the only check that spends tokens — and is run last.
- Each check returns `bool`; `main` collects results and calls `sys.exit(1)` if any is false. Output is ✅/❌ per item with remediation text.
- Network errors are caught and reported as failures with the exception message; 10s timeout.

**Problem Statement:**

Onboarding instructions usually say "set these six environment variables". Presence is not validity, and a wrong key is discovered hours later mid-feature. Validating by making a real paid call wastes quota and money. No team rule captures the cheap validation pattern.

**Forces:**

- Cost: validation must not consume meaningful quota.
- Confidence: presence ≠ validity; a live check is worth more.
- Onboarding: failures must name the variable and the fix.

### Decision

Add a devops rule for preflight credential verification: cheap live checks, aggregated result, non-zero exit.

**Proposed Content:**

- Provide one preflight command that verifies every external credential the project needs.
- Prefer endpoints that validate without consuming quota (usage/quota/rate-limit/whoami endpoints); reserve a single minimal real call for the primary provider, run last.
- Each check returns a boolean and prints a ✅/❌ line naming the environment variable and the remediation.
- Never print secret values; print only validity and quota figures.
- Set a short timeout (~10s) and convert network errors into failures with the error message.
- Aggregate results and exit non-zero if any check fails — no partial-success message.
- Never auto-create or mutate credentials as part of the check.

### Evidence

- `scripts/verify_setup.py:75-94` (Tavily usage endpoint), `97-114` (GitHub rate limit endpoint), `117-129` (single live LLM call), `132-151` (aggregation + exit code), `62-72` (10s timeout helper)
- `.env.example` (documents every required variable)
- Commit `07a985d`.

### Feature Implementation Evidence

**Feature**: `002-mocked-eval-gui` — Mocked Evaluation GUI
**Branch**: `module-2-start`
**Added**: 2026-11-01

**Spec References**:
- `quickstart.md` Prerequisites: "Fresh clone; no `.env` / API keys needed (mock makes zero external calls)."
- Brief rule 6: "No-DB / no-auth / no-LLM."

**Implementation Evidence**:
- This feature deliberately needs **no** credentials, so it provides the negative-space evidence: the mock boundary is only trustworthy *because* the verification path in `scripts/verify_setup.py` proves the real integrations separately.
- `scripts/verify_setup.py:75-94` (Tavily `/usage`), `97-114` (GitHub `/rate_limit`), `117-129` (single live LLM call), `132-151` (aggregate + exit code).
- Tasks: T035 (verify no LLM imports in the GUI) is the feature-level complement — it proves the GUI cannot accidentally require credentials.

**Commit Evidence**:
- `07a985d` — `scripts/verify_setup.py`, `.env.example`.

**Validation**:
- [x] Pattern exists and is documented in the repo
- [ ] `make verify` not executed in this session (requires real keys)
- [x] Feature requires zero credentials (verified by T035 and by the suite running with no env vars)

---

## CDR-008: Example — Async ASGI Test Harness (Time-Compressed Fixtures + Predicate Waits)

### Status

**Accepted**

### Dates

- **Created**: 2026-11-01
- **Modified**: 2026-11-01
- **Verified**: 2026-11-01
- **Age**: 0 days

### Source

tech-pioneer

### Target Module

`context_modules/examples/python/async_asgi_test_harness.md`

### Context Type

Example

### Descriptor

Working code example for async ASGI test harness pairing with CDR-005 testing rule

### Signal Gate

✓ Team-wide applicable | ✓ High value | ✓ Unique | ✓ Concrete evidence

### Context

`examples/testing/pytest_class_based.md` is the closest team example, but it does not show app factories, ASGI transports, background-task teardown, or time compression. This example is extracted verbatim (trimmed) from the working `gui/tests` harness, which runs 70 tests in under 4 seconds.

### Decision

Publish a trimmed, working example that pairs with CDR-005.

**Proposed Content:**

- Header explaining when to use it (async FastAPI/Starlette app, fixture-driven timing, background tasks).
- Three sections: time compression, client factory, predicate wait helper.
- A short "what to assert" note pointing to CDR-INC-002 (assert behaviour, not CSS literals).

### Evidence

`gui/tests/conftest.py:27-108`; exercised by `gui/tests/test_routes.py`, `test_runner.py`, `test_reports.py`, `test_fixtures.py`.

### Feature Implementation Evidence

**Feature**: `002-mocked-eval-gui` — Mocked Evaluation GUI
**Branch**: `module-2-start`
**Added**: 2026-11-01

**Spec References**:
- `research.md` Decision 6 (testing strategy: contract-first, three layers, scaled durations).
- `quickstart.md` Tests: "`uv run pytest gui/tests -q` … runner tests finish in <10s".

**Implementation Evidence**:
- Source of the example: `gui/tests/conftest.py:27-108` — verbatim, working harness (time compression, ASGI client factory, predicate wait, run helpers).
- Consumed by `test_routes.py`, `test_runner.py`, `test_reports.py`.
- Tasks: T012, T019–T020, T024–T025, T031, T034.

**Commit Evidence**:
- None for `gui/` (untracked).

**Validation**:
- [x] Example extracted from working code (not written from memory)
- [x] Full suite passes (70 tests, 3.91s)
- [ ] Example not yet reduced to the trimmed publication form

---

## CDR-INC-001: Enum Base Class Divergence

### Status

**Accepted**

### Dates

- **Created**: 2026-11-01
- **Modified**: 2026-11-01
- **Verified**: 2026-11-01
- **Age**: 0 days

### Source

tech-pioneer

### Target Module

`context_modules/rules/style-guides/python/pep8_and_docstrings.md`

### Context Type

Rule (Style Guide Amendment)

### Descriptor

Standardisation on enum.StrEnum for typed string constants in Python 3.12+ codebases

### Signal Gate

✓ Team-wide applicable | ✓ High value | ✓ Unique | ✓ Concrete evidence

### Context

**Inconsistency Detected**: Two enum base-class idioms coexist for the same purpose (typed string constants), in the same repository:

- `gui/models.py` uses `StrEnum` (`StageName`, `StageStatus`, `RunStatus`).
- `pioneer_pipeline/config.py` uses `class ModelTier(str, Enum)`.

Both target Python 3.12 (`requires-python = ">=3.12"`), where `StrEnum` is available.

**Sub-Systems Involved**:

- **gui**: `class StageName(StrEnum)` — `gui/models.py:12`, `31`, `41`.
- **pioneer_pipeline**: `class ModelTier(str, Enum)` — `pioneer_pipeline/config.py:12`.

### Decision

Standardise on one enum idiom for the team's Python 3.12+ codebases.

**Resolution**:
- **Decision**: Standardise on Option A (`StrEnum` everywhere)
- **Rationale**: One idiom, one review rule; explicit typing in name; supported on Python 3.12+
- **Resolved by**: Accepted in `/levelup.clarify`
- **Resolution date**: 2026-11-01
- **Status**: Resolved

#### Implementation Plan

- [x] Ratify the idiom in the Python style guide (via `/levelup.implement`)
- [ ] Migrate `ModelTier` to `StrEnum` in `pioneer_pipeline/config.py`
- [ ] Add a lint/review checklist item
- [x] Mark this CDR Resolved

### Evidence

- `gui/models.py:12, 31, 41`
- `pioneer_pipeline/config.py:12`
- `pyproject.toml:10` (`requires-python = ">=3.12"`)

### Feature Implementation Evidence

**Feature**: `002-mocked-eval-gui` — Mocked Evaluation GUI
**Branch**: `module-2-start`
**Added**: 2026-11-01

**Spec References**:
- `data-model.md` uses closed value sets for `status`, `name`, and `decision`; it does not prescribe an enum base class.
- `plan.md` Targets Python 3.12+, where `StrEnum` is available.

**Implementation Evidence**:
- New code in this feature used `StrEnum` throughout (`gui/models.py:12, 31, 41`), widening the divergence with the pre-existing `ModelTier(str, Enum)` (`pioneer_pipeline/config.py:12`).
- The feature therefore **increased** the cost of leaving the inconsistency unresolved: two idioms now exist in files a single feature touches.

**Commit Evidence**:
- `07a985d` introduced `ModelTier(str, Enum)`; `gui/models.py` is untracked.

**Validation**:
- [x] Both implementations confirmed by reading the files
- [ ] Standardisation decision not made

---

## CDR-INC-002: Test Assertion Strategy — Behaviour vs Presentation Literals

### Status

**Accepted**

### Dates

- **Created**: 2026-11-01
- **Modified**: 2026-11-01
- **Verified**: 2026-11-01
- **Age**: 0 days

### Source

tech-pioneer

### Target Module

`context_modules/rules/testing/ui_assertion_strategy.md`

### Context Type

Rule

### Descriptor

UI test assertion strategy mandating semantic contracts and forbidding brittle CSS property literals

### Signal Gate

✓ Team-wide applicable | ✓ High value | ✓ Unique | ✓ Concrete evidence

### Context

**Inconsistency Detected**: The GUI test suite uses two incompatible assertion styles for the same kind of surface.

- **Behaviour-first** (`test_runner.py`, `test_reports.py`): assert lifecycle transitions, ordering, idempotency, verdict overrides, export parity. These survive a visual redesign.
- **Presentation-literal** (`test_routes.py:42-71`): assert exact CSS values (`inline-size: 5.4rem`), exact hex colours (`--accent: #b23a1b`), and font family strings (`--font-display: "Michroma"`). These fail on any restyle even when the feature still works.

**Sub-Systems Involved**:

- **gui/tests/test_routes.py**: asserts implementation details of the design system.
- **gui/tests/test_runner.py, test_reports.py**: assert behaviour.

### Decision

Decide what UI tests are allowed to pin. This is not a stylistic preference: principle 5 says a passing test that tests nothing useful is failure, and a test that fails on a harmless colour change trains the team to ignore red.

**Resolution**:
- **Decision**: Adopt Option A (Semantic Assertions Only)
- **Rationale**: Tests assert user/accessibility contracts (`data-theme`, `aria-pressed`, form fields, tokens block present); asserting exact hex colours, pixel/rem widths, and font names is forbidden to uphold Constitution Principle 5 (`Tests Drive Confidence`)
- **Resolved by**: Accepted in `/levelup.clarify`
- **Resolution date**: 2026-11-01
- **Status**: Resolved

#### Implementation Plan

- [x] Ratified in `/levelup.clarify`
- [ ] Create testing rule `context_modules/rules/testing/ui_assertion_strategy.md` (via `/levelup.implement`)
- [ ] Refactor `gui/tests/test_routes.py:42-71` to semantic assertions
- [x] Mark this CDR Resolved

### Evidence

- `gui/tests/test_routes.py:42-56` (palette hex values, `inline-size: 5.4rem`, selector strings)
- `gui/tests/test_routes.py:59-71` (font family literals)
- `gui/tests/test_runner.py:27-145`, `gui/tests/test_reports.py:49-132` (behaviour-first contrast)
- Team constitution principle 5 (`Tests Drive Confidence`)

### Feature Implementation Evidence

**Feature**: `002-mocked-eval-gui` — Mocked Evaluation GUI
**Branch**: `module-2-start`
**Added**: 2026-11-01

**Spec References**:
- The spec contains **no** requirement for theming, dark mode, or typography. Styling is limited to `plan.md` "Desktop-first minimal styling" and the brief's non-goal: "No CSS framework overhaul / design system — minimal server-rendered styling only."
- Constitution principle 5: tests must verify behaviour, not just existence.

**Implementation Evidence**:
- `gui/tests/test_routes.py:42-56` asserts exact palette hex values and `inline-size: 5.4rem`; `59-71` asserts font-family literals and Google Fonts URL fragments.
- `gui/templates/base.html` is a 363-line hand-rolled dual-theme design system — beyond the stated non-goal and unmentioned in the spec.
- Behavioural tests in `test_runner.py`/`test_reports.py` assert lifecycle and parity instead, which is the pattern worth keeping.
- Tasks: T009 ("minimal styling") and T033 (style/type checks) did not catch the scope drift.

**Commit Evidence**:
- None for `gui/` (untracked).

**Validation**:
- [x] Both assertion styles confirmed by reading the tests
- [x] Scope deviation from the brief's non-goal documented here
- [ ] Decision on assertion policy not made
- [ ] Decision on whether the theme system ships, or the spec/brief is amended to cover it

---
