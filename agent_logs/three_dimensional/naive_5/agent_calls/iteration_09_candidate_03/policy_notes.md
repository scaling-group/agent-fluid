# Predictive approach-entry candidate

## Visual and trace diagnosis before the edit

- All sampled and inherited step-8 evaluations are contract-valid direct-
  uniform still-water rollouts (`U_infinity=(0,0,0)`, no cylinders, no
  prewarm). Their top-down vorticity rows show body-attached alternating wakes,
  and their oblique Lambda2 rows show coherent three-dimensional trails. The
  translation and terminal miss are therefore self-propelled controller
  behavior rather than imposed advection or moving-window transport.
- The assigned parent, `solver_8097d423c0eb`, preserves the broad downward
  approach and coherent wake but misses capture at `0.829828L`, only
  `0.079828L` outside the radius, before exiting left. This is not a meaningful
  improvement over the inherited joint/yaw-released redirect's `0.8307L`
  minimum: the difference is less than `0.001L`, the termination and trajectory
  topology are unchanged, and the head still passes left and above the target
  at about `0.66L/T`.
- The sibling `solver_958c9a496ff3` also retains the same visible wake and
  downward-then-left topology, but its proximity/miss-conditioned redirect-
  frequency increase worsens the minimum to `0.870123L`. Together these runs
  falsify further scalar tuning of terminal redirect release or response speed
  as an evidence-backed next step. They do not falsify the sampled two-joint
  redirect, which is still the only mechanism class to reach the capture
  neighborhood without the load spike of posterior half-cycle redistribution.
- The parent trace identifies an earlier semantic gap. On its first crossing
  of `2.25L`, speed is `0.651L/T`, closing speed is `0.531L/T`, and projected
  miss is already `1.217L`, but the bearing-only redirect-entry gate is only
  `0.013`; at `1.75L`, projected miss remains `1.218L` while entry is only
  `0.189`. The base release gate is zero at both points, so neither terminal
  release veto nor faster redirect dynamics can act on the prediction that the
  translating body will skim outside capture. The global intercept-qualified
  failure bounds the remedy: course prediction must not engage a static bend
  at range, where that policy stayed high and reached only `4.278L`.

## Policy hypothesis

Preserve the assigned parent's state-feedback carrier, posterior lag,
calibrated turn side, bounded same-sign redirect, and complete terminal release
logic so the causal comparison changes only entry. Add one new feedback
semantic: inside a smooth body-length approach zone only, let projected miss
supplement large bearing as a redirect-entry condition. Combine the two entry
conditions as a bounded union, then leave yaw/bend response and the parent's
local release qualification fixed. This makes course prediction useful before
bearing has grown while preventing a far-field static-bend latch and preserving
the rhythmic carrier outside approach.

Expected evidence is the same coherent downward trajectory with earlier
positive yaw response between roughly `2.25L` and `1.5L`, followed by a first
crossing inside `0.75L`. Falsify the mechanism if it does not beat `0.829828L`,
raises the target-neighborhood crossing, recreates a high-corridor latch,
breaks the alternating 3D wake, touches the angle boundary, or materially
increases the redirect class's force, moment, or actuator-limit residence.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and fish-inspired terminal capture scheduling
source_mechanism: engage a bounded target-directed maneuver from sensed course error before a large heading error accumulates, while measured bend or yaw response still releases the maneuver back into rhythmic propulsion
transferable_invariant: when target-relative motion predicts a miss before bearing grows, predictive course error may supplement maneuver entry locally; entry and release are distinct semantics, so the established release architecture should remain fixed for an interpretable mechanism test
nontransferable_details: published gains, robot linkage geometry, species-specific bend timing and envelopes, clocked CPG phase, dimensional cadence, exact vortex phases, world coordinates, and task-specific routes
policy_translation: inside a normalized target-distance gate, form projected miss from body-frame target and velocity vectors and union its bounded gate with the existing bearing entry; preserve joint-state phase, two-joint redirect targets, and all assigned-parent release feedback
falsification: reject if the rollout does not beat 0.829828L, changes the far-field trajectory, produces a static-bend latch, or worsens wake coherence, loads, angle contact, or speed/acceleration-limit residence

## Non-CFD implementation audit

Replaying the assigned parent and candidate on the frozen
`solver_8097d423c0eb` states gives exactly zero command difference at and beyond
`2.50L`. The new entry is active inside approach and reduces frozen-state
acceleration-clamp samples through the parent's closest approach from `1719`
to `1708`. Direct checks at zero speed remain finite, and reflected target,
velocity, yaw, and joint states negate both accelerations exactly. These checks
verify locality, activity, boundedness, and symmetry only; they do not predict
the unevaluated CFD trajectory or establish improvement.
