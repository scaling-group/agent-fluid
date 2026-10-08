# Wake-policy candidate notes

## Evidence diagnosis

- The shared prewarm sheet is byte-identical across all four sampled solvers.
  It shows the held fish above and downstream of four developed, interacting
  vortex streets, so differences after release are controller effects under a
  common initial condition.
- Every sampled solver reaches the `0.75L` target, and each released sheet
  shows self-propelled motion: a rapid clockwise redirect is followed by a
  coherent leftward traverse into the mixed second-row wake. The slower
  bearing-scheduled policy takes `46.035` time units, has `2.0695L` mean
  distance, and uses `1237.1` mean command energy. Its path is productive but
  spends an extra keyframe completing the redirect and traverse.
- The strongest sampled policy adds joint-state-gated half-cycle steering to
  the same oscillator, course-slip correction, and raw-bearing authority
  scheduler. It preserves the route topology while reaching in `36.471`,
  reducing mean distance to `1.6860L` and total command energy to `48700`.
  The improvement is therefore a useful propulsion/turn coupling rather than
  passive advection: mean upstream velocity increases in magnitude from about
  `0.238` to `0.298`, while the fish continues to shed a coherent body wake.
- The speed gain is not free. RMS lateral force/moment rise from
  `51.40/761.46` to `63.59/953.42`, and both candidates touch the `30.0`
  acceleration and joint-speed limits. The present candidate may reproduce
  that measured arrival/load tradeoff but must not claim load relief.
- The assigned parent's latest inherited log is the informative failure:
  despite low mean command energy (`503.4`) and low RMS force/moment
  (`11.62/328.69`), the fish visibly fails to establish leftward propulsion,
  moves `+2.392L` in x, and exits the right boundary after `18.304` with
  negative progress. Low effort or low wake load cannot substitute for the
  validated upstream traveling-bend route.

## Policy hypothesis

Start from the sampled course-slip/raw-bearing allocator and add only the
validated half-cycle asymmetry. Infer beat phase from normalized joint
velocity, amplify the steering residual during the half-cycle already moving
in the requested turn direction, and weaken it during the opposite half-cycle.
This should preserve mean-curvature sign and the target-relative route while
coupling steering to the propulsive carrier more effectively than a static
residual. No world-frame coordinate, explicit clock, vortex phase, or remote
wake probe is used.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG turning and asymmetric flapping
source_mechanism: target-directed half-cycle amplitude or duty asymmetry
transferable_invariant: preserve the traveling bend while biasing the observed joint-state half-cycle that already supports the requested turn
nontransferable_details: published gains, dimensional beat rates, hardware geometry, species kinematics, exact vortex phase, and task-specific routes
policy_translation: normalize each joint velocity by the oscillator velocity scale and use its bounded alignment with body-frame steering direction to modulate the two acceleration residuals inside the existing envelope
falsification: reject if target capture is lost, arrival is not materially better than 45.727, the coherent upstream path disappears, or force/moment and limit contact rise without a route or arrival benefit

## Scope boundary

The sampled evaluation already establishes this mechanism only for the common
prewarm phase. The new CFD evaluation happens after this worker exits; no
same-worker outcome is claimed. A changed wake phase or layout that loses
capture would falsify robustness, even if this deterministic case remains
fast.
