# Candidate wake-policy notes

## Evidence and visual diagnosis

- All four sampled L64 rollouts use direct uniform still-water initialization
  (`U_infinity=[0,0,0]`) and terminate in capture at `25.11852T`, with score
  `-0.5283387731`, mean distance `2.429294L`, and final distance `0.746410L`.
  Their trajectory rows and actions are identical. Three policies are the v23
  coordinated response-release controller; the prefilled v25 source changes
  only its version string and comments, so it supplies no new mechanism.
- The valid combined sheets show self-propulsion rather than advection: a
  coherent alternating top-down wake grows behind a smoothly curving fish, and
  the oblique Lambda2 row retains compact three-dimensional structures from
  release through the terminal approach. There is no cylinder or prewarm
  artifact. One older comparison's oblique sheet is black/incomplete, so its
  identical scalar and trajectory evidence is used only as a replication, not
  as visual wake evidence.
- The outer carrier is productive and should remain untouched. Inside `4L`, the
  shared equilibrium removes joint-stop dwell and large loads, then the paired
  tracking-error release yields the best inherited compact capture. On the
  replicated path, curvature error becomes settled for roughly 65% of the
  inside-`4L` samples. During that band, target bearing remains large (mean
  about `0.94 rad`) while body-relative lateral flow is usually target-helpful:
  its mean is about `-0.232 U`, and it has the helpful sign in about 95% of
  samples. Near capture it remains about `-0.266 U` while commands have fallen
  to roughly `0.09/0.24 rad/T^2`. Thus a useful body/wake response exists after
  equilibrium formation but the current handoff does not observe it.

## Policy hypothesis

Keep the proven outer traveling-wave carrier, range preview, shared terminal
curvature equilibrium, and amplitude-normalized paired release unchanged. Add
one independently active terminal response mechanism: when the bounded
target-relative redirect command and normalized body-relative crossflow have
the same actuation sign (meaning the body is already moving laterally toward
the target), smoothly reduce equilibrium allocation after joint tracking has
settled. This releases both joints together farther into the already
mean-centered carrier; opposing crossflow leaves the inherited allocation
unchanged. The mechanism is bounded, reflection-equivariant, target-relative,
and uses no time, route, coordinate, or exact wake phase.

Expected result: preserve the pre-`4L` trajectory and coherent wake while
maintaining more terminal traveling-wave authority, reducing the persistent
target-relative turn-response deficit, and producing an equal or earlier,
deeper capture without renewed saturation or load spikes. Reject the mechanism
if it changes the outer path, delays or loses capture, increases mean/final
distance, restores joint-stop or command-cap incidence, increases terminal
force/moment materially, or merely reproduces the parent because its response
gate is dormant.

bookshelf_consulted: true
source_domain: wake-interaction and adaptive swimming
source_mechanism: preserve useful vortex-induced lateral motion instead of indiscriminately cancelling it
transferable_invariant: use the sign and bounded magnitude of observed body-relative crossflow to distinguish helpful lateral response from a response that still needs corrective hold
nontransferable_details: species kinematics, published gains, exact vortex phases, Karman-street synchronization, cylinder geometry, and task-specific routes
policy_translation: after normalized two-joint curvature error settles in the existing target-relative terminal gate, helpful relative crossflow smoothly releases both joints farther into the mean-centered state-feedback carrier
falsification: reject if the cue is dormant, changes the outer trajectory, worsens capture or distance integral, fails to reduce target-relative response error, or restores saturation, joint stops, wake loss, or terminal load spikes
