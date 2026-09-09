# Range-scheduled approach-drive candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled diagnostics report direct uniform initialization in still
  water (`U_infinity=(0,0,0)`), no cylinders, and no prewarm. The organized
  wakes and translation are self-generated rather than advection or a moving-
  window artifact.
- Both rows of the combined keyframe sheets were inspected for the strongest
  finite approach (`solver_3b6bd84298a5`) and the most informative short-turn
  failure (`solver_f080e10f704b`). The former retains a long alternating
  top-down vortex street and compact oblique Lambda2 structures through
  `30.12T`; the latter turns upward and exits at `11.30T` after only a short
  wake. This rejects another instantaneous projected-course release on the
  posterior mean-curvature actuator.
- The assigned parent's line-of-sight-rate release is a real but incomplete
  improvement. It reduces closest approach from the raw-slip sample's
  `4.158L` to `3.369L`, crosses the target x station at `y=12.895L` rather than
  `13.735L`, and remains finite until a left exit. Its local-flow RMS is only
  `0.020U`, so the remaining miss is not imposed-flow advection. At `16T`,
  `18T`, and the `20.43T` closest approach its range is `4.89L`, `3.89L`, and
  `3.37L`, while body speed remains about `0.88--0.90U`; the fish crosses the
  target station before the bounded curvature loop can remove the remaining
  lateral offset.
- The sampled carrier is useful but acceleration-limited: the parent's raw
  anterior and posterior commands exceed `1800 deg/T^2` in about `58%` and
  `74%` of logged rows. Retuning the far-field carrier upward would add effort
  without addressing the approach topology. The evidence instead supports a
  continuous near-target drive transition while retaining steering authority.
- The inherited response-damped half-cycle candidate already demonstrated
  that more direct turn authority is unsafe: it curled upward, lost the long
  wake, and reached only `12.072L`. The new candidate therefore preserves the
  parent's line-of-sight-rate guidance and posterior mean-curvature actuator.
- A deterministic joint-only check against the documented angle, velocity,
  and acceleration clips rejects an amplitude-parameter-only schedule: the
  carrier remains near the sampled `26.3 degree` anterior excursion because
  clipping dominates the weak Van der Pol growth term. The approach mechanism
  must therefore add bounded velocity damping to the carrier, rather than
  merely relabeling its nominal amplitude.

## Policy hypothesis recorded before editing

Preserve the evaluated `28 degree`, `0.55T` state-feedback traveling bend and
the parent's body-frame bearing, rotation-invariant line-of-sight-rate
response, and phase-conditioned yaw residual. Add one continuous approach
mechanism: below a normalized `5.5L` range, smoothly add bounded anterior
joint-velocity damping while leaving posterior steering curvature available.
The transition begins before the parent's `4.89L` high-speed approach and is
based only on normalized target range, not time, position, or a memorized
route. A clipped joint-only check predicts that `0.60/T` maximum damping lowers
the anterior excursion from about `26 degree` to about `18 degree` by the
parent's closest-approach time without changing the far-field carrier. Lower
axial advance should give the already-correct downward route and bounded yaw
loop more beats to remove the final lateral offset.

Expected evidence is the parent's coherent far-field wake and broad approach,
followed by visibly shorter near-field vortices, a target-station crossing
below `y=12.895L`, and a closest approach below `3.369L` or capture. Reject the
mechanism if it stalls before the target, destroys wake coherence before the
range transition, repeats the same high left pass, or increases saturation or
load spikes. The current worker does not claim those outcomes before CFD.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and residual CPG path following
source_mechanism: sensory approach state adds bounded damping to a persistent rhythmic carrier while a separate steering loop remains active
transferable_invariant: once broad target-directed motion works, continuously reduce excess propulsive drive near capture without removing bounded route correction
nontransferable_details: published gains, clock phase, robot linkage geometry, dimensional approach distances, species kinematics, exact vortex phases, and task-specific routes
policy_translation: use normalized `distance_L` to smoothly add anterior joint-velocity damping while retaining the parent's normalized body-frame line-of-sight-rate guidance and two-joint posterior-curvature steering
falsification: reject if near-field speed does not fall, the same more-than-3L high pass remains, the fish stalls outside capture, or wake coherence and actuator/load histories worsen
