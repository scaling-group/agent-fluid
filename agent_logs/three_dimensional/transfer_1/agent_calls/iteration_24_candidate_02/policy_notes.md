# Launch-only crossflow-dropout load bridge

## Completed evidence and visual diagnosis before editing

- The assigned parent is the reproduced v38 crossflow-confidence controller.
  Three sampled direct-uniform still-water runs are byte-identical captures at
  `18.232491 T`, score `-0.126500`, and total/observed distance integrals
  `2.012983/1.399804 L`.  Distances near `2/4/6/8/12/16 T` are
  `12.2535/11.6566/10.4704/8.9925/5.8275/2.4233 L`; mean/max speed is
  `0.7032/0.9519 L/T`, any-joint acceleration-limit residence is `41.54%`,
  and peak normalized force/moment is `0.03068/0.01579`.  Its diagnostics
  confirm `U_infinity=(0,0,0)`, direct uniform initialization, no cylinders,
  and no prewarm.
- I inspected the complete combined v38 sheet.  The fish visibly
  self-propels from quiescent water along a smooth target-signed arc; compact
  startup structures become a coherent alternating top-down vortex street and
  paired oblique Lambda2 wake through capture.  There is no passive advection,
  collision, wake collapse, domain exit, or visible instability.
- The two newest inherited candidates are informative mechanism failures even
  though both retain capture.  The crossflow-dropout load bridge captures at
  `18.254490 T`, score `-0.129781`, and integrals
  `2.016789/1.405736 L`; the positive-closing-gated load bridge captures at
  `18.309486 T`, score `-0.131892`, and integrals
  `2.019113/1.408895 L`.  They are only `0.0014-0.0032 L` ahead of v38 near
  `2-4 T`, then are respectively `0.0216-0.0742 L` and
  `0.0210-0.0873 L` farther away at the `6-12 T` checkpoints.  Neither
  changes the peak `0.03068` normalized force scale, and their maximum speeds
  remain close to v38 at `0.9604/0.9542 L/T`; the loss is route closure, not
  an instability or load tradeoff.
- Both newer combined sheets show the same captured, alternating top-down wake
  topology, but every oblique Lambda2 panel is black.  That is an evidence-
  contract failure, so neither bridge supports a new 3D wake-quality claim.
  The inherited hard boundary also remains unchanged: extending phase-common-
  mode rejection to route-rate feedback produced an organized wake but an
  upward wrong-sign turn, `left_domain` at `8.4755 T`, minimum distance
  `12.2107 L`, and roughly tenfold force/moment peaks.  Hydrodynamic sensing
  therefore remains confined to proportional gait-pose confidence.
- In the reproduced v38 trace, speed rises from a `0-2 T` mean of
  `0.133 L/T` through `0.329/0.480 L/T` in the `2-3/3-4 T` bins and exceeds
  `0.6 L/T` shortly after `4 T`.  This separates the only interval where both
  load bridges retain a small lead from the established-swimming interval
  where they regress.  Crossflow dropout or instantaneous closing response
  alone recurs throughout the gait and is therefore not sufficient
  arbitration for force confidence.

## One-candidate policy hypothesis

Preserve the reproduced v38 carrier, posterior lag, target geometry, redirect,
bearing-divergence recovery, whole-wave pose rejection, head-only rate
correction, cadence response, carrier-first actuator allocation, and bounded
moderate-crossflow confidence.  Add one mechanism only: lateral-load magnitude
may bridge a near-zero raw-crossflow dropout while normalized translational
speed still indicates launch, and it fades continuously to zero as
self-propulsion establishes.  The primary crossflow band pass is never
attenuated.  Observed de-meaned anterior-joint phase remains the sole odd sign,
and the fused cue remains confined to proportional whole-wave pose rejection.

This translation does not use time, a step counter, world coordinates, or a
route sign.  It predicts retention of the small `2-4 T` lead from the two load
comparators without their `6-12 T` deficit, after which the policy becomes v38
under established speed.  The target signature is capture no later than
`18.2325 T`, observed distance integral no greater than `1.3998 L`, readable
coherent top-down and oblique wakes, and no material increase beyond the
sampled `0.961 L/T`, `41.9%`, `0.03068`, and `0.01579`
speed/saturation/force/moment envelope.  Formal CFD occurs only after this
worker exits; none of these candidate outcomes is claimed here.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and adaptive swimming
source_mechanism: preserve a stable traveling-wave carrier while bounded sensory assistance yields after the locomotor response makes the primary cue observable
transferable_invariant: a secondary body-frame cue may bridge transient loss of a primary cue, but should release continuously once normalized motion indicates that the established carrier can supply its own feedback
nontransferable_details: published gains, dimensional speed thresholds, species and robot kinematics, clocked CPG phase, exact vortex phase, full-body envelopes, and task-specific routes
policy_translation: soft-union normalized lateral-load confidence only through simultaneous near-zero normalized crossflow and low normalized body-speed gates, multiply it by observed de-meaned joint phase, and confine it to proportional two-joint gait-pose rejection
falsification: reject if the early lead does not survive, the 6-12 T route regresses, capture or readable two-view wake is lost, or speed, saturation, normalized force, or yaw moment materially exceeds the reproduced envelope

## Evidence boundary

All numerical and visual claims above describe completed sampled CFD or the
assigned parent and inherited logs.  The single candidate below has no
same-worker CFD evidence.

## No-CFD implementation audit

- The single candidate has SHA-256
  `efb2c733ec12b9d768e858871e693afb83f1a51871a08aa46ebe8df5191f5b19`.
- The configured `check-runner` was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable for this account.  The rendered `README.md` also
  contained the same assigned-parent marker twice; removing only that duplicate
  allowed the prescribed material-guidance check to resolve the parent.  Its
  three exact no-CFD commands were then run locally and separately: the
  notes/material-guidance check, lightweight Julia policy contract, and solver
  editable-boundary check all pass.
- Synthetic state checks confirm the load bridge is full at low speed, fades
  continuously during launch, is zero at established speed, leaves moderate
  and high crossflow behavior on the primary band pass, preserves the new
  cue's reflection symmetry, and keeps both outputs finite and inside the
  componentwise acceleration limit.  No formal CFD was run.
