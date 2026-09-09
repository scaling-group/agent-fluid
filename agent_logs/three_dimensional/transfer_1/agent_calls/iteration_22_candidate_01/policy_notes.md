# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled rollouts and the assigned-parent rollout satisfy the
  direct-uniform still-water contract: `U_infinity=(0,0,0)`, no cylinders, no
  prewarm, and an active moving window. Translation is therefore released-fish
  self-propulsion rather than imposed advection.
- The two sampled exact speed-reserve baselines captured at
  `0.7466--0.7494L` in `18.3205--18.6010T`; inherited guidance establishes a
  `4/4` exact-repeat capture record. The two sampled exact posterior-wave
  policies captured at `0.7480--0.7492L` in `18.1995--18.4690T`, and an
  inherited evaluation adds a third capture at `0.7481L`. Their scores,
  distance histories, clipping, speed residence, and loads overlap the
  baseline rather than establishing a secondary-metric benefit.
- I inspected the combined release-to-termination top-down vorticity and
  oblique Lambda2 sheets for the highest-scoring baseline capture
  (`solver_6b0e320e2f55`), a posterior-wave capture
  (`solver_591f46d260e7`), and the assigned parent's exact posterior-wave
  failure. Both capture policies self-propel with coherent alternating
  mid-plane vortices and compact three-dimensional structures through the
  target crossing. The failed repeat likewise retains an active traveling
  wake through `32.84T`, but bends below the target after its closest pass and
  exits the lower boundary; it is not carrier collapse or instability.
- The exact parent repeat falsifies the posterior mechanism's own stated
  boundary: it reached only `1.3584L`, exited with final distance `10.5799L`,
  and reduced the mechanism's record to `3/4`, versus the baseline's inherited
  `4/4`. It entered the `<2.75L` terminal region with reconstructed projected
  miss about `1.94L`, outside the controller's `1.0L` capture corridor. At the
  closest pass, projected miss remained about `1.35L`, target/velocity
  alignment was about `-0.115` (already receding), and speed was still
  `0.826L/T`. Action clipping remained about `70.3%/71.0%`, force-component
  peaks `0.0147/0.0288`, and moment peak `0.0165`, so more propulsion, a load
  cure, or scalar pulse tuning is not the evidenced response.

## One candidate hypothesis

Restore the exact evaluated `dogfish3d_intercept_guarded_speed_reserve_v1`
policy. This removes only the falsified posterior wave-shape acceleration and
retains the achieved-course route error, intercept release veto,
state-feedback traveling bend, full additive steering, and sparse
outward-carrier reserve that have four inherited exact captures. No cadence,
route, steering, reserve, or actuator scalar is changed.

Expected test: preserve the coherent top-down and oblique wakes and recover a
capture with arrival, clipping, speed-limit residence, and force/moment loads
inside the established baseline envelope. This candidate is an evidence-led
rollback, not a claim that the baseline solves actuator clipping or generalizes
beyond the fixed initial condition.

Falsification: weaken the baseline robustness claim if its next exact repeat
misses, changes far-field closure, weakens the traveling wake, or leaves the
established actuator/load envelope. After such evidence, test a distinct
geometry or response mechanism rather than reviving the posterior pulse by
isolated gain or gate tuning.

bookshelf_consulted: true
source_domain: robotic-fish CPG direction tracking and two-joint asymmetric wave-shape turning
source_mechanism: preserve rhythmic propulsion while a bounded posterior wave-shape perturbation supplies subordinate steering
transferable_invariant: steering perturbations must remain subordinate to the active traveling bend and earn retention through repeatable state-feedback improvement
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, exact body envelopes, vortex phases, and task-specific coordinates or routes
policy_translation: do not retain the shelf-inspired posterior residual after its exact-repeat terminal-path failure; restore the normalized body-frame, two-joint speed-reserve controller without scalar retuning
falsification: reconsider only if independent exact posterior-policy repeats establish reliable capture plus a terminal-path, arrival, load, or actuator benefit without weakening either wake view
