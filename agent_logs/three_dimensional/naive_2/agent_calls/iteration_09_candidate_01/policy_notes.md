# Candidate wake-policy notes

## Evidence and visual diagnosis before editing

- The four sampled solver evaluations and the two inherited optimizer
  evaluations inspected here all report direct-uniform still water,
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. In the combined sheets,
  their top-down rows show body-connected alternating vorticity and their
  oblique rows show coherent three-dimensional Lambda2 structures. Translation
  is self-propelled; no sampled failure is explained by passive advection or a
  missing propulsive wake.
- The sampled full-circle policies establish a repeated negative result. The
  mean-bend release reaches `2.664L` with `0.488/0.220` peak normalized planar
  force/moment but leaves the posterior joint above `40 deg` for `6.349T`.
  Posterior-bend release cuts that dwell to `0.930T` yet regresses to `3.312L`
  and raises the peaks to `0.890/0.414`. The straighter phase-separated sample
  has the best scalar score (`-7.405`) but only reaches `4.650L`. Release gates
  and scalar ranking therefore do not identify a capture mechanism.
- The assigned parent's reverse-half-cycle reserve also fails its recorded
  falsifier. Its visual rows retain the coherent carrier, but its capped
  half-cycle controller reaches only `2.937L`, then follows a nearly straight
  escape to the left edge with `9.264L` final distance and score `-10.506`.
  Preserving an opposed half-cycle prevents algebraic cancellation but does
  not by itself provide the missing terminal course correction.
- The sampled optimizer's course-residual controller is the strongest useful
  trajectory despite its poor terminal score. Its top-down sheet visibly
  passes close to the capture sphere, the oblique row retains a compact
  alternating wake, and diagnostics show a `1.173L` near miss at `16.720T`,
  zero joint dwell above `40 deg`, and only `0.034/0.017` peak normalized
  planar force/moment. It then exits the lower-left boundary at `28.243T` with
  `10.560L` final distance.
- The course-residual trace explains the miss. Between `2.78L` and `1.22L`,
  speed remains about `1.05L/T`; at `1.22L` the target/course error is already
  about `0.96 rad`, and half a time unit later it is about `2.07 rad` while
  closing speed has reversed. At closest approach the head is
  `(9.539,8.458)L`, below the target, and velocity is `(-0.717,-0.739)L/T`:
  the fish is moving down-left while the target lies up-left. The far-field
  response signal produced the best approach, but its beat-scale half-cycle
  actuator did not create a stable mean bend soon enough inside about `3L`.

## Single candidate hypothesis

Preserve the evidenced course-residual steering, full traveling-bend carrier,
and posterior lag outside the terminal region. Inside a smooth body-frame
distance gate, transfer steering authority continuously from instantaneous
course half-cycle asymmetry to a bounded target-bearing mean-curvature shift.
Implement the shift as the equilibrium of the anterior oscillator and the
center of the lagged posterior target, rather than as an additive static
acceleration. This keeps an alternating traveling bend around a small signed
mean and avoids every inherited bend-threshold switch, reverse-cap edit, and
world-frame route cue.

The new mechanism is supported by capture, or more weakly by retaining the
`1.173L` approach while producing a target-side return arc or better
termination without joint-limit dwell or load growth. It is falsified by a
closest approach above `1.173L`, another lower-left escape, loss of the
alternating wake, any persistent `40 deg` joint dwell, or force/moment peaks
materially above the course-residual `0.034/0.017` reference without capture.

bookshelf_consulted: true
source_domain: robotic-fish sensor-modulated CPG direction tracking and classical fish/robot mean-curvature turning
source_mechanism: retain an undulatory carrier while persistent target geometry shifts its mean curvature through a bounded feedback channel
transferable_invariant: separate the propulsive traveling wave from a slowly varying target-signed mean bend, and return continuously to the unbiased carrier when the terminal error clears
nontransferable_details: published controller gains, robot linkage geometry, species-specific bend envelopes, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame distance to hand off from target/course half-cycle steering to a small full-circle target-bearing shift of both two-joint carrier equilibria
falsification: reject if the 1.173L approach is lost, the lower-left escape remains, joint or load occupancy worsens, or the coherent alternating wake collapses

## Dry validation only

A `202,500`-state grid over joint angles/rates, full-circle target geometry,
distance, and translational velocity produced finite commands strictly inside
the smooth `30 rad/T^2` envelope and exact left/right reflection (maximum
error `0.0`). On a far-field grid the action differs from the course-residual
parent by at most `7.11e-15`; a `0.01L` sweep across the terminal gate has a
maximum action step of `0.085 rad/T^2`, and the geometrically indeterminate
directly-aft state remains unbiased. The configured contract, parameter schema,
guidance materiality, and editable boundary are checked separately. No CFD was
run; later formal evaluation must decide every physical falsifier above.
