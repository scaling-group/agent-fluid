# Speed-supported steering-engagement candidate

## Evidence and visual diagnosis before editing

- All four sampled solver rollouts satisfy the Phase-2 contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite dynamics, and `capture`. Their trajectory CSVs and combined
  two-view keyframes are byte-identical. Each captures at `19.684490 T` with
  score `-0.261384287`, mean/final distance
  `2.151092787 L`/`0.748302400 L`, path length `12.951133 L`, no joint-stop
  dwell, and `243` moving-window shifts. Three policies are byte-identical v40;
  the nominal v41 terminal-response branch is behaviorally dormant.
- I inspected the complete combined sheet for the reproduced v40 parent and
  the inherited, independently active v42 signed-yaw regression. The top-down
  rows show self-propelled compact target motion with a coherent alternating
  posterior wake from quiescent release through capture. The oblique rows show
  finite, localized Lambda2 structures, with no passive advection, collision,
  volume-filling instability, wake collapse, or out-of-plane escape. The v42
  change is visually indistinguishable because it acts only in the final
  approach; metrics nevertheless regress slightly to score `-0.261390567`,
  mean distance `2.151097816 L`, and final distance `0.748308659 L`.
- The parent is already fast and compact after its gait is established: mean
  speed is about `0.864 L/T` from `8 L` to `4 L` and `0.897 L/T` from `4 L`
  to `2 L`. Its distinct deficit is release: speed first reaches `0.20 L/T`
  at `1.606000 T`, by which point distance has fallen only from
  `12.327720 L` to `12.313759 L`; `0.25 L/T` is first reached at
  `2.194501 T`. At the first stored state, the body-frame target-angle average
  is only about `0.155 rad` and large-angle redirect is inactive, yet the
  inherited small-angle controller requests about `-1.564` and shifts the
  posterior mean tangent by about `0.112 rad`. Thus steering is strongly
  allocated before center translation supplies a meaningful course response.
- This startup diagnosis is separate from the rejected neighboring loci. The
  completed outer phase-lag governor bends the wake into a large loop and
  captures only at `46.145020 T`; adding course-supported startup mean
  curvature delays capture to `23.375013 T` and produces a pronounced late
  turn. Terminal joint-response, posture-energy, and signed-yaw selectors also
  regress. Do not alter posterior lag, add startup curvature, or revisit the
  validated quiet terminal handoff.

## Policy hypothesis

Add one state-feedback mechanism ahead of the inherited actuator allocation:
a normalized body-speed support smoothly engages the existing small-angle turn
request and its recovery curvature. At negligible translation it retains a
bounded `40%` steering floor; support reaches one by `0.25 L/T`. Geometry-owned
large-angle redirect remains fully active at every speed, and the gate becomes
identically one once either redirect support or translation support is full.
No carrier gain, oscillator frequency, posterior lag, target-owned
equilibrium, saturation allocator, terminal branch, command limit, clock, or
world-coordinate route changes.

This tests gait establishment rather than scalar-only tuning: allow the
posterior-lagged traveling bend to form before applying full small-angle route
feedback, while retaining immediate bounded redirect for genuinely large
errors. On replayed parent states, require material command changes only in the
low-speed startup interval, exact recovery of the parent after the speed gate
is full, finite bounded output, and no parameter-schema mismatch. CFD
falsification is slower or lost capture, worse distance integral or final
distance, delayed useful turning after acceleration, a changed compact route,
joint-stop dwell, material load growth, instability, or degradation of either
wake view. The new CFD evaluation occurs only after this worker exits and is
not evidence here.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming and sensor-modulated robotic-fish CPG direction control
source_mechanism: establish a posterior-lagged propulsive rhythm and continuously introduce steering feedback as observed locomotor response becomes informative
transferable_invariant: when propulsion and steering share joints, preserve the traveling-wave relation and condition small-error steering allocation on normalized observed response while retaining immediate bounded authority for large target error
nontransferable_details: published oscillator gains and frequencies, dimensional speed thresholds, species-specific amplitude envelopes, exact vortex or beat phases, robot geometry, target coordinates, and task-specific routes
policy_translation: use body-frame center speed and the existing geometry redirect gate to scale only the current small-angle turn and recovery requests before the unchanged two-joint drive and allocator; do not change posterior lag or add a startup mean bend
falsification: reject if the gate is dormant, remains active after established translation, suppresses large-error redirect, delays or loses capture, worsens distance, creates a late turn or loop, raises stops or loads, or degrades top-down or oblique wake coherence

## Deterministic pre-CFD audit

- Same-state replay against the evaluated v40 policy changes `496` of `3579`
  stored parent states. Every changed state has body-speed support below the
  declared `0.25 L/T` full threshold; no state at or above that threshold
  changes. On the parent trace, activity ends by `3.344003 T`, the steering
  scale spans `[0.40,1.0]`, and the maximum two-joint command difference is
  `10.178734 rad/T^2`. This establishes activity and its locus, not CFD
  improvement.
- A zero-speed large-target-error probe gives redirect gate `1.0` in both
  policies and byte-equivalent redirect command and drive accelerations. The
  lightweight contract returns exactly two finite accelerations, and the
  schema audit resolves all `90` direct `params.FIELD` references against the
  `91` fields returned by `target_policy_params()`; only the version label is
  intentionally unused.
- The prescribed check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this ChatGPT account and failed before executing a check.
  The three configured commands were run directly and separately: the material
  guidance/notes comparison, finite Julia policy contract, and solver edit
  boundary all pass. The rendered README contained a duplicated marker for the
  same assigned parent; removing only that duplicate allowed the prescribed
  semantic comparison to run without changing parent identity. No formal CFD
  was run.
