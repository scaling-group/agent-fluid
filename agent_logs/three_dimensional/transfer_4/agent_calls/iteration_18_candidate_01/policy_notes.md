# Candidate diagnosis and hypothesis

## Inherited evidence

- All four sampled rollouts report direct-uniform quiescent initialization and
  capture. The two instances of the current phase-consistent policy are
  deterministic: their policies, combined keyframes, score (`-0.064599`),
  `18.0125T` capture, and `1.950823L` mean score-distance are identical.
- In both visual rows the fish is self-propelled rather than advected: the
  top-down view develops a coherent alternating wake from initially still
  water, while the oblique view shows compact three-dimensional structures
  attached to the bending posterior body and shed downstream. The sampled
  alternatives retain the same wake class, so there is no visual basis for
  changing the established carrier, lag, cadence, or amplitude.
- Removing the local direction-consistency guard (the closure-qualified work
  policy) captures sooner at `17.8695T` but worsens mean score-distance to
  `1.958037L`. The current guard preserves the early speed benefit and improves
  that mean distance, but inherited trajectory analysis reports a wider
  `13.2330L` path, `0.7417L` cross-track excursion, and weaker `0.664` near
  alignment. Thus useful posterior work and route quality remain coupled.
- The weaker consensus-qualified wave-amplitude reserve captures at
  `17.7870T` and follows a straighter route, but its first-`3T` mean
  distance/speed are only `12.220562L/0.2459U` versus
  `12.214593L/0.2519U` for the current work guard, and its mean score-distance
  regresses to `1.959602L`. It does not justify replacing the posterior work
  primitive with amplitude scaling or target-projected translation gating.
- The assigned-parent log contains a further capture at score `-0.080637`, but
  provides neither its policy nor trajectory evidence. It is useful as a
  negative attribution boundary only: its scalar result cannot identify a
  controller mechanism.

## Candidate policy hypothesis

The current phase guard defines posterior tracking error against
`mean_tail_tangent + tail_wave_target`. Consequently, extra velocity-aligned
propulsive work can be admitted or withdrawn according to the slow steering
bias as well as the oscillatory lagged wave. Separate those roles: compute the
guard's normalized tracking work from `tail_wave_target - q2` alone, while
leaving the target-derived mean curvature, half-cycle steering, carrier,
closure qualifier, work sign, and actuator governor unchanged. This is a
single structural change, not scalar gain tuning.

Expected result: retain capture, the coherent two-view wake, first-`3T`
closure, and the best mean-distance class while reducing path/cross-track or
improving near-course alignment by preventing reserve propulsion from
reinforcing the mean turn. Reject the transfer if capture or early closure is
lost, mean score-distance returns to the unguarded `1.958037L` class, route
metrics fail to improve, load/saturation class increases, or either wake view
loses its traveling-wave coherence.

bookshelf_consulted: true
source_domain: Lighthill elongated-body propulsion and robotic-fish/CPG turning
source_mechanism: posterior-lagged traveling-wave work separated from bounded mean-curvature steering
transferable_invariant: qualify phasic posterior propulsion against the lagged oscillatory target while allowing slow target-derived mean curvature to steer through a separate feedback path
nontransferable_details: published gains, species-specific envelopes, dimensional frequencies, exact vortex phases, full-body kinematics, and task-specific routes
policy_translation: use normalized posterior joint angle and rate to reference the work guard to `tail_wave_target - q2`, retaining body-frame target feedback and the two-joint acceleration contract
falsification: reject if capture, early or mean-distance benefit, load class, or two-view wake coherence degrades, or if path/cross-track and approach alignment show no compensating improvement
