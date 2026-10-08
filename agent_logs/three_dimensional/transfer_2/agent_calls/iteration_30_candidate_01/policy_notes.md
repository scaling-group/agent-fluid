# Evidence-selected v41 candidate after coupled anti-windup falsification

## Visual diagnosis before candidate selection

- The four assigned solver examples are byte-identical v41 evaluations.  Each
  satisfies direct uniform still-water initialization (`U_infinity=[0,0,0]`,
  no cylinders or prewarm), captures at `24.640015T` and `0.748356L`, has mean
  distance `2.347937L` and score `-0.448328283`, and performs 284 inertial
  moving-window shifts.  Their policies, trajectories, and combined sheets are
  exact nominal replications, not four independent mechanisms or held-out
  tests.
- The combined v41 sheet was inspected from release through capture in both
  views.  The top-down row begins wake-free, shows sustained self-propelled
  diagonal progress with an alternating coherent mid-plane vortex street, and
  ends in a compact transverse hook through the target disk.  The oblique row
  retains compact three-dimensional Lambda2 structures through the hook.  No
  background current can advect the fish, and there is no visible wake breakup,
  out-of-plane escape, or collision-like terminal event.  The trace agrees:
  neither joint occupies a hard stop and peak absolute planar force/yaw-moment
  coefficients are `0.02303/0.03169/0.01559`.
- No assigned solver has a termination failure.  The informative completed
  regression is the inherited v43 coupled anti-windup test.  Its combined sheet
  remains visually in the same coherent wake and terminal-hook class, and its
  first trajectory divergence is local (`22.044T`, `2.052L`).  Nevertheless it
  captures three integration rows later at `24.656513T`, reduces the crossing
  margin from `0.001644L` to `0.000397L`, worsens mean distance from
  `2.347937L` to `2.348909L`, and lowers score from `-0.448328` to `-0.449516`.
  It creates no useful load or command class: peak coefficients remain
  `0.02313/0.02974/0.01559`, while raw acceleration-envelope exposure is
  essentially unchanged (`73.55%` versus `73.59%`).
- The v43 result closes the complementary side of the assigned parent's v42
  negative.  Reclaiming rejected posterior residual through the anterior phase
  anchor worsened distance and score; vetoing the anterior residual whenever
  posterior safety filters reject its matched share also worsens distance and
  score.  On this established hook, posterior stroke/rate safety is a
  joint-local allocation decision, not an instantaneous coupling signal that
  should modify the anterior oscillator in either direction.

## Candidate hypothesis

Select the current v41 terminal phase-allocation policy byte-identically as
this workspace's exactly one candidate.  Preserve its observed-state anterior
phase anchor, lagged posterior traveling bend, normalized body-frame
predicted-miss corridor, coupled half-cycle steering, posterior stopping-stroke
reserve, and posterior rate coast.  Do not adopt v43's realized-follower
anti-windup or v42's inverse headroom transfer.

This is an evidence-backed negative selection rather than a scalar-only tune or
a same-worker CFD claim.  The post-exit evaluation should reproduce capture,
the coherent far route and terminal hook, zero joint hard-stop occupancy, and
the low-load class.  Reject the selection if nominal replication fails.
Separately test the coupled allocation on reflected or perturbed poses before
claiming generality; the fixed nominal case cannot show whether asynchronous
joint safety becomes harmful on a genuinely different route.

bookshelf_consulted: true
source_domain: sensor-modulated coupled-oscillator robotic-fish control and asymmetric fish turning
source_mechanism: embed bounded sensory steering in an observed anterior-to-posterior traveling bend while retaining a stable phase anchor and posterior lag
transferable_invariant: preserve the empirically stable traveling-wave phase relation and allocate target-derived steering by observed phase without treating independently constrained joints as interchangeable instantaneous authority
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, robot or species kinematics, full-body envelopes, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: retain v41's normalized body-frame collision-course residual and lagged-wave half-cycle gate, with the anterior phase anchor and posterior joint-local safety filters left independent
falsification: reject if capture, far-route locality, coherent wake, zero hard-stop occupancy, or the low-load class fails to repeat, or if reflected or perturbed evidence shows that the retained coupled split removes necessary route correction

## Pre-evaluation boundary

- The selected solver remains LF SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`,
  identical to all four assigned v41 policies.  This identifies the completed
  mechanism being retained; it is not a new CFD result.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this ChatGPT account.  Its three declared no-CFD commands
  were therefore run directly and separately after removing the duplicate
  assigned-parent marker from the rendered workspace README.  Reusable-guidance
  semantics, the Julia public contract, and the solver editable-boundary audit
  pass; the contract returns finite accelerations
  `(-14.3858335, 0.0005062)`.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.
  Formal CFD remains reserved for the post-worker evaluator.
