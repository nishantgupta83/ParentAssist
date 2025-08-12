# Cost Matrix (with T-Day Triggers)

**T-Day = Production launch.** Negative numbers are days *before* launch.

| Category | Cost | Start Paying | Notes |
|---|---:|---|---|
| Backend Hosting (VPS: Node/Socket.io, Postgres, Redis) | $25–35/mo | **T-30** | Stand up staging + internal testing early |
| TURN (coturn self-host + optional managed backup) | $8–20/mo | **T-14** | Validate P2P/relay behavior on real networks |
| Storage (S3/Wasabi for opt-in recordings) | $1–5/mo | **T-0** | Mock locally in dev; enable in prod only |
| Domain | $10–15/yr | **T-45** | Needed for SSL + store builds |
| SSL (Let’s Encrypt) | $0 | **T-45** | Automate renewals |
| Play Store Dev | $25 one-time | **T-60** | Closed/internal testing tracks |
| Apple Dev (Helper iOS) | $99/yr | **T-60** | TestFlight for helper guidance app |
| Legal/Compliance | ~$1,500 one-time | **T-45 → T-15** | Privacy Policy, Terms, Accessibility review |
| Security Audit | ~$800 one-time | **T-15 → T+30** | Light audit pre/post launch |
| Localization (Hindi/regional) | $200–500 | **T-30 → T+30** | Optional for first update |
| Contingency | $15–35/mo | **T-0** | Infra spikes post-launch |

**Upfront (Year 1):** ~\$2,635 · **Monthly Opex:** \$50–75
