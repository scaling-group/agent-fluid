# Evidence-backed posterior acceleration-reserve candidate

## Visual diagnosis and completed evidence

- All four sampled rollouts report direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their translation
  and wakes are controller-generated, not ambient advection or moving-window
  transport.
- The sampled capture is the strongest finite evidence. Its top-down row keeps
  an alternating vorticity street to the target, while its oblique row retains
  three-dimensional Lambda2 structures through the final approach. It captures
  at `0.749826L` and `18.265T`; peak swimming speed is `1.329U` versus only
  `0.032U` peak local flow. This is active self-propulsion and steering, not a
  favorable still-water drift.
- The three sampled failures are useful controls. The distance-conditioned
  carrier hold reaches only `3.592L`, the anterior half-cycle stiffness edit
  reaches `4.859L`, and the assigned parent's phase-sway-compensated course
  observation reaches `4.459L`; all preserve visible alternating shedding but
  arc away and terminate at a boundary. The parent's fitted joint-rate
  cancellation also reduces peak speed to `0.902U` and leaves raw acceleration
  exceedance near `54/67%`. A single-rollout velocity/joint-rate correlation is
  therefore not a causal translation-course correction.
- Inherited logs establish the mechanism sequence behind the successful sample.
  Raw body-frame target-ray versus measured velocity-course feedback was the
  first controller to move the repeated `2.96--2.99L` upper-hook floor to a
  `0.857L` left-exit tangent miss. Posterior curvature escalation, carrier
  relief, phase selection, load residuals, and either sign of anterior-center
  shift then remained in the `0.832--0.876L` left-exit band. The sampled
  posterior acceleration-reserve policy is the first completed continuation to
  cross the `0.75L` capture boundary.
- The capture trace is consistent with allocation, rather than higher nominal
  curvature, being the useful change: it retains the `12 deg` posterior mean
  target and the same zero-centered anterior carrier, while raw posterior
  acceleration stays inside `1800 deg/T^2` for every sample below `3L`.
  Posterior angle nevertheless reaches the `45 deg` stop at capture, so this
  single success supports transferring the mechanism but not increasing its
  curvature, reserve fraction, or terminal drive.

## Policy hypothesis written before the solver edit

Replace the failed assigned-parent phase-sway cancellation with the completed
capture controller. Preserve the normalized full-quadrant target ray, raw
body-frame velocity-course error with a low-speed bearing blend, zero-centered
anterior Van der Pol oscillator, lagged posterior carrier, damping, and bounded
`12 deg` mean-curvature request. Below `6L`, smoothly blend toward the sampled
posterior allocation: soft-bound the carrier inside the part of the existing
acceleration envelope not occupied by a bounded `35%` target-signed steering
reserve. This changes how two demands share the fixed actuator, not the
physical limit, route, episode, morphology, or environment.

The expected signature is reproduction of the sampled coherent approach and
capture, with no raw posterior acceleration exceedance inside `3L`. Falsify the
transfer if it loses the alternating 3D wake, fails to reproduce capture or at
least the inherited sub-`1L` topology, becomes persistently one-sided, raises
limit occupancy, or reaches the posterior angle stop substantially before the
capture crossing. The sampled gate and reserve are one-task evidence, not
universal gains.

```text
bookshelf_consulted: true
source_domain: constrained traveling-wave propulsion, sensor-modulated robotic-fish direction tracking, and terminal capture control
source_mechanism: preserve the rhythmic propulsive scaffold while continuously allocating bounded actuator authority to a slower target-course correction near capture
transferable_invariant: when a propulsive carrier and persistent steering request share a saturated actuator, reserve part of the fixed envelope for corrective work instead of increasing nominal curvature or the physical limit
nontransferable_details: published gains, robot linkage geometry, species-specific gait envelopes, dimensional cadence, clock phase, exact vortex phases, source actuator ratings, and task-specific routes
policy_translation: retain normalized target_body_L versus velocity_body_U course feedback and the two-joint state-feedback carrier; use normalized distance to blend the posterior command into a soft-bounded carrier plus a turn-request-aligned share of the existing acceleration envelope
falsification: reject if capture or the sub-1L trajectory is not reproduced, alternating 3D shedding degrades, effort becomes persistently one-sided, limit occupancy rises, or posterior angle saturation occurs materially before capture
```
