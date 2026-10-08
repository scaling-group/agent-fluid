# Direction-aware course arbitration

## Evidence and visual diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture. Three are
  exact reproductions of `v37` (identical policy, trajectory, and two-view
  keyframe hashes), capturing at `19.612991 T` with score `-0.282941223`, mean
  distance `2.172435105 L`, and final distance `0.748660505 L`.
- The assigned-parent `v38` course-supported allocator is the strongest score
  sample. It retains capture and improves score to `-0.271582682`, mean
  distance to `2.162124221 L`, and final distance to `0.747272313 L`. It
  crosses `4 L` slightly earlier (`15.614507 T` versus `15.664007 T`) but
  crosses `2/1 L` later (`18.199490/19.618492 T` versus
  `18.089493/19.316000 T`) and captures about `0.385 T` later. Course urgency
  therefore changes the useful trajectory and terminal entry state rather
  than merely making the reproduced carrier stronger.
- I inspected the complete combined sheets for the assigned parent and the
  reproduced contrast, including the top-down mid-plane-vorticity row and the
  oblique body/Lambda2 row from uniform release through capture. Both fish
  visibly self-propel along compact target-directed arcs, shed coherent
  alternating posterior wakes, and retain finite localized three-dimensional
  structures. Neither shows passive advection, a loop, collision,
  boundary-exit precursor, wake collapse, nor out-of-plane instability. The
  assigned parent approaches along the lower side of its local window and
  finishes with a visibly quieter body response; there is no failed
  termination, so the slower/higher-load `v37` reproduction is the informative
  semantic contrast.
- Telemetry supports that visual distinction. Below `4 L`, `v38` reduces
  commands above `30 rad/T^2` from `508/589` to `322/390`, exact
  acceleration-cap samples from `386/531` to `280/327`, joint-rate samples
  above `4.4 rad/T` from `121/123` to `115/75`, and lateral-force/yaw-moment
  maxima from about `0.02692/0.01519` to `0.02485/0.01384`. At capture its
  joint rates and yaw rate are `-1.406/0.659 rad/T` and `0.649 rad/T`, versus
  `-4.498/1.538 rad/T` and `2.858 rad/T` for `v37`. Lower envelope contact is
  meaningful here because it accompanies better integrated and final distance,
  not because clipping count is an independent objective.
- The inherited optimizer logs identify posterior position error as a
  successful allocation cue, reject rate-magnitude attenuation, and propose an
  independently normalized posterior velocity error as a possible
  traveling-bend coordination signal. That proposed mechanism has now been
  evaluated in an inherited log: adding two percentage points of common-scale
  support when position and velocity errors were both high regressed capture
  to `23.859020 T`, score to `-0.431253348`, and mean distance to
  `2.329508832 L`. Its two-view sheet remains finite and wake-coherent, but
  shows a long lateral detour followed by a late curl into the target; below
  `4 L` it has no high commands or high-rate samples. The result rejects using
  phase-space mismatch as another reason to preserve carrier allocation: it
  traded away useful route progress rather than regularizing the winning wave.
- The validated `v38` selector has a narrower unresolved semantic ambiguity.
  Its normalized miss is `abs(sin(course_error))`, so velocity exactly
  opposite the target ray receives zero course support just like velocity
  exactly toward the target. The assigned-parent trace contains `123` outer
  samples with negative target-course alignment. A pre-finalization same-state
  replay showed that merely taking the maximum of the inherited cross-track
  support and an opposition-only support is nevertheless dormant on both
  distinct sampled traces: cross-track support is already saturated wherever
  opposing motion intersects active allocator distortion and lag. Later
  workers should not mistake observation incidence for command-level activity.
- The non-dormant semantic test is to replace the folded cross-track magnitude
  only for outer arbitration with target-course direction error normalized by
  a right angle. The measure grows monotonically from targetward to lateral
  motion and remains fully urgent for all opposing motion. With the inherited
  normalized support bands it also withholds route priority from moderately
  misaligned but still strongly closing courses, testing whether that subset
  caused `v38`'s slower `2/1 L` crossings while preserving severe-error
  correction. The predicted cross-track miss remains unchanged in the already
  validated terminal intercept law.

## Policy hypothesis

Preserve the evaluated `v38` oscillator, target-relative guidance, redirect
equilibrium, terminal law, limiter authority, response-exclusive allocation,
translation support, and cross-track terminal intercept. Replace only the
outer course-miss selector with one direction-aware route-urgency measure from
the already computed normalized
body-frame dot product between target ray and center velocity. Normalize its
bounded angular error by a right angle, saturate for opposing motion, and use
the inherited smooth support bands to transfer the same exclusive response
increment toward the existing bounded target residual. No allocation fraction
is increased; the terminal intercept metric is untouched; and the existing
outer and motion gates keep the change exactly dormant at and below `4 L` or
without established translation.

The expected benefit is to preserve `v38`'s better distance integral and quiet
capture state while recovering useful carrier allocation on moderately
misaligned, positively closing states and correcting the anti-target ambiguity.
Falsify the implementation on a dormant direction-error branch, changes to
terminal or zero-translation same-state commands, nonfinite or over-limit
output, or dependence on turn side. Later CFD
should reject it on lost/delayed capture, worse score or mean distance, loss of
the compact path, renewed stop dwell or material load growth, instability, or
degradation of either wake view. The new CFD evaluation occurs only after this
worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated coupled-oscillator robotic-fish path following
source_mechanism: preserve rhythmic inter-joint coordination while observed route-direction error selects when bounded low-frequency target correction receives actuator priority
transferable_invariant: route urgency must distinguish targetward, cross-track, and anti-target translation monotonically; a normalized target-course direction error supplies that ordering without a world-frame route
nontransferable_details: published gains, dimensional cadence, full-body waveforms, species-specific envelopes and kinematics, exact phase or vortex timing, actuator models, target coordinates, capture geometry, and task-specific routes
policy_translation: retain predicted cross-track miss for terminal interception, but use body-frame target-course angular error normalized by a right angle as the monotonic outer support that transfers the same bounded priority to the existing target residual
falsification: reject on a dormant or unbounded branch, terminal or zero-translation same-state interference, slower or lost capture, worse distance integral, changed useful topology or mean bend, renewed stop dwell or material load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- Reconstructing policy observations on the two distinct sampled trajectories
  changes `545` stored `v38` outer states and `525` stored `v37` outer states,
  with maximum same-state command differences of about `2.603` and
  `2.385 rad/T^2`. Every reconstructed state at or below `4 L` is
  parent-identical, and the change is concentrated on positively closing,
  moderately misaligned courses for which the new monotonic error withholds
  some residual priority; the opposing-course states were already fully
  supported by the inherited allocator when it was active.
- A deterministic `124,740`-state grid spanning target range, target side,
  relative course direction, translation speed, and both joint positions and
  velocities has `25,412` active cases. All outputs are finite and within the
  declared acceleration limit, and every state at or below `4 L` and every
  zero-translation state is exactly parent-identical. These checks establish
  activity, boundedness, and same-state terminal/motion dormancy, not a coupled
  CFD improvement or unchanged downstream entry state.
- The lightweight Julia contract returns two finite accelerations inside the
  declared envelope. The deterministic schema audit resolves all `87` direct
  `params.FIELD` references in the `88`-field object returned by
  `target_policy_params()`; only the version label is intentionally unused.
- The prescribed check-runner was invoked after the edits, but its pinned
  `gpt-5.4-mini` model is unsupported on this ChatGPT account and failed before
  executing a command. Its exact material-guidance, lightweight Julia
  contract, and solver edit-boundary checks were then run directly and
  separately; all pass. No formal CFD was run in this workspace.
