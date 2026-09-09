# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled evaluations report direct uniform still-water initialization
  at `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their translation and
  wakes are self-generated rather than ambient advection.
- Both visual rows were inspected for every sample. The best-score compact
  controller, `solver_b6bb94d9cdaf`, has a coherent alternating mid-plane wake
  and organized oblique Lambda2 structures through termination. It self-propels
  from `12.3277L` to `5.3570L`, but climbs above the target and exits the upper
  boundary at center `(8.6493,15.2024)L`; its short-window yaw-rate brake does
  not provide persistent route correction.
- The aligned-curvature sample `solver_ae0c621b2f7d` is the most useful failure.
  Making the anterior and posterior steering signs agree preserves the same
  coherent wake and improves closest approach to `2.5794L` at `19.88T`, near
  `(9.1298,12.1591)L`. It nevertheless remains about `2.66L` above the target,
  passes left, and exits at `29.47T` with final distance `8.7363L`. Its
  instantaneous recent-yaw brake still sees beat-scale rates (for example,
  about `-2.15 rad/T` at `20T` and `+3.63 rad/T` at `28T`), while acceleration
  requests reside above 95% of the envelope on roughly 25%/41% of rows.
- The response-release sample `solver_59bc4ebdddec` retains the propulsive wake
  but repeats the upper exit after only a `7.5311L` approach. The current
  branch-heavy prefill `solver_e699ec5c28f1` supplies the opposite bracket: it
  turns downward, reaches `6.1797L`, reverses progress, and exits the lower
  boundary at `10.5957L`, with raw accelerations above 95% of the envelope on
  roughly 72%/78% of rows.
- The assigned-parent guidance and inherited log add a decisive negative test:
  a normalized instantaneous target/course cross-product changed sign across
  early beats, curled before translation, and exited above after improving only
  to `11.4731L`. Normalized velocity direction and short-window yaw/bearing
  response are therefore not suitable owners of the slow route in this lane.

## Policy hypothesis

Preserve the compact joint-state oscillator, posterior lag, distributed
curvature sign established by the `2.5794L` trajectory, and smooth acceleration
bounds. Replace the branch-heavy prefill and all instantaneous rate/course
feedback with one line-of-sight mechanism: a complete normalized body-frame
target angle fixes the steering sign, while unnormalized forward body speed is
used only as a nonnegative authority gate. Low authority at release lets the
traveling wave establish propulsion; authority then rises without allowing
beat-scale lateral velocity to reverse the route command. The full target angle
also remains signed after the fish passes the target, unlike a folded bearing.

Expected result: retain the organized alternating wake, avoid the prefill's
lower overturn and the inherited course controller's early curl, and correct
downward before or immediately after the above-target pass. A useful result is
a closest approach below `2.5794L`, capture, or a meaningfully better
termination trajectory without increased joint/action-limit residence.
Falsify the mechanism if it curls before forward speed develops, repeats the
upper or lower exit without contracting line of sight, loses wake coherence,
or worsens actuator/load histories.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and classical fish mean-curvature turning
source_mechanism: preserve a propulsive rhythm while bounded body-relative direction error modulates a slower average bend
transferable_invariant: separate joint-state rhythm generation from normalized target steering and gate strong steering until the propulsive carrier has observable forward authority
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, exact vortex phases, full-body waveforms, and task-specific routes
policy_translation: use the full normalized body-frame target angle to sign a bounded distributed two-joint mean bend, with smooth authority from forward body speed and no normalized course or short-window rate term
falsification: reject if early curl or either sampled boundary-exit topology persists, closest approach does not improve, the alternating wake collapses, or joint and load histories worsen
