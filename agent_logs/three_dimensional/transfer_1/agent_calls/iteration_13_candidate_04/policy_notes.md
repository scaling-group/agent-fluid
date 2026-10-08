# Whole-wave gait-frame projection candidate

## Evidence and visual diagnosis before editing

- All four sampled evaluations satisfy the Phase-2 contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite dynamics, and semantic `capture`.  They contain two unique,
  exactly reproduced outcomes.  The assigned parent's v29 posterior steering
  spillover and its equivalent residual-allocation sibling capture at
  `19.3105 T`, score `-0.21058`, and distance integral `2.09959 L`; the two
  v28 gait-frame controls capture at `20.5315 T`, `-0.29558`, and `2.18697 L`.
- I inspected the top-down vorticity and oblique body/Lambda2 rows of the
  combined keyframe sheets for the strongest v29 rollout and the weaker v28
  rollout from release through capture.  Both fish are visibly self-propelled
  from quiescent water: a compact startup wake develops into coherent,
  alternating posterior packets while the body follows a continuous
  target-signed arc.  V29 advances farther along the arc at every sampled late
  time and reaches the capture circle about `1.22 T` sooner.  The denser
  curvature and wake motion near capture remain orderly rather than showing
  a collision, domain-exit, or instability precursor.
- The metrics agree with self-propulsion and useful route change rather than
  advection.  V29 raises mean/max speed from `0.628/0.894` to
  `0.665/0.931 L/T`, lowers any-joint acceleration-limit residence from
  `46.29%` to `42.35%`, and retains peak normalized planar force/yaw moment at
  `0.03056/0.01541`, close to v28's `0.03056/0.01525`.  Its distance leads
  v28 by `0.050/0.195/0.517/0.994 L` at `4/8/12/16 T`.  Thus the spillover is
  a positive allocation result, but neither its benefit nor the remaining
  beat-scale steering should be described as effort or load relief.
- No current sampled sheet has a failure termination.  The inherited
  uncentered full-frame projection remains the relevant failure boundary: it
  passed just outside capture at about `0.8006 L`, curled away, and exited
  left.  Raw target geometry must therefore continue to choose and release
  the completion-gated large-error redirect, with its commanded joint mean
  removed before carrier-phase rejection.
- A frozen-trajectory reconstruction exposes one remaining observation
  inconsistency in both unique sampled routes.  Within `0.55 T` carrier bins,
  v29's raw target-vector angle has mean absolute deviation `0.181 rad`; the
  existing redirect-centered head-joint projection reduces it to `0.083 rad`.
  Adding a bounded posterior carrier estimate from the two-joint tail tangent
  after subtracting the baseline route and redirect means reduces it again to
  `0.039 rad`.  The v28 route independently shows `0.171 -> 0.078 -> 0.033
  rad`.  This is a repeated whole-wave common mode, not a one-rollout scalar
  fit.  On the fixed states the new projection changes the bounded turn
  request by mean absolute `0.38` and at most about `2.00`, so closed-loop CFD
  must decide whether the cleaner signal improves the route.

## One-candidate policy hypothesis

Preserve v29's state-feedback oscillator, posterior lag, raw
completion-gated redirect, approach/response scheduling, half-cycle steering,
carrier-first projection, cross-joint rejected-steering spillover, and physical
acceleration bound.  Compute the current head-only guidance once, use its
bounded route request plus the raw redirect to estimate deliberate mean tail
curvature, and subtract those means from observed `phi[1] + phi[2]`.  Add only
the remaining posterior traveling-wave tangent to the gait-yaw estimate, then
recompute route guidance from normalized body-frame target geometry.  The
redirect remains on raw geometry, so the mechanism cannot repeat the inherited
redirect-release failure by construction.

The expected outcome is to retain capture and the coherent v29 wake while
reducing beat-frequency countersteering, improving middle/late closure, and
keeping the existing speed, action, and load envelope.  Falsify the mechanism
if capture is lost or later than `19.3105 T`, distance integral exceeds
`2.09959 L`, the lead after `8 T` disappears, the route reverses or wake loses
coherence, any-joint acceleration-limit residence materially exceeds `42.35%`,
or max speed and normalized force/moment materially exceed
`0.931/0.03056/0.01541`.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and classical posterior traveling-bend propulsion
source_mechanism: separate target-direction feedback from the observed phase of the complete propulsive body wave while preserving commanded mean curvature
transferable_invariant: persistent route geometry should reject joint-correlated carrier recoil from both joints, but should not cancel the mean bend that deliberately steers the swimmer
nontransferable_details: published gains, clocked CPG phase, robot linkage geometry, species-specific kinematics, dimensional cadence, exact vortex phases, and prescribed task routes
policy_translation: estimate a bounded whole-wave carrier yaw from redirect-centered head angle plus route-and-redirect-centered tail tangent, then recompute normalized body-frame route feedback while leaving raw redirect selection and two-joint actuation unchanged
falsification: reject if the added phase projection loses or delays capture, worsens the distance integral, erases target-signed mean curvature, disrupts the alternating wake, or materially raises saturation, speed, normalized force, yaw moment, or the inherited left-exit risk

## Evidence boundary

All numerical and visual claims above come from completed sampled CFD and
inherited optimizer logs.  This candidate receives formal CFD evaluation only
after worker exit; no same-worker performance is claimed.
