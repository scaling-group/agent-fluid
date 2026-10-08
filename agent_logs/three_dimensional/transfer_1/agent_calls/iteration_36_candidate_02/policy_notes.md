# Terminal-linear arbitration of decisive posterior response

## Completed evidence and visual diagnosis before editing

- All four sampled solver examples are finite `capture` episodes initialized
  directly from uniform still water with `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm snapshot.  The assigned prefill is the completed v51
  decisive-completion controller at `17.45149 T`, score `-0.0612916`, and
  total/observed distance integrals `1.946554/1.328924 L`.
- Completed v50 remains the best sampled controller by arrival, total integral,
  and score: `17.41299 T`, `1.945327 L`, and `-0.0595203`.  It also crosses
  more deeply at `0.745094 L` than v51 at `0.748203 L`.  V51 nevertheless has
  the better observed integral and is closer than v50 by
  `0.03010/0.03356/0.01702/0.00878 L` at `6/8/10/12 T`; the traces are equal
  within `0.00005 L` at `14 T`, after which v51 trails by `0.01760 L` at
  `16 T`.  This is an evidenced route-stage crossover, not a scalar-only
  ranking or a reason to change the carrier.
- The v51 gain is not effort relief.  Relative to v50, maximum speed falls
  from `0.98310` to `0.96666 L/T`, but any-joint acceleration-limit residence
  rises from `40.11%` to `42.99%`; both retain the same sampled peak normalized
  planar force/moment scale of `0.03225/0.01609`.
- Two additional completed step-35 release variants from inherited optimizer
  logs do not provide a better handoff.  Centerline-deadband qualification
  captures at `17.51199 T` with total/observed integrals
  `1.949506/1.334166 L`; axial-response qualification captures at
  `17.45699 T` with `1.950225/1.331805 L`.  Their regressions rule out stacking
  another bearing deadband or propulsion-response gate on the same residual.
- I inspected the combined sheets from release through capture for sampled
  v49, v50, and decisive v51, plus the inherited axial and deadband failures.
  Every top-down row shows active self-propulsion on the same smooth
  target-signed arc: compact startup vorticity grows into a coherent
  alternating posterior street without passive advection, collision, domain
  exit, or wake collapse.  The sampled v50/v51 oblique rows are black after
  frame 000 and cannot support a comparative 3D-wake claim.  The readable
  axial/deadband oblique rows show that the preserved carrier still produces
  compact paired caudal Lambda2 structures despite their worse routes; this
  further localizes the failure to release arbitration rather than propulsion.

## One-candidate policy hypothesis

Preserve decisive v51's normalized body-frame sensing, state-feedback
carrier, posterior lag, selective crossflow pose confidence, base route and
redirect steering, launch residuals, carrier-first spillover, half-cycle
steering, approach priority, and componentwise projection.  Change only the
geometric qualifier on the existing out-of-band correct-yaw release.  Use the
decisive nonlinear completion outside the terminal regime, where its completed
trace owns the `6-12 T` checkpoint and observed-integral advantage; across a
continuous normalized-distance band from `4.0 L` to the existing `2.1 L`
approach boundary, blend to v50's linear geometric completion and keep that
linear qualifier nearer the target, where v50 owns the `16 T`, arrival, capture
depth, and total-integral advantage.

This is a state-dependent arbitration between two completed steering-response
laws, not a cadence/curvature gain change or a clocked route.  It leaves the
carrier, steering sign, contraction branch, and near-target return of curvature
active.  The next CFD rollout should retain v51's `6-12 T` lead and v50's
`16 T`/terminal advantage, capture no later than `17.413 T`, and improve on
v50's `1.945327 L` total integral without materially exceeding the completed
speed, saturation, force, or moment envelope.  Falsify it if either checkpoint
regime regresses, capture becomes later or shallower, the transition becomes
beat-sensitive, the target-signed arc or readable two-view wake degrades, or
loads/limit residence materially increase.  Formal CFD occurs only after this
worker exits.

```text
bookshelf_consulted: true
source_domain: terminal capture control and sensor-modulated robotic-fish direction tracking
source_mechanism: preserve an established propulsive rhythm while normalized approach state arbitrates supplementary steering response between middle-route correction and near-target capture
transferable_invariant: once broad target-directed motion works, a continuous body-frame distance signal may switch only supplementary steering semantics across an evidenced crossover while carrier and base steering remain active
nontransferable_details: published gains, dimensional maneuver timing, species-specific curvature envelopes, full-body CPG state, exact vortex phase, fixed world-frame routes, and source-task approach distances
policy_translation: blend the completed decisive and linear geometric qualifiers of the phase-even posterior turn-shape residual across an owned normalized-distance band; do not change carrier, base route, redirect, steering sign, or actuator projection
falsification: reject if the completed v51 middle-route lead or v50 late/terminal lead is lost, capture or coherent two-view propulsion regresses, switching becomes beat-sensitive, or speed, saturation, normalized force, or moment exceeds the sampled successful envelope
```

## Evidence boundary

All outcome and visual claims above come from assigned-parent guidance,
sampled completed solver results, and inherited optimizer logs.  The
terminal-linear arbitration below is one unevaluated policy hypothesis; no
same-worker CFD result is claimed.

## No-CFD implementation audit

- The sole materialized candidate is
  `dogfish_target_control_v52_terminal_linear_response_arbitration`, with
  SHA-256
  `e5b4285e36978846f616b6c3f220fa2b264c61d815a1c510c5bcf301527c9f25`.
  All `71` distinct direct `params.FIELD` references resolve among the `73`
  fields returned by `target_policy_params()`.
- A deterministic `9,900`-state sweep confirms that the arbitration is exactly
  completed v51 above `4.0 L`, exactly completed v50 below `2.1 L`, bounded
  continuously between their two completion qualifiers through the transition,
  and finite within the componentwise acceleration envelope.
- The required configured check-runner was invoked but its pinned
  `gpt-5.4-mini` model is unavailable on this ChatGPT account.  Its three exact
  checks were then run locally and separately.  The material-guidance check
  first exposed an inherited duplicate assigned-parent marker in `README.md`;
  removing only that duplicate repaired provenance.  The guidance check,
  lightweight Julia contract, and solver editable-boundary check all pass.  No
  formal CFD was run.
