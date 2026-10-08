# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the policy edit

- The four assigned examples use direct uniform still-water initialization,
  contain no cylinders, and are exact nominal replicates: their policy,
  trajectory, combined/top-down/oblique keyframe hashes, `3019` control rows,
  `16.604496T` capture, `0.743958L` crossing, `1.998146L` distance integral,
  and `-0.113729` score agree. They are one deterministic control experiment,
  not four distinct wake conditions.
- In the top-down sheet, the fish is nearly stationary while the first compact
  tail vorticity forms, has a finite alternating trail by `4T`, then
  self-propels along a curved target-crossing arc with a connected alternating
  wake through `8--16.6T`. The oblique Lambda2 row agrees: structures emerge
  behind the posterior body rather than arriving as ambient advection, remain
  three-dimensional and tail-connected at `12--16T`, and the body stays
  finite through capture. This is productive self-propulsion, not passive
  transport or a prewarm artifact.
- The useful carrier has a distinct launch deficit. Distance improves only
  `0.040L` by `2T` and `0.315L` by `4T`; the first `0.25L` of progress takes
  `3.823T`. From `4T` onward it closes the remaining `11.269L` in about
  `12.60T`. Early peak planar force/moment (`0.0240/0.0127`) are below the
  rollout peaks (`0.0372/0.0184`), although requested acceleration is already
  near the released limit by `4T`.
- No sampled solver is an informative failure and no failure keyframe sheet is
  packaged in this workspace. The available contrast is therefore the
  inherited completed-failure record: terminal yaw/relief, projected
  interception, line-of-sight/bearing changes, moment residuals, and local
  fluid residualization retained finite or connected wakes but worsened cost.
  In particular, local-fluid carrier subtraction regressed capture from
  `-0.113729/1.998146L/0.743958L` to
  `-0.115121/1.999280L/0.745252L`. That evidence rules out another approach or
  terminal residual and does not contradict a launch-only experiment.

## Policy hypothesis

Preserve the demonstrated anterior oscillator, route geometry, phase-
demodulated response feedback, approach behavior, terminal behavior, and
one-sided speed guard. Add one small posterior launch envelope: when the target
is far and aligned but measured forward speed is low, mildly emphasize the
existing state-derived posterior traveling wave. Release the emphasis
continuously as forward response appears, as approach begins, as alignment is
lost, or as posterior angle headroom closes. This changes one mechanism rather
than retuning the carrier everywhere, is body-frame/reflection-equivariant,
and uses neither elapsed time nor a memorized route.

Expected test: reach the first `0.25L` and `1L` progress thresholds earlier
without changing the established post-launch arc or capture class. Reject the
candidate if the launch interval does not shorten, if it perturbs the route
after forward speed develops, if capture becomes shallower or is lost, or if
joint contact, near-limit residence, force, or moment materially increases.

bookshelf_consulted: true
source_domain: Lighthill-style reactive propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: posterior traveling-wave emphasis with feedback-driven release
transferable_invariant: emphasize the posterior component of an existing traveling bend only while measured propulsive response is deficient, then release it without disturbing slow route feedback
nontransferable_details: published gains, species envelopes, dimensional beat frequencies, exact vortex phases, open-loop launch timing, and experiment-specific routes
policy_translation: multiply only the posterior carrier wave by a bounded gate built from normalized body-forward speed, body-frame bearing alignment, normalized target distance scheduling, and joint-angle headroom; leave mean steering and the anterior carrier unchanged
falsification: reject if early distance thresholds do not improve or if the established capture, wake connection, joint feasibility, effort, force, or moment worsens
