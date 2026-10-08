# Wake-policy candidate notes

## Evidence diagnosis before policy edit

- All four sampled solver evaluations and the assigned parent's post-exit
  evaluation are valid direct-uniform still-water rollouts
  (`U_infinity=(0,0,0)`, no prewarm), and all terminate in capture. The
  strongest sampled component-matched policy, `solver_1a8c73736b49`, reaches
  capture at `15.686007T` with final distance `0.743392L`, distance integral
  `1.916135L`, and `226` moving-window shifts.
- The combined sheets for that strongest sample and the assigned prefill,
  `solver_5346e761db5a`, show the same useful physical topology in both views:
  the fish self-propels rather than drifting, turns continuously toward the
  target, sheds a coherent alternating top-down vortex street, and retains
  compact oblique Lambda2 structures through capture. Neither view shows wake
  collapse, collision, domain exit, or instability. The prefill's
  `15.697008T`, `1.919504L`, `229`-shift result is therefore a route-scale
  regression rather than a wake failure.
- The sampled moment-only yaw handoff (`solver_a3ebfdcbb7c5`) and redirect-wave
  handoff (`solver_502dfb1f0223`) also capture but score `-0.035331` and
  `-0.035505`, below the persistent component-matched sample's `-0.033442`.
  The assigned parent's more selective component-matched handoff likewise
  preserves the coherent two-view wake and the `15.686007T` capture step, but
  worsens final distance to `0.747417L`, distance integral to `1.920285L`, and
  score to `-0.038396`. Aiding-yaw handoff is thus exhausted as a useful axis:
  even semantically cleaner release logic changes the crossing geometry in the
  wrong direction.
- On the strongest trace, normalized adverse axial load is not rare: positive
  body-axis force occurs on `824/2852` samples, with mean magnitude `0.00199`,
  and those samples carry higher mean absolute posterior demand
  (`26.78 rad/T^2`) than propulsive-load samples (`24.56 rad/T^2`). The wake is
  already coherent, so the open question is whether some of that oscillatory
  demand reinforces an adverse load rather than contributing to translation.

## Policy hypothesis

Start from `solver_1a8c73736b49`, the strongest sampled persistent-response
carrier. Add one response mechanism: when normalized body-frame axial force is
adverse, smoothly blend the posterior action toward a bounded reduced-wave
endpoint while leaving the target-directed mean curvature intact. Zero or
body-forward axial response must reproduce the sampled-best posterior action;
the anterior carrier, navigation gates, positive-force startup allocator,
approach, and terminal response laws remain unchanged. This tests whether
short adverse-load episodes can yield oscillatory headroom without repeating
the failed pre-limit guard, whose predicate had no hydrodynamic-response input.

Falsification: reject adverse-load relief if CFD loses capture or coherent
alternating wake structure, delays established distance milestones or arrival,
raises the distance integral, recreates a sampled trajectory, or lowers command
effort/load residence without route benefit. Also reject it if the response
gate suppresses the zero/adverse-signal base carrier or alters target-directed
mean curvature.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and adaptive wake-interaction swimming
source_mechanism: use measured hydrodynamic response to modulate rhythmic authority without cancelling useful locomotor or steering motion
transferable_invariant: transient adverse load may relieve the oscillatory component while persistent target geometry continues to own mean curvature
nontransferable_details: published gains, dimensional force thresholds, species-specific kinematics, exact vortex phases, cylinder layouts, and task-specific routes
policy_translation: use normalized body-frame axial force to blend between the sampled posterior-wave action and one bounded reduced-wave endpoint, preserving anterior drive and all target-directed mean terms
falsification: reject if capture, milestones, distance integral, wake coherence, or force and joint-limit envelopes regress, or if only command effort changes

## Post-edit static support check

An observation replay over the strongest sampled trajectory (not CFD and not
closed-loop outcome evidence) confirms that the mechanism is neither cosmetic
nor a broad controller replacement. Relative to `solver_1a8c73736b49`, it
changes `280/2852` posterior commands and no anterior commands. The mean and
maximum absolute posterior differences on changed samples are `0.3270` and
`2.9099 rad/T^2`; support spans `0.055-15.340T` and ends before `1.13L`.
Every replayed state with zero or body-forward axial force exactly reproduces
the sampled-best action. Both endpoint actions and their interpolation remain
inside the unchanged acceleration envelope. Formal CFD evaluation is deferred
to EvE, so this scope check makes no performance, wake, or load claim.
