# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the held fish above and downstream of four
  fully developed, interacting vortex streets. It is common initial-condition
  evidence, not candidate-specific wake selection.
- All four sampled solver rollouts are code-equivalent deterministic replays of
  the ungated posterior-half-cycle controller. Their released sheets show an
  immediate targetward redirect, a sustained body-generated traveling wake,
  clear cylinder separation, and one compact diagonal crossing into the
  `0.75L` capture circle. They reproduce capture at `32.472` release time,
  `1.64761L` mean distance, and `68.70/931.60` force/moment RMS. The repeats
  establish fixed-snapshot reproducibility, not robustness across wake phase.
- The assigned parent's three inherited completed rollouts reproduce a
  direction-selective posterior-state headroom gate exactly: the same compact
  route reaches the target at `32.7305` with `1.64927L` mean distance. Relative
  to the ungated samples, the `0.80%` arrival delay accompanies an `18.1%`
  force-RMS reduction (`68.70 -> 56.29`), a `14.1%` moment-RMS reduction
  (`931.60 -> 800.58`), and a smaller posterior peak excursion
  (`0.5834 -> 0.5684 rad`). Mean local and relative crossflow change little,
  so this is load relief along the same wake-crossing topology, not wake
  avoidance or propulsion collapse.
- Both variants still touch the joint velocity and acceleration ceilings.
  Aggregate maxima therefore do not establish reduced saturation residence,
  and effort does not explain the load reduction: the gate's mean command
  energy is only `0.4%` lower while its longer episode makes total command
  energy slightly higher. The inherited
  unrestricted bearing-trend failure erased the traveling bend and exited
  downstream, while a response-gated extra posterior burst arrived later and
  raised loads; neither route-rate feedback nor added posterior authority is
  justified here.
- No failed released keyframe is available in the sampled workspace. Failure-
  topology claims are therefore limited to inherited metrics and notes rather
  than presented as a new visual comparison.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation interpreted through elongated-body posterior reactive propulsion
source_mechanism: sensor feedback yields a turn-congruent posterior half-cycle residual when observed joint motion already consumes gait-scale headroom while retaining the lagged propulsive wave
transferable_invariant: regulate only an optional rhythmic steering residual with normalized actuator state; preserve the persistent traveling base gait and target-signed mean curvature
nontransferable_details: published gains, duty ratios, dimensional frequencies, robot or species kinematics, actuator ratings, exact vortex phases, and source-task routes
policy_translation: normalize posterior speed and prior applied posterior acceleration by oscillator-owned speed and acceleration scales, detect command-motion reinforcement, and smoothly gate only the extra target-helping half-cycle gain
falsification: reject if a repeat or held-out wake loses target capture or the compact diagonal topology, arrival regresses materially beyond the observed 0.80 percent trade, or force and moment do not remain meaningfully below the ungated controller

## Candidate hypothesis

Produce exactly one candidate by promoting the assigned parent's reproduced
posterior-state headroom mechanism. Preserve the filtered body-frame bearing,
bounded total-curvature request, bearing-conditioned `40/60 -> 35/65`
allocation, anterior state-feedback oscillator, posterior lag and damping, and
the `8%` maximum target-helping half-cycle residual.

The gate reads only current posterior velocity and the previous applied
posterior acceleration, normalized by the policy's own gait scales. It yields
the incremental residual only when either state already reinforces the proposed
posterior wave; it never attenuates the unit-gain traveling wave or mean target
steering. The downstream evaluation is a reproducibility test of the inherited
load/navigation trade, not same-worker evidence of improvement, wake-phase
robustness, or reduced saturation residence.
