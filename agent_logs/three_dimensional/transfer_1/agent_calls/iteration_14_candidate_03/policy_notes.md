# Whole-wave route-rate projection candidate

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and semantic `capture`.  The current
  v30 whole-wave pose projection is strongest at `18.9970 T`, score
  `-0.18596914`, and distance integral `2.07455 L`.  Three equivalent v29
  posterior-recovery implementations reproduce capture at `19.3105 T`, score
  `-0.21057567`, and integral `2.09959 L`.
- I inspected the combined top-down vorticity and oblique body/Lambda2 rows
  from release through termination for v30 and the reproduced v29 route, plus
  the inherited parent's bidirectional-recovery rollout.  All visibly
  self-propel from quiescent water: compact startup structures develop into a
  coherent alternating three-dimensional posterior wake while each fish
  follows one continuous target-signed arc.  V30 is visibly farther along the
  same route in the late frames and captures during continued swimming; no
  sheet shows passive advection, wake breakdown, collision, domain exit, or a
  numerical-instability precursor.  The inherited uncentered projection that
  missed by `0.0506 L`, curled away, and exited left remains the semantic
  failure boundary, so raw large-error redirect geometry stays protected.
- Numeric diagnostics agree with a useful observation change rather than a
  new propulsive regime.  Relative to v29, v30 leads in distance by
  `0.0241/0.1537/0.1495/0.1735 L` at `4/8/12/16 T`; mean speed rises from
  `0.6647` to `0.6764 L/T`, maximum speed falls slightly from `0.9312` to
  `0.9272 L/T`, and peak normalized planar force/yaw moment remain close at
  `0.03068/0.01541`.  Head/tail/any-joint acceleration-limit residence changes
  from `34.18/8.17/42.35%` to `34.97/8.51/43.43%`.  Whole-wave pose rejection
  therefore improves route closure, but is not actuator or effort relief.
- The assigned parent's inherited bidirectional steering-recovery candidate
  supplies a concrete negative result.  Despite frozen-trajectory headroom on
  every affected v29 state, its completed rollout captures at `19.3490 T`,
  score `-0.21139817`, and integral `2.10054 L`, slightly worse than v29's
  `19.3105 T`, `-0.21057567`, and `2.09959 L`.  It retains wake coherence, but
  falsifies the claim that a second tail-to-head allocation pass is useful
  merely because static replay finds feasible same-sign headroom.
- Reconstructing the evaluator's seven-sample body-frame bearing window on
  the completed v30 trajectory exposes a remaining rate inconsistency.  Raw
  bearing-window rate has standard deviation `1.943 rad/T` and within-beat
  mean absolute deviation `1.630 rad/T`.  The existing head-joint correction
  reduces those to `0.826/0.687`; adding the derivative of the already-used
  posterior carrier tangent reduces them further to `0.521/0.381`.  The same
  structural coefficient gives `0.483/0.353` on the reproduced v29 route.
  This repeated common-mode reduction supports applying one observation
  decomposition consistently; it does not support another carrier or steering
  gain change.

## One-candidate policy hypothesis

Preserve v30's state-feedback oscillator, posterior lag, raw
completion-gated redirect, approach/response scheduling, whole-wave pose
projection, half-cycle steering, anterior-to-posterior rejected-steering
spillover, and componentwise physical bounds.  Form a posterior carrier yaw
rate from the observed tail-tangent rate `phi_dot[1] + phi_dot[2]` using the
same bounded coefficient already used for posterior carrier pose.  Add it to
both head-corrected bearing trend and route turn rate before the final route
feedback pass.  Keep redirect selection and its response-gated release on the
evaluated head-only corrected rate so posterior mean-bend transients cannot
recreate the inherited redirect-release failure.

The expected outcome is to retain v30 capture and wake coherence while
reducing beat-frequency route countersteering and improving middle/late
closure.  Falsify the mechanism if capture is lost or later than `18.9970 T`,
the distance integral exceeds `2.07455 L`, the late distance lead disappears,
the target-signed arc reverses, any-joint limit residence materially exceeds
`43.43%`, or maximum speed and normalized force/moment materially exceed
`0.9272`, `0.03068`, and `0.01541`.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and classical posterior traveling-bend propulsion
source_mechanism: separate persistent target-direction feedback from the observed phase of the complete propulsive body wave while retaining deliberate mean curvature
transferable_invariant: route-scale bearing and yaw-rate feedback that share joint-correlated carrier recoil should remove the same observed whole-wave common mode without changing the carrier or the protected redirect
nontransferable_details: published gains, clocked CPG phase, robot linkage geometry, species-specific kinematics, dimensional cadence, exact vortex phases, and prescribed task routes
policy_translation: add the existing bounded posterior tail-tangent rate estimate to both normalized body-frame route derivatives, while keeping raw redirect selection and response on the evaluated head-only rate
falsification: reject if whole-wave rate projection loses or delays capture, worsens the distance integral, erases useful mean curvature, disrupts the alternating wake, or materially raises saturation, speed, normalized force, yaw moment, or the inherited left-exit risk

## Evidence boundary

All numerical and visual claims above come from completed sampled CFD and
inherited optimizer logs.  The whole-wave route-rate projection is an
unevaluated candidate; formal CFD after worker exit must determine whether the
offline common-mode reduction survives closed-loop trajectory change.
