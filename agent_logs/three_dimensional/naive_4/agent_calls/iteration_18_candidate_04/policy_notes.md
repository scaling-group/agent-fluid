# Candidate diagnosis and hypothesis

## Evidence read before the edit

- The four sampled solver examples are exact replicates: they have the same
  policy SHA-256, the same combined-keyframe SHA-256, `capture` at
  `16.054482T`, final/minimum distance `0.747530L`, distance integral
  `1.931257L`, score `-0.048654`, and `239` moving-window shifts. They confirm
  deterministic repeatability of one controller, not robustness across four
  different controllers.
- The rollout satisfies the direct-uniform still-water contract. The release
  panel has no inherited wake, imposed advection, cylinder, or prewarm
  artifact. In the top-down row the fish translates from the upper right to
  the target while leaving a spatially trailing, alternating red/blue wake;
  the oblique row shows the corresponding compact three-dimensional Lambda2
  structures without visible heave, roll, pitch, or numerical breakup. This
  is self-propulsion, not passive transport, and the carrier must be preserved.
- The inherited anterior-only corridor carrier is the useful comparator:
  three logged copies captured at the same `16.0545T` with distance integral
  `1.938857L`, final distance `0.744345L`, and score `-0.055617`. The sampled
  yaw-residual addition advanced the `8/6/4/2/1.25L` crossings, reduced the
  distance integral to `1.931257L`, and retained the coherent two-view wake,
  but increased posterior excursion from `31.7` to `36.4 deg`, increased peak
  lateral force from `0.03193` to `0.03320`, and crossed slightly farther out.
- No sampled failure sheet exists in this workspace: every provided sheet is
  the same capture. The most informative inherited failure comparison is
  therefore the recorded one-sided-relief upper exit (`5.144L` closest
  approach, `18.975T`) rather than an unobserved image. It shared a coherent
  carrier but lacked the response-gated redirect that changed the termination
  class. This rules out sacrificing the proven redirect or propulsion merely
  to polish the terminal scalar.
- Replaying the current policy gates on its sampled trajectory localizes a
  smaller issue. From about `0.80L` to capture, the supplemental yaw gate stays
  near `0.94` even as predicted straight-course miss falls from `0.45L` to
  `0.38L` and the existing capture corridor becomes reliable. At capture the
  raw redirect remains positive and measured normalized yaw is positive
  (`heading_rate/omega` about `0.17`), but the carrier predictor is still more
  positive, so the residual is about `-0.13` and requests another `3.5 deg` of
  mean posterior curvature. The residual is correctly detecting less response
  than its carrier prediction, but it is no longer sufficient evidence that
  more curvature is needed after an actual target-signed yaw response and a
  capture-compatible course coexist.

## One candidate mechanism

Keep the evaluated oscillator, route-error residual, redirect, wave
allocation, approach law, anti-windup, and yaw-residual correction unchanged.
Add one continuous terminal response-release factor to the *supplemental yaw
curvature only*. It opens only where the already-evaluated closing capture
corridor is valid and the measured normalized yaw has the same sign as the raw
target redirect. It leaves the proven base mean curvature, posterior wave
shaping, and anterior corridor release untouched. On the parent trace this
would affect only 19 sampled states, retain about `95.5%` of integrated
yaw-residual gate duty, and strongly taper the added curvature only in the
last roughly `0.06T` as the corridor becomes certain.

Expected result: preserve the earlier milestone and distance-integral benefit
of residual yaw opposition while avoiding residual-predictor overreach in the
safe terminal corridor, reducing terminal posterior bend/load and recovering
or improving crossing geometry without changing the coherent wake or capture
time. This is a new response-conditioned release mechanism, not scalar-only
gain tuning.

bookshelf_consulted: true
source_domain: biological burst redirects and sensor-modulated robotic-fish CPG control
source_mechanism: retain the rhythmic carrier, apply a bounded redirect for large error, and release supplemental redirect authority once measured target-compatible response appears
transferable_invariant: corrective authority should depend on both persistent body-frame task error and observed response; an already safe, closing course plus target-signed yaw can veto only the extra response correction
nontransferable_details: published CPG gains, dimensional frequencies, species-specific C-start shapes, full-body kinematics, exact wake phase, and task-specific routes
policy_translation: smoothstep the target-signed measured heading rate normalized by carrier frequency, multiply it by the existing closing capture-corridor gate, and use the product only to taper yaw-residual posterior curvature
falsification: reject if capture is delayed or lost, any pre-corridor milestone or the coherent two-view wake regresses, distance integral returns toward or above 1.938857L, or terminal bend/load and crossing geometry do not improve enough to justify the new gate

