# Whole-body phase-neutral yaw candidate

## Evidence and visual diagnosis before editing

- All four sampled rollouts are finite semantic captures from direct-uniform
  still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm.  Three
  samples are effective replicas of the inherited v26 combination despite
  comment or version-label differences: all capture at `23.9305 T`, have mean
  distance `2.45000 L`, score `-0.55178099`, and identical combined sheets.
  Repackaging the v26 combination is therefore exhausted.
- I inspected the combined top-down vorticity and oblique Lambda2 sheets for
  the replicated v26 result, the v25 carrier-first-allocation control, and the
  inherited speed-released posterior-energy negative.  Each fish is visibly
  self-propelled from quiescent water and retains a coherent alternating
  posterior wake.  V26 takes the tightest target-signed late arc and develops
  separated compact three-dimensional structures through capture.  V25 keeps
  a smoother but slower arc, while the posterior-energy negative retains a
  similarly coherent wake yet arrives later.  Thus wake intensity alone does
  not explain the useful route change, and adding more posterior energy is not
  supported.
- Metrics agree with the visual reading.  Combining anterior phase-neutral
  yaw with carrier-first residual allocation improves v25 from `25.9545 T`,
  mean distance `2.55008 L`, and score `-0.64778945` to `23.9305 T`,
  `2.45000 L`, and `-0.55178099`.  Mean/max speed rises from
  `0.5102/0.6672` to `0.5458/0.7837 L/T`, and any-joint acceleration-limit
  residence rises from `33.95%` to `45.62%`, but peak planar force and yaw
  moment remain unchanged near `0.02974/0.01484`.  This validates the combined
  response/allocation mechanism while making another global carrier increase
  an unsafe and non-isolated test.
- The remaining error is in the semantics of the observed yaw response.  In
  v26, raw yaw rate correlates `-0.934` with anterior joint rate.  The current
  `raw_rate + 0.4*phi_dot[1]` correction reduces yaw-rate RMS from `1.473` to
  `0.561 rad/T`, but that corrected signal still correlates `-0.938` with the
  observed posterior tangent rate `phi_dot[1] + phi_dot[2]`.  A two-joint fit
  gives raw yaw approximately `-0.585*phi_dot[1] - 0.218*phi_dot[2]` in v26;
  the coefficients remain close in early, middle, and late route segments and
  in v25 (`-0.548`, `-0.215`).  The anterior-only estimate therefore leaves a
  measured posterior carrier-recoil component for target feedback to chase.

## Policy hypothesis

Retain v26's completion-gated redirect, progress-gated posterior lag,
target-relative guidance, carrier-first steering allocation, and all active
gait gains.  Extend only the phase-neutral observation: add a bounded
posterior-tangent recoil estimate `0.20*(phi_dot[1] + phi_dot[2])` to the
existing anterior estimate `0.40*phi_dot[1]` before yaw-rate feedback and
redirect release.  The resulting total coefficients are approximately
`0.60` on anterior rate and `0.20` on posterior-joint rate, matching the
completed-rollout fit without adding a hidden phase, filter state, clock,
route coordinate, target identity, or scalar propulsion change.

The direct expectation is less half-cycle countersteering, a smoother or
earlier target-signed arc, and capture no later than v26 while the established
carrier, two-view wake, and force/moment envelope remain intact.  Reject the
mechanism if capture is lost or later than `23.9305 T`, mean distance exceeds
`2.45000 L`, the route develops new overshoot, any-joint limit residence grows
materially beyond `45.62%`, peak speed/load grows without better closure, or
the coherent alternating wake degrades.  The new candidate has no same-worker
CFD evidence; formal evaluation after exit must decide this test.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish oscillators and closed-loop direction tracking
source_mechanism: separate fast gait-synchronous body recoil from persistent route-scale turning before applying target feedback
transferable_invariant: target guidance should respond to macroscopic yaw rather than countersteer against the observed traveling bend's anterior and posterior recoil
nontransferable_details: published gains, clocked CPG phase, dimensional cadence, robot geometry, species-specific envelopes, exact vortex phase, and prescribed routes
policy_translation: retain normalized body-frame target feedback and carrier-first allocation, but extend the anterior joint-rate recoil estimate with one bounded observed posterior-tangent-rate term in the two-joint yaw-response signal
falsification: reject if arrival or distance integral regresses, acceleration or speed-limit residence grows materially, loads rise, the target-signed arc overshoots, or coherent capture is lost

## Evidence boundary

All numerical and visual comparisons above come from completed sampled or
inherited CFD rollouts.  The proposed whole-body phase estimate is unevaluated
in this worker.
