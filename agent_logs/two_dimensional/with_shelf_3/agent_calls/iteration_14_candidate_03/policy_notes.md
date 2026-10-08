# Multi-Wake Candidate Diagnosis and Hypothesis

## Evidence diagnosis

- The shared prewarm sheet confirms the same held fish and fully developed,
  interacting four-cylinder streets for every candidate. It is common initial
  condition evidence, not a policy difference.
- All four sampled released sheets terminate in target capture; no sampled
  failure sheet exists for the requested success/failure comparison. Each
  successful fish develops a clear traveling bend immediately after release,
  redirects along a compact upper-right-to-lower-left diagonal, enters the
  interacting wake region, and reaches the target without a visible collision
  or domain excursion. Mean head motion is about `(-10.91,-4.24..-4.30)L` and
  mean body velocity exceeds the local streamwise flow magnitude, so the route
  is not passive advection alone.
- The assigned-parent response-release policy is the prefill and the fastest
  sample: capture at `32.1365`, mean distance `1.63696L`, score `0.234607`, and
  force/moment RMS `67.22/907.46`. The posterior-headroom-only branch captures
  at `32.3400` with nearly identical topology and mean distance `1.63773L`, a
  slightly higher score `0.234663`, and lower loads `65.12/888.56`.
- Directly stacking the two branches is a concrete negative interaction. Two
  separately materialized combined policies return the identical capture at
  `32.4555`, mean distance `1.64548L`, score `0.226804`, and higher loads
  `67.83/914.09`. Thus the combination is slower and more highly loaded than
  either constituent even though its sheet still looks compact.
- Every sample reaches `4.53786 rad/time` joint speed and `31.4159 rad/time^2`
  acceleration, so lower episode-average loads do not establish relief from
  hard-limit residence. The available evidence contains no trajectory or
  saturation time series and no failure example; those claims remain open.

## Candidate hypothesis

Keep the evaluated response-triggered release of distributed mean curvature
and the base state-feedback traveling bend. Add the evaluated posterior
headroom signal behind one new smooth arbitration mechanism: its optional
posterior-residual yielding is permitted only to the extent that the
response-release path is inactive. The two reductions therefore cannot both
reach full authority on the same observation. This is an architecture test of
competing gait modulation, not scalar-only tuning.

Expected result: preserve the response-release branch's early redirect and
direct capture while recovering some of the headroom-only branch's load
benefit on segments where verified turn response is absent. Reject the
mechanism if it loses capture, arrives later than both single branches, raises
mean distance or force/moment RMS above the response-release parent, changes
the compact diagonal topology, or increases saturation residence.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG and asymmetric-flapping control
source_mechanism: sensor feedback modulates a small set of bounded gait variables while retaining the rhythmic scaffold
transferable_invariant: coordinate bounded steering modulations from observed response instead of independently suppressing multiple parts of the propulsive wave
nontransferable_details: published gains, hardware dynamics, clock phase, species kinematics, exact vortex phase, and source-task routes
policy_translation: use normalized body-frame bearing history, bearing and heading response, target-vector closure, joint state, and previous action to arbitrate between mean-curvature release and optional posterior-wave yielding under the two-joint contract
falsification: reject if direct capture, distance integral, or compact topology worsens, or if load and hard-limit residence fail to improve relative to the appropriate single branch
