# Wake-policy candidate notes

## Evidence diagnosis

- Reviewed all four assigned solver examples, their score records,
  `wake_observation.md`, `wake_metrics.csv`, `wake_diagnostics.json`, detailed
  trajectories, and both rows of the combined keyframe sheets. All runs used
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm. Each captured at `0.746962L` in `16.043510T` with
  score `-0.058311` and the same `8/6/4/2L` crossing times. The top-down and
  oblique sheets are byte-identical across the samples, so the current sample
  set contains no distinct visual failure; the informative failure comparison
  is limited to the inherited upper-exit and U-turn metrics in guidance.
- The fish is self-propelled, not advected: distance falls monotonically after
  the initial transient, while the background is quiescent. Top-down vorticity
  is weak and compact at `3T`, becomes an alternating trailing street by `6T`,
  and remains coherent through capture. The oblique Lambda2 row likewise shows
  only a small nascent structure at `4T`, then distinct three-dimensional
  trailing structures at `12T` and capture. There is no visible collision,
  wake breakup, or instability before termination.
- The trajectory quantifies the slow wake-development interval: distance moves
  only from `12.328L` to `12.306L` by `1T`, `12.201L` by `2T`, and `12.002L` by
  `3T`; sustained forward response follows. On the inherited trace, body-frame
  forward speed is below `0.25U` throughout the first `2T` and for `87.4%` of
  `2-3T`, but never below `0.25U` after `4T`. This isolates a response-defined
  carrier build-up deficiency without using elapsed time.
- Two samples apply exact joint-speed-boundary anti-windup and two do not. The
  projected and unprojected runs have identical capture, distance milestones,
  joint extrema, force peak (`0.039257`), moment peak (`0.019447`), and visual
  wake. Projection only lowers mean absolute commanded acceleration from
  `23.452/25.514` to `23.294/24.871 rad/T^2`. It is useful effort hygiene but
  supplies no further route or arrival improvement to tune at that boundary.

## Policy hypothesis

Add one response-gated carrier mechanism: while measured nonnegative
body-frame forward speed is below `0.30U`, smoothly increase only the Van der
Pol amplitude-growth coefficient. Release the boost continuously at `0.30U`.
This preserves the carrier's equilibrium amplitude, frequency, posterior lag,
all target-steering structure, and the evaluated exact-limit projection. It
should grow the already successful traveling bend and coherent wake earlier,
then become exactly inactive on the mature sampled trajectory. A fixed-trace
calculation is only a scope check, not outcome evidence: the gate changes the
anterior command through approximately `3.76T`, with a mean absolute change of
about `0.76 rad/T^2` and maximum below `2 rad/T^2` for the selected boost.

Expected test: preserve capture and wake coherence while advancing early
distance progress and the later milestones. Reject the mechanism if the wake
becomes disorganized, lateral excursion or loads grow materially, any milestone
or capture regresses, the velocity gate repeatedly chatters after propulsion is
reliable, or the anterior carrier fails to return to its inherited limit cycle.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG control
source_mechanism: sensor-feedback modulation of oscillator amplitude while preserving a coupled propulsive rhythm
transferable_invariant: strengthen carrier amplitude growth only while measured translational response is weak, then release the modulation continuously when propulsion becomes reliable
nontransferable_details: published oscillator gains, clocked phases, robot geometry, dimensional speeds, species kinematics, and task-specific routes
policy_translation: use nonnegative normalized body-frame forward speed to gate a bounded increase of the anterior state-feedback oscillator's amplitude-growth coefficient; retain the existing posterior joint-state lag and target-feedback law
falsification: reject if earlier wake formation does not advance distance milestones, if capture is lost or delayed, or if wake coherence, joint limits, or load histories regress
