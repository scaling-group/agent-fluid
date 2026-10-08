# Wake-policy diagnosis and candidate hypothesis

## Evidence read before the edit

- The assigned parent guidance is the untouched fresh-lineage guidance in
  `guidance_examples/optimizer_ff6ee4ac1ff1`; there are no inherited optimizer
  notes in this workspace. The only sampled rollout is the transferred clean-B
  2D champion, and the prefilled candidate was byte-equivalent to that sampled
  policy before this edit.
- The evaluation contract is valid for this experiment: direct uniform
  still-water initialization, `U_infinity=(0,0,0)`, no cylinders, 351 lossless
  moving-window shifts, and no prewarm snapshot.
- Both visual rows show genuine self-propulsion rather than advection. The
  top-down row develops a strong alternating wake and moves the fish broadly
  toward the target through about 16 T. The oblique Lambda2 row confirms a
  coherent three-dimensional wake without visible loss of the body or a
  numerical blow-up. Thus the early finite segment is the useful comparison
  case and propulsion should be preserved.
- The same finite rollout is also the informative failure. Distance falls from
  12.328 L to 4.780 L at 17.85 T, then rises to 9.709 L before `left_domain` at
  27.49 T. The fish continues down and left after passing below the target,
  exiting with center y=0.798 L; this is a missed redirect, not weak thrust.
- Cross-checking the trace shows that target-relative course error (the signed
  angle from body-frame velocity to `target_body_L`) becomes consistently
  negative in 99% of samples at 12--14 T and 100% at 14--24 T. Median closing
  speed nevertheless falls from +0.668 L/T at 12--14 T to +0.124 L/T at
  16--18 T and -0.149 L/T at 18--20 T. In contrast, the inherited seven-step
  bearing-rate and turn-rate signals alternate at the beat frequency, reaching
  roughly +/-3 rad/T, so they are poor route-error signals here.
- The inherited controller asks for accelerations beyond the physical limit on
  74.0% of joint commands (raw maximum 125.4 rad/T^2 versus the 31.4 rad/T^2
  limit), and the joint-rate trace reaches the 260 deg/T limit. Adding more
  scalar steering acceleration to the same saturated gait is therefore not a
  credible correction.

## Candidate hypothesis

Preserve the state-feedback traveling-wave gait while replacing beat-rate
route corrections with a body-frame course-error controller. When course error
is large *and* normalized closing speed has collapsed, continuously blend from
the propulsive oscillator into a bounded two-joint C-bend redirect. As either
course alignment or positive closure returns, blend back into the oscillator;
because oscillator phase remains encoded in joint angle and rate, this needs no
clock or hidden mode. A modest course-directed tail-curvature bias remains in
cruise so the redirect gate is not the only steering path.

Expected evidence: the policy should retain the coherent early wake, begin its
redirect around the 16--18 T loss-of-closure transition, reduce the sustained
downward course, and improve the `left_domain` termination or closest approach.
Falsify the mechanism if it produces the same lower-boundary exit, persistent
acceleration/rate saturation during redirect, a stall with no recovery of
closure, or loss of the useful early distance reduction.

bookshelf_consulted: true
source_domain: robotic-fish CPG direction tracking and biological burst redirect turning
source_mechanism: sensor-gated modulation from rhythmic propulsion into a bounded large-error curvature maneuver, followed by release back to propulsion
transferable_invariant: use persistent target-relative course error and observed loss of closure to trade thrust temporarily for turn authority, then release continuously when the response becomes useful
nontransferable_details: published gains, dimensional cadence, species-specific C-start kinematics, full-body waveforms, exact phase schedules, and task-specific routes
policy_translation: derive course error only from normalized `target_body_L` and `velocity_body_U`; combine it with normalized closing speed to blend the two-joint state-feedback oscillator into bounded joint-angle feedback for a C-bend
falsification: reject if the coherent approach wake is destroyed, redirect commands remain limit-dominated, closure does not recover, or the rollout retains the same downward `left_domain` topology

## Non-CFD implementation audit

Replaying only the parent's recorded target, velocity, and closing-speed
observations through the new guidance (without advancing fluid or fish motion)
leaves the mean redirect gate at 0.001 or less through 12--14 T, raises it to
0.592 at 16--18 T, and to 0.969 at 18--20 T. A separate joint-limit integration
under those fixed recorded observations reduces raw command-limit incidence
from 67.0% per joint at 14--16 T to 4.0% at 16--18 T and zero at 18--24 T as
the C-bend settles. This is a contract/activation audit only, not rollout
evidence or a claim that the coupled CFD trajectory improves.
