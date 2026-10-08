# Outer center-intercept steering-relief candidate

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite free-surge/sway/yaw moving-window dynamics, and
  `capture`. They reproduce the same `v40` trajectory and combined keyframe
  sheet byte for byte: capture at `19.684490 T`, score `-0.261384287`, mean
  and final distance `2.151092787 L` and `0.748302400 L`, path length
  `12.951133 L`, and no joint-stop dwell. The nominally different sampled
  course-worsening branch is therefore dormant, not a positive mechanism.
- I inspected the complete combined sheet, including every top-down
  mid-plane-vorticity and oblique body/Lambda2 frame from uniform release to
  capture. The fish visibly self-propels along a compact upper-side arc, sheds
  a coherent alternating posterior wake, and retains finite localized 3D
  structures. There is no passive advection, loop, collision, boundary-exit
  precursor, wake collapse, out-of-plane motion, or instability. The four
  sample sheets are byte-identical, so none supplies a distinct visual failure;
  lower-quality inherited trajectories are the informative control failures.
- The assigned-parent guidance records that changing the posterior phase
  relation is unsafe in this topology. Its phase-lag governor was active on
  `2460/2807` outer states, altered each fixed-trace component by at most
  `0.7072 rad/T^2`, and was equal-state inactive below `4 L`, yet realized CFD
  changed the compact approach into a `31.0127 L` orbit and delayed capture to
  `46.145020 T` with score `-0.915605503`. Similar finite loads and sustained
  speed locate that failure in mean-course control rather than propulsion.
- Inherited sampled results also reject further terminal handoff arbitration:
  allocating more posture during outward response scores `-0.261856310`,
  retaining more carrier in the same response scores `-0.261822240`, and
  adding posture while coupled error is already decreasing scores
  `-0.261806754`, all worse than reproduced `v40`. This is the required
  three-iteration semantic plateau and rules out another terminal or phase
  variant as the present test.
- A fixed-trace reconstruction of the normalized body-frame observations finds
  a different locus. On `202` recorded states from `2.6730` to `15.2405 T`
  and `12.2343` to `4.1781 L`, center translation is speed-supported, closing,
  and inside the existing constant-velocity intercept corridor while the
  body-relative turn request remains substantial. Mean intercept support is
  about `0.719`; these states span the outer approach rather than startup or
  the protected terminal law. The sheet's coherent wake and compact path argue
  for preserving the carrier while testing whether some steering applied
  during an already valid center intercept is unnecessary gait-scale course
  correction.

## Policy hypothesis

Start from the exactly reproduced `v40_intercept_supported_terminal_posture`.
Preserve its state-feedback traveling bend, derivative-defined posterior lag,
geometry/course-agreed saturation allocator, closure preview, damped two-joint
posture, terminal intercept handoff, and command cap. Add one outer-only
translation-confirmed steering relief: when actual range is above `4 L`, center
speed is established, range is closing, predicted constant-course miss is
inside the existing intercept corridor, and large-angle redirect is quiet,
continuously reduce both components of the low-frequency turn residual by at
most a small declared fraction. Do not change the oscillatory carrier, phase
relation, mean-curvature target, cadence, or total acceleration envelope.

This is a new course/state-feedback allocation gate, not scalar-only gain
tuning. It asks center translation to confirm that body-angle steering can be
relieved, using only normalized target geometry, normalized range/closure,
body-frame velocity, and the existing two-joint command. The gate is exactly
zero on the same state at or below `4 L`, at negligible speed, without positive
closure, outside the intercept corridor, or under a full redirect. Expected
behavior is the same wake family and terminal capture with less counterproductive
outer steering, a no-longer path, and equal or earlier arrival. Falsify the
mechanism if it is dormant or effectively constant, changes terminal commands,
weakens a necessary broad turn, alters the compact topology, delays or loses
capture, worsens the distance integral, creates stop dwell or load growth,
causes instability, or degrades either visual wake row. The candidate's CFD
evaluation occurs only after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: closed-loop CPG robotic-fish direction tracking and wake-aware swimming control
source_mechanism: modulate low-frequency direction control from observed translational response while preserving the established rhythmic carrier and useful lateral motion
transferable_invariant: when measured center translation already lies in a closing target-intercept corridor, reduce only a bounded share of steering that shares the propulsive actuators instead of changing the evidenced traveling-wave phase or cancelling the motion
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, full-body waveforms, exact beat or vortex phase, actuator models, target coordinates, capture radius, and task-specific routes
policy_translation: above `4 L` only, combine normalized body-frame course, speed, closure, and target-angle redirect support to relieve a small paired fraction of the existing turn residual while leaving the two-joint carrier and terminal law unchanged
falsification: reject on dormancy, any same-state terminal action, slower or lost capture, worse distance integral, changed compact topology, joint-stop dwell, material load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- Replaying the candidate and sampled `v40` in separate Julia modules on all
  `3579` recorded states changes exactly `202` commands. Every change lies
  between `2.6730` and `15.2405 T` and `12.2343` and `4.1781 L`; all `772`
  recorded states at or below `4 L` remain exactly identical. The maximum
  equal-state component difference is `0.26146 rad/T^2`, so the mechanism is
  active and bounded rather than a hidden broad gain or dormant condition.
- A deterministic `226800`-state grid spanning target range and body angle,
  center-course angle and speed, closure, both joint positions, and both joint
  rates finds `3888` active differences with maximum component change
  `0.23643 rad/T^2`. Every output is finite and within the declared command
  cap, and every changed grid state is above `4 L`, moving, closing, inside the
  intercept support, and outside a full redirect. This establishes activity,
  boundedness, and gate selectivity only, not coupled-flow improvement.
- The prescribed check-runner was invoked after both required evidence files
  changed, but its pinned `gpt-5.4-mini` model is unavailable on this ChatGPT
  account and it failed before executing a check. Running its three configured
  non-CFD commands directly gives PASS for the material-guidance update,
  finite two-output Julia contract, and solver edit boundary. The supplemental
  deterministic schema audit resolves all `89` direct `params.FIELD`
  references against the `90` fields returned by `target_policy_params()`;
  only the version label is intentionally unused. Candidate SHA-256 is
  `657d159ae647afda3ac85b7ecda77b97469f5be47c03430adf7f1156329a89ef`.
  No formal CFD was run in this workspace.
