# Sprints (Solo Dev · 2 weeks each)

## Sprint 1 (T-90 → T-76): Repo & Signaling Skeleton
- Private repo init, CI (GitHub Actions)
- Node.js + Socket.io signaling skeleton (local)
- Postgres schema: users, devices, sessions
- Health route + basic tests

## Sprint 2 (T-76 → T-62): WebRTC + coturn (local)
- Dockerized coturn (template config)
- WebRTC P2P handshake on LAN
- Invite + PIN pairing flow (server + stubs)

## Sprint 3 (T-62 → T-48): Android Senior Stream & Control
- MediaProjection streaming MVP
- AccessibilityService taps/scrolls
- Foreground service + persistent notification

## Sprint 4 (T-48 → T-34): Security & Guardrails
- Biometric session approval
- Denylist (banking/payment apps → view-only)
- Event logging (start/stop/errors)

## Sprint 5 (T-34 → T-20): Helper Apps
- Android helper: viewer + control gestures
- iOS helper: guidance mode viewer + pointer overlay (stub)
- Rate limit + idempotency on control channel

## Sprint 6 (T-20 → T-6): Recording, Logs, Compliance UI
- Opt-in recording (local in dev → S3 in prod, 14-day TTL)
- Admin log viewer (no content)
- Onboarding disclosures + privacy settings

## Sprint 7 (T-6 → T-0): Staging → Beta → Launch
- Domain + SSL, staging VPS
- TURN enabled, cross-geo tests (US ↔ India)
- Play Store internal/closed testing; finalize legal/compliance

## Sprint 8 (T+0 → T+14): Stabilization & Audit
- Live monitoring dashboards
- Hotfixes and performance tuning
- Light security audit; prepare MVP-2 plan
