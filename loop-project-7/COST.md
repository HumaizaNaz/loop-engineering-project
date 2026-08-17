# Project 7 — Cost math (Concept 13)

## One beat, measured for real

Dispatched one live beat (the normal TODO-scanning run) and read the real
token usage the harness reported — not a guess:

```
38,808 tokens for one beat (Beat 3, 2026-08-17)
```

## Pricing used (Claude Sonnet 5, confirmed via the claude-api skill)

| | Input | Output |
|---|---|---|
| Standard | $3.00 / 1M tokens | $15.00 / 1M tokens |
| Introductory (through 2026-08-31) | $2.00 / 1M tokens | $10.00 / 1M tokens |

## The one honest gap

The harness reported a single combined `subagent_tokens` figure — it did
not break out input vs. output. Rather than fabricate a precise split,
here's a defensible estimate: a read-heavy beat like this (read
`progress.md`, grep `src/`, small text output) is dominated by input
tokens (file content, tool definitions, tool-result echoes), with only a
small slice of output. Assuming a 90% input / 10% output split at
standard pricing:

```
34,927 input tokens  × $3.00 / 1,000,000  = $0.1048
 3,881 output tokens × $15.00 / 1,000,000 = $0.0582
                                    Total  ≈ $0.163 per beat
```

## Monthly cost by cadence — this is Concept 13's actual point

| Cadence | Beats/month | Monthly cost |
|---|---|---|
| Daily (like Project 3's "morning brief") | 30 | **≈ $4.89/month** |
| Hourly | 720 | **≈ $117/month** |
| Every 5 minutes | ~8,640 | **≈ $1,410/month** |

**The lesson:** the same loop, same logic, same code — cost scales
**linearly with cadence, not with how "important" the task feels**. A
daily TODO-scanner is pocket change. The identical loop firing every 5
minutes costs more than a laptop per month. Before setting a cadence,
do this multiplication — not after.
