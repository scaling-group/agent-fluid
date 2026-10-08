# Candidate wake-policy notes

## Evidence diagnosis before edit

- All four sampled evaluations are valid direct-uniform still-water rollouts:
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and capture at
  `19.684490 T`. Three are the same v40 policy. The v41 sample changes the
  source but has the same trajectory CSV and keyframe hash, score
  `-0.261384287`, mean distance `2.151092787 L`, and final distance
  `0.748302400 L`; its course/yaw conjunction is therefore dormant rather
  than evidence of a better terminal response.
- In both inspected combined sheets, the fish moves toward the target under
  its own actuation, not advection. The top-down row develops a coherent,
  alternating posterior wake by `8 T` and carries it continuously through the
  compact target approach. The oblique row shows finite localized Lambda2
  structures rather than diffuse growth or a numerical blow-up. The lateral
  body oscillation is productive because distance decreases monotonically to
  capture while the wake remains organized, although broad gait-scale yaw is
  still visible before the terminal held bend.
- The common trajectory has no joint-angle stop dwell, but below `4 L` it
  still contains `229/302` anterior/posterior commands above
  `30 rad/T^2`, with finite force/moment maxima about `0.02753/0.01567` in the
  inherited comparison. Earlier inherited results show that adding posture
  during outward joint response and a terminal clipping-ratio blend both
  delayed capture, while the v40 intercept-supported posture handoff improved
  on v39. Thus the target and wake mechanisms should be preserved; a new test
  must act only on a separately observed response state.

## Policy hypothesis

Keep the reproduced v40 outer allocator, target-angle redirect, center-course
intercept corridor, mean-bend targets, and authority ceilings. Remove the
dormant v41 course/yaw branch. Within the existing terminal posture handoff,
compute the normalized dot product between the two-joint bend-target error and
joint velocity. Its positive part denotes motion down joint-error energy toward
the requested bend. During that response only, smoothly release a small bounded
fraction of the posture blend back to the already validated traveling carrier.
The gate must be zero outside `4 L`, when the intercept handoff is absent, when
error is settled, and when joint motion is outward or transverse. This tests a
response-conditioned mode transition without adding curvature, cadence,
beat-side authority, force cancellation, or a reconstructed rate.

Expected trace-level behavior: commands differ from v40 on a material set of
terminal descent states but remain identical on every outer state; the maximum
change is bounded by a declared fraction of the existing carrier/posture
difference. CFD falsification: reject if the gate is dormant, if the `4 L`
crossing or outer wake changes, if capture is delayed/lost, if the distance
integral or terminal loads grow, if stop dwell/instability appears, or if either
wake view degrades.

bookshelf_consulted: true
source_domain: biological burst turning and closed-loop robotic-fish CPG modulation
source_mechanism: hold strong bounded curvature for redirection, then release toward the propulsive rhythm when measured response appears
transferable_invariant: locomotor mode allocation should change on observed response, not elapsed time, and should preserve the established traveling wave
nontransferable_details: species-specific C-start kinematics, published oscillator gains, dimensional timing, exact vortex phase, and task-specific routes
policy_translation: use normalized two-joint bend-error/velocity alignment inside the existing body-frame target/intercept terminal gate to release a small share from damped posture to the state-feedback carrier
falsification: reject dormancy, outer-route changes, delayed or lost capture, worse distance integral, larger loads or stop contact, instability, or loss of coherent top-down and finite oblique wakes

## Post-edit deterministic trace audit

Replaying the candidate and v40 parent on the same reconstructed sampled states
changes 115 of 3579 commands, all between `15.5155 T` and `18.3480 T` and
none above `4 L`. Thirty states change by more than `0.1 rad/T^2`; the maximum
anterior/posterior differences are `0.2597/0.4080 rad/T^2`. The normalized
descent gate is above `0.1` on 68 states and reaches one on 23, so the mechanism
is neither dormant nor a broad retuning. These are counterfactual same-state
command checks only. Coupled CFD can change the later state sequence, so no
capture, load, or score improvement is claimed before the next evaluation.
