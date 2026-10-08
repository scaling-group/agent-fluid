# Candidate diagnosis and hypothesis

## Evidence diagnosis

- All four sampled diagnostics report direct uniform quiescent initialization
  (`U_infinity=[0,0,0]`), no instability, and `left_domain` rather than
  capture. Both visual rows show self-propulsion: the top-down sheets contain
  alternating shed vorticity and the oblique sheets contain coherent 3D wake
  structures trailing a translating body. The motion is not ambient advection.
- The assigned prefill policy (`solver_12fc3441a636`) forms a coherent wake but
  exits the upper margin at `20.790T`, with `6.267730L` minimum/final distance.
  The course-biased yaw closure therefore supplies propulsion but not enough
  useful route curvature.
- The posterior-redistribution failure (`solver_b6ed3f84ab58`) preserves the
  wake but exits the same upper margin at `26.043T`, reaches only `5.386122L`,
  touches the angle boundary, and has the inherited evidence bank's roughly
  tenfold force/moment peaks. This rules against spending more posterior
  headroom on asymmetry.
- The strongest finite trajectory (`solver_e7a7a878626e`) visibly leaves the
  high corridor, passes the target, and maintains a coherent low-load wake. It
  reaches `0.827823L` at `27.489T`, only `0.077823L` outside capture, before
  continuing to the left boundary. Its trajectory shows about `0.66L/T`
  translation through closest approach. From entry at `1.10L` to closest
  approach, normalized course error stays near saturation while the signed
  bearing worsens; the existing redirect is nearly static and its corrective
  yaw response is insufficient. This agrees with the inherited guidance that
  scalar redirect depth, timing, posterior pulses, and posterior damping all
  retained the same pass-by topology.
- No inherited candidate-specific optimizer log is materialized under
  `logs/optimize/`; the inherited `guidance/control_experience.md`, the assigned
  prefill, and all four sampled solver artifacts are the available provenance.

## Policy hypothesis

Use `solver_e7a7a878626e` as the evidenced carrier/redirect baseline, remove
its failed terminal static-depth boost, and add one bounded response-deficit
mechanism. Only during an inbound, capture-neighborhood, unsafe projected
intercept, measure whether the body-frame bearing is worsening in the requested
turn direction. If it is, add a phase-selective anterior half-cycle drive after
the static redirect blend. This reintroduces dynamic steering when the settled
same-sign bend no longer produces enough yaw, while leaving the far carrier,
steering side, posterior follower, and nominal redirect unchanged. The drive
fades with closing speed and angle headroom, so it cannot persist after the
pass or spend posterior authority.

Expected result: the added anterior impulse acts between roughly `1.10L` and
closest approach, shifting the low-load coherent trajectory inward by more
than the observed `0.077823L` gap and producing capture. Falsify the mechanism
if the new rollout remains a left-domain pass-by, loses the coherent traveling
wake, raises load or limit residence materially, or changes the far-field
trajectory before the approach gate.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and biological burst redirect
source_mechanism: sensor-gated half-cycle amplitude asymmetry released by measured turn response
transferable_invariant: when a bounded static redirect has settled but target-relative error still worsens, briefly restore phase-selective steering on the evidenced actuator side
nontransferable_details: published gains, species kinematics, dimensional beat timing, exact vortex phase, and task-specific routes
policy_translation: normalized body-frame distance, projected miss, closing speed, bearing-window trend, joint-state phase, and anterior angle headroom gate one bounded joint-1 half-cycle residual
falsification: reject if it does not cross 0.75L, disturbs the far carrier, destroys wake coherence, increases limit residence or loads materially, or repeats the same high-speed pass-by
