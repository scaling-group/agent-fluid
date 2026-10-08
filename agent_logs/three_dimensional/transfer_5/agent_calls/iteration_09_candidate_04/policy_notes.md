# Hydrodynamic-moment lead terminal-brake candidate

## Visual and quantitative diagnosis before editing

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, stable dynamics,
  and capture. Their top-down rows show self-propelled broad target-directed
  arcs with strong alternating wakes, and their oblique rows show coherent
  paired three-dimensional structures through capture. The policy differences
  remain below the keyframe resolution; no sampled sheet shows carrier breakup
  or a semantic failure. The informative failure boundary is inherited:
  opposite-sign static-posture replacement destroyed the alternating carrier
  and exited the upper boundary, while the same-sign, response-released C-bend
  created the capture topology retained here.
- The strongest progress sample is v24 phase-demodulated terminal course
  braking: capture at `23.8315T`, scoring mean distance `2.434073L`, and a
  `0.746924L` final crossing. Its cost is terminal rotation: peak absolute yaw
  is `3.208 rad/T`; inside `3L`, mean absolute yaw, target-transverse speed,
  lateral-force coefficient, and yaw-moment coefficient are `1.684 rad/T`,
  `0.239U`, `0.011795`, and `0.006402`.
- Hard course/yaw direction consensus (v25) captures later at `23.8590T`
  with mean distance `2.434115L`, while its inside-`3L` yaw, transverse
  speed, lateral load, and moment remain effectively unchanged at
  `1.683 rad/T`, `0.238U`, `0.011768`, and `0.006382`. Selecting the
  terminal bend direction solely from carrier-rejected yaw (v26) is also later
  at `23.8535T` with mean distance `2.434214L` and slightly worse
  inside-`3L` yaw (`1.687 rad/T`) with unchanged transverse speed/load.
  Therefore neither suppressing cue conflict nor flipping the course residual
  into a yaw-selected direction delivered material damping.
- The assigned-parent logs add a compatible negative result: applying the v24
  terminal curvature only on the nominally supporting posterior half-cycle
  captured at `23.9085T` with mean distance `2.434609L`. It reduced peak
  yaw relative to v24 but did not beat the direct-course controller on progress
  or near-target yaw. This rejects another course/yaw/beat gating variant as
  the next architecture and favors an independently measured response signal.
- The normalized hydrodynamic yaw moment supplies that signal. Inside `3L`
  across the sampled policies it correlates `0.935-0.940` with the
  step-to-step yaw acceleration, and moment and yaw acceleration have the same
  sign in `97.2-97.7%` of samples. For v24 the median and upper-quartile
  absolute moment coefficients are `0.00567` and `0.00884`. Thus moment is
  a calibrated near-term yaw-response observation, not a speculative
  world-frame route cue.

## Policy hypothesis

Use sampled v24 as the sole carrier, preserving its traveling-wave oscillator,
same-sign C-bend, response release, carrier-rejected target-course direction,
and smooth acceleration projection. Change only the magnitude response of its
terminal course brake: normalize the already nondimensional body yaw moment,
convert it into a small bounded lead correction to carrier-rejected yaw, and
attenuate that lead near zero route-scale yaw. The existing course residual
continues to select bend direction. Moment therefore anticipates whether the
fluid is increasing or reducing the observed rotation without being allowed to
define the route or cancel the propulsive carrier by itself.

The candidate should preserve v24 capture, wake coherence, and progress while
reducing terminal yaw/moment/load. Falsify the mechanism if capture is lost,
arrival exceeds `23.9T` or mean distance exceeds `2.435L` without a
material yaw/load reduction, if the alternating wake weakens, or if joint
speed and high-command exposure grow. The candidate's CFD result is not
available in this worker and is not claimed here.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: wake-interaction feedback and sensor-modulated robotic-fish carrier/residual control
source_mechanism: preserve the rhythmic propulsive carrier while a small bounded hydrodynamic response signal anticipates route-scale yaw growth
transferable_invariant: separate target-derived course direction from fast measured yaw response, and let the response signal adjust correction urgency without becoming a route command
nontransferable_details: published gains, dimensional frequencies, robot linkage kinematics, species-specific envelopes, exact vortex phase, and prescribed source-task routes
policy_translation: keep normalized body-frame course feedback and the two-joint state oscillator; use normalized moment only as a bounded lead term in carrier-rejected yaw magnitude before the existing proximity-gated terminal bend
falsification: reject if capture or coherent wake topology is lost, or if arrival, distance integral, terminal yaw/course, loads, joint-speed exposure, and command exposure do not jointly justify the moment lead
```

## Non-CFD contract checks

- The material guidance check passes against the assigned parent after removing
  a duplicated identical parent marker from the rendered workspace README.
- The lightweight Julia contract check passes through the workspace's
  `julia-vanda` wrapper; the literal `julia` alias named by the check-runner
  is not installed on this shell's `PATH`.
- Direct `params.FIELD` references are a subset of the fields returned by
  `target_policy_params()`, and the solver boundary check passes.
- Static comparison confirms exact v24 output outside the `3L` terminal gate
  and at zero measured moment. Extreme finite and non-finite moment probes
  produce finite commands within the owned acceleration envelope.
- No CFD rollout was run in this worker.
