# Outer posterior-divergence coupling candidate

## Evidence diagnosis

- All four sampled evaluations are valid direct-uniform still-water runs and
  capture at `19.684490 T` with score `-0.261384287`, mean distance
  `2.151092787 L`, final distance `0.748302400 L`, and `243` moving-window
  shifts. Their trajectories and combined keyframe sheets are byte-identical.
  Three sampled policies are byte-identical `v40`; the fourth is the `v41`
  signed course/yaw branch whose extra `max` selector remained dormant. Thus
  the samples reproduce one physical trajectory rather than four independent
  controller responses.
- In the combined top-down row, the fish self-propels along a compact target
  approach and develops a coherent alternating wake by `8--12 T`; it is not
  passively advected in the declared zero inflow. The oblique row shows finite,
  localized Lambda2 structures following the body rather than diffuse or
  domain-filling instability. The final frames show a curved but quiet posture
  gliding through the capture circle, not a collision, exit, or wake collapse.
- The trajectory cross-check agrees with the views: distance is nearly
  monotone (only `0.00667 L` total sampled backtracking), center path length is
  `12.951133 L`, final speed is `0.79618 L/T`, and the final commands are only
  about `0.034/1.204 rad/T^2`. The unresolved load is outer allocation: above
  `4 L`, the stored trace exceeds `30 rad/T^2` often while the coherent bend
  remains productive. The assigned-parent and inherited branches show that
  terminal joint-error/course-yaw selectors regress or stay dormant, while
  directly shortening posterior lag can turn the compact path into a long
  loop. Therefore this candidate protects the complete `v40` terminal law and
  does not change the lag target.

## Policy hypothesis

Use the signed power of the existing normalized posterior tracking error as a
feasibility observation. A posterior joint moving away from its already
declared traveling-bend target while the two-joint command is being distorted
by clipping is evidence for a little more common-vector limiting; a joint
moving toward the target receives no added coupling. This is an outer-only
allocation gate, not a new gait, target bias, or gain-only cadence change.
Reconstruction on the reproduced trace finds simultaneous posterior divergence,
direction distortion, and lag support in `519/2807` states above `4 L`; the
distance gate makes the addition exactly zero throughout the validated
terminal regime.

bookshelf_consulted: true
source_domain: classical elongated-body fish swimming
source_mechanism: preserve a directed posterior-lagged traveling bend instead of allowing saturation to turn it into a reciprocal or direction-distorted joint motion
transferable_invariant: posterior motion should continue propagating toward its coupled bend target; observed divergence under clipping is a feasibility cue for coordinated allocation
nontransferable_details: published species envelopes, dimensional beat frequencies, oscillator gains, exact body-wave phase, tail amplitudes, and task-specific routes
policy_translation: normalize posterior target error by drive amplitude and posterior velocity by amplitude-times-state-derived frequency; when their product shows error growth, add a bounded outer-only share of the existing two-joint common-scale limiter
falsification: reject if the branch is dormant, changes any command at or below 4 L, delays or loses capture, reproduces the inherited loop, weakens distance progress or wake coherence, increases joint-stop dwell or material loads, or perturbs the quiet terminal posture

## Candidate boundary

The new branch may add at most `0.02` to the existing response-conditioned
coupling fraction, only after smooth normalized divergence support and the
pre-existing direction/lag gates. It does not alter the oscillator equilibrium,
posterior lag, target residual, acceleration ceiling, terminal posture handoff,
or any environment quantity. CFD outcome is intentionally not claimed here;
it becomes evidence only after this worker exits.

## Static verification

- Equal-state reconstruction against sampled `v40` changes `608/2807` states
  above `4 L`, with maximum/mean-active command differences of
  `0.378740/0.140097 rad/T^2`; outputs remain finite and bounded.
- It changes exactly `0/772` reconstructed states at or below `4 L`. The first
  and last active reconstructed states occur at `12.3240 L` and `4.0341 L`,
  respectively.
- The workspace guidance/material-change check, lightweight Julia policy
  contract check, and solver editable-boundary check all pass. No CFD was run.
