# Closing-response carrier-release candidate

## Evidence and visual diagnosis before editing

- All four sampled solver examples satisfy the frozen Phase-2 contract:
  direct uniform still-water initialization, `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and `capture` termination.  The
  assigned v30 whole-wave projection is strongest at `18.99699 T`, score
  `-0.18597`, and distance integral `2.07455 L`.  The two distinct v29
  allocation implementations reproduce a slower `19.31050 T`, `-0.21058`,
  and `2.09959 L`; centering the half-cycle bend detector captures at
  `19.03549 T`, `-0.20185`, and `2.08993 L`.
- I inspected both rows of the combined sheets for the v30 winner and a
  reproduced v29 comparator from release through capture.  Their top-down
  views show self-propelled target-directed arcs and coherent alternating
  mid-plane wakes, while their oblique views show compact paired posterior
  Lambda2 structures.  Neither route is background advection, wake collapse,
  collision, or numerical instability.  V30 is visibly farther along the arc
  at matched middle and late frames and keeps maximum speed at `0.9272 L/T`
  with the established `0.03068/0.01541` peak normalized force/moment scale.
- The inherited step-14 derivative candidate is the informative semantic
  failure.  Its top-down row turns upward and away from the target even while
  laying down an organized alternating wake; the oblique row likewise shows
  continued three-dimensional propulsion rather than a solver failure.  It
  exits the upper boundary at `8.47550 T`, having improved only to
  `12.21067 L` before ending at `12.72963 L`.  The only mechanism change was
  adding `0.16*(qdot1+qdot2)` to ordinary route-rate projection.  Thus an
  offline gait-rate correlation was not a safe causal correction and must not
  be extended or merely reduced here.
- The centered half-cycle result gives a second boundary: removing commanded
  mean curvature from its bend-side detector preserves the wake and capture
  but regresses score and integral, raises maximum speed from `0.9272` to
  `0.9480 L/T`, and raises any-joint acceleration-limit residence from
  `43.43%` to `44.21%`.  Pose common-mode rejection is therefore specific to
  target sensing; it is not a general instruction to center every derivative
  or actuator-phase channel.
- On the completed v30 trajectory, after speed exceeds `0.2 L/T`, normalized
  closing speed averages about `0.67 L/T`, is negative by no more than about
  `0.009 L/T`, and gives a positive-closing response close to one through most
  of the route.  Nevertheless, the cadence law always applies turn-load
  relief.  Releasing only that pre-existing relief under observed positive
  closure changes the recorded-state frequency scale by less than about
  `2.6%` at its peak; it does not alter amplitude, the redirect, steering,
  saturation allocation, or the physical acceleration bound.

## One-candidate policy hypothesis

Preserve v30's state-feedback traveling wave, posterior lag, raw-geometry
completion-gated redirect, whole-wave pose projection, half-cycle steering,
approach scheduling, rejected-steering spillover, and componentwise physical
projection.  Add one outcome gate to carrier scheduling: map only positive
`window_closing_speed_L` through the existing normalized closing-speed scale,
and let that response continuously release the cadence reduction caused by
turn load.  Zero or negative closure retains the full inherited turn relief,
so a wrong turn cannot earn extra carrier cadence.

The expected result is the same coherent target-signed wake and capture with
slightly stronger translation during already productive curved motion,
improving middle/late distance and capture time without recreating the
derivative candidate's wrong-sign arc.  Falsify the mechanism if capture is
lost or later than `18.99699 T`, distance integral exceeds `2.07455 L`, the
route changes sign, the alternating wake decoheres, or maximum speed,
acceleration-limit residence, normalized force, or moment materially exceeds
`0.9272/43.43%/0.03068/0.01541` without compensating progress.

```text
bookshelf_consulted: true
source_domain: biological C-start and burst redirection plus sensor-modulated robotic-fish CPG control
source_mechanism: a strong target-directed bend yields to renewed posterior propulsion after observed response confirms that the swimmer is redirecting usefully
transferable_invariant: separate steering demand from its measured outcome, and restore withheld propulsion only when normalized body-frame target closure is positive
nontransferable_details: published gains, species burst timing, duty ratios, clocked CPG phase, full-body kinematics, dimensional cadence, exact vortex phase, and a prescribed route
policy_translation: use positive windowed closing speed to release only the existing turn-induced cadence relief while leaving raw body-frame redirect geometry and the two-joint state-feedback contract unchanged
falsification: reject if response-gated release loses or delays capture, worsens middle or late closure, reverses the target-signed arc, disrupts the coherent wake, or materially increases speed, saturation, force, or moment without compensating progress
```

## Evidence boundary

All performance claims above come from completed sampled CFD and inherited
optimizer logs.  This candidate will be evaluated only after worker exit; no
same-worker CFD result is claimed.
