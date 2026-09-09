# Candidate wake-policy notes

## Evidence diagnosis before policy edit

- All four sampled rollouts use direct uniform `U_infinity=(0,0,0)`, form an
  alternating self-generated wake in both the top-down vorticity and oblique
  Lambda2 views, and self-propel leftward. None is passive advection and none
  is a numerical-instability termination.
- The prefilled shared-joint half-cycle policy is the strongest finite example:
  minimum/final distance is `11.347/11.359L`, compared with `11.670/11.731L`
  for posterior half-cycle plus slip, `11.867/11.977L` for posterior-only
  phase scaling, and `12.056/12.207L` for posterior mean curvature. Its action
  cap also holds both commands below about `30 rad/T^2`, whereas unbounded
  mean-curvature variants request up to `95.8--111.7 rad/T^2`.
- The improvement is not semantic: every example exits through the upper
  boundary at `8.79--9.25T`. In the prefill, target bearing crosses from
  `+0.22` to `-0.17 rad` by `4T`, then reaches roughly `-1.54 rad`; center y
  rises from `14.0L` to `15.20L`. Both joint rates repeatedly reach the
  `260 deg/T` hard limit even though acceleration is smoothly bounded. The
  visual sheets show a strong coherent wake curving with the fish, not a wake
  collapse, so the immediate defect is lost steering/phase reserve after the
  initial target crossing rather than absent propulsion.
- The inherited parent correctly prioritized target feedback over carrier gain
  tuning. The sampled descendants further show that posterior-only static
  curvature and posterior-only phase scaling retain the same boundary-exit
  topology, while shared phase-gated asymmetry provides the best progress.

## Policy hypothesis

Preserve the sampled shared-joint half-cycle asymmetry, but drive it with a
normalized line-of-sight course residual rather than body lateral velocity
alone. Add a smooth state-dependent joint-rate reserve barrier before the
existing acceleration saturation. The course residual should retain the
correct initial turn while detecting motion across the target line at large
bearing; the barrier should prevent the propulsive carrier from consuming the
hard rate envelope so the sign-reversing steering request can act after the
target bearing crosses zero. This is an architecture change, not a carrier
gain or route edit.

Falsify the candidate if it loses the alternating traveling wake, fails to
improve on the `11.347L` closest approach, still exits the upper boundary with
both rate limits occupied, or reduces rate occupancy only by eliminating
leftward self-propulsion. A better distance with the same upper-exit topology
is partial evidence, not success.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and asymmetric flapping; classical traveling-wave propulsion
source_mechanism: sensor feedback modulates beat-side amplitude while posterior lag preserves propulsive wave direction
transferable_invariant: keep a posteriorly lagged traveling bend and express a bounded target-directed turn by unequal joint-state half-cycles, with authority released when body response aligns to the target
nontransferable_details: published CPG gains, clock phase, duty ratios, species amplitudes, exact vortex phases, world-frame paths, and task-specific maneuver timing
policy_translation: retain joint-state carrier and shared half-cycle asymmetry; compute feedback from normalized body-frame target and velocity geometry, then protect joint-rate reserve with a smooth state barrier
falsification: reject if wake coherence or leftward propulsion collapses, hard-rate occupancy persists, closest approach does not beat 11.347L, or the upper-boundary exit repeats
