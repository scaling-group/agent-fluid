# Candidate diagnosis and hypothesis

## Evidence diagnosis

- All sampled and inherited evaluations used direct uniform initialization in
  still water (`U_infinity=(0,0,0)`), without cylinders or a prewarm snapshot.
  Their combined sheets were read in release-to-termination order in both the
  top-down vorticity and oblique body/Lambda2 views, then checked against the
  trajectory trace, force/moment histories, command histories, and termination.
- The compact bounded sample `solver_b6bb94d9cdaf` is the strongest finite
  baseline: its alternating wake is coherent, it self-propels at about
  `0.8L/T`, and it improves distance from `12.3277L` to `5.3570L`.  It still
  passes above the target and exits the upper boundary at `21.791T`.  Its
  instantaneous yaw-rate brake reverses the steering request on the beat scale;
  at `16T` the reconstructed body-frame course is about `+0.47 rad` while the
  target bearing is about `-0.66 rad`.
- The sign-flipped transfer `solver_e450df1efa49` preserves an even longer,
  coherent wake and makes the closest sampled pass (`4.1281L`), but stays about
  `4L` above the target during the pass and then exits left.  Its raw actions
  repeatedly exceed the physical acceleration envelope, so its actuator gains
  and branch structure are not a bounded reusable solution.  The inherited 2D
  champion goes the other way, reaching `6.1797L` before a lower exit; together
  they bracket a useful turn sign but not a stable target response.
- The response-release sample `solver_59bc4ebdddec` is bounded and makes
  monotone distance progress to `7.5311L`, yet it also exits through the upper
  boundary.  A short bearing-rate release therefore does not supply a slow turn
  response estimate.
- The assigned-parent evidence and its inherited notes show the sharpest
  failure: `turn_rate_recent` aliases instantaneous `heading_rate` in this
  direct-uniform evaluator, reaches roughly `2--3 rad/T`, and leaves only
  `0.1020L` closest progress before an `8.646T` upper exit.  Two subsequent
  inherited course-geometry policies (`solver_96e85c995765` and
  `solver_eb0b548f8cbc`) changed the normalized course calculation but not the
  mechanism or trajectory class: both retained only a short curved wake,
  improved closest distance by less than `0.86L`, and turned in place into the
  upper boundary near `9.7T`.  Instantaneous body-frame course plus full-cycle
  mean curvature is therefore a concrete repeated negative result, not a
  cycle-scale route estimate.
- Offline phase diagnosis of the admissible traces found that the within-beat
  bearing residual is consistently anticorrelated with anterior joint angle:
  a one-cycle residual fit gives a `q1` coefficient between about `-0.23` and
  `-0.45 rad/rad` across the bounded, inherited, and transferred trajectories.
  A small positive `q1` correction can therefore remove a measured phase
  component without inventing a clock or copying a route.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG asymmetric flapping and Lighthill-style posterior thrust emphasis
source_mechanism: preserve a propulsive oscillator while sensor feedback applies a bounded phase-coherent posterior steering pulse instead of a persistent static bend
transferable_invariant: persistent body-frame target geometry owns steering sign, observed joint phase owns when posterior steering is applied, and translation gates authority so redirection does not erase the traveling wave
nontransferable_details: published CPG gains, clock phase, duty ratios, species-specific envelopes, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: add a bounded anterior-joint phase correction to bearing, retain the joint-state oscillator and posterior lag, and add a speed-gated absolute-midstroke pulse only to the posterior target
falsification: reject if closest distance does not beat the compact baseline, the same upper-exit topology remains, the pulse fails to preserve coherent self-propulsion, or command/joint-limit residence increases

## Candidate hypothesis

The candidate uses one phase-coherent posterior steering mechanism.  The
anterior oscillator is unchanged so it cannot be recentered into a turn-in-place
mode.  A phase-compensated bearing (`bearing + k*q1`) supplies a reflection-
equivariant route sign; steering authority rises smoothly from a small floor as
observed body-frame forward speed develops.  The posterior target receives the
bounded request only near anterior mid-stroke, using normalized `abs(qd1)` as
the state-derived phase gate.  This should preserve the compact sample's wake
and speed while reducing the full-cycle curvature residence that drove the two
inherited upper arcs.  No distance schedule is introduced because no available
rollout reached the `0.75L` capture regime.
