# Candidate wake-policy notes

## Evidence diagnosis before edit

- All four sampled rollouts satisfy the direct-uniform still-water contract
  (`U_infinity=[0,0,0]`, no cylinders, no prewarm) and capture.  The prefilled
  v48 reaches `0.748227 L` at `17.5285 T`, the two byte-identical v49 samples
  reach `0.745909 L` at `17.4845 T`, and v50 reaches `0.745094 L` at
  `17.4130 T`.
- The top-down rows show self-propulsion rather than advection: a compact,
  alternating wake grows behind the fish while the head follows a smooth
  target-signed arc into the capture circle.  The v48 oblique row is readable
  and shows paired three-dimensional Lambda2 structures remaining organized
  through capture.  The v49 and v50 oblique rows are black, so their scalar
  and trajectory gains cannot establish a comparative 3D-wake improvement.
- v49's broad out-of-centerline yaw-response release leads v50 by
  `0.0249/0.0225 L` at `6/8 T`, but v50's added absolute-bearing geometric
  qualification is closer by `0.0128/0.0364/0.0373 L` at `10/12/14 T`, by
  `0.0373 L` at `16 T`, and captures `0.0715 T` earlier.  Relative to v48,
  v50 is essentially identical through `8 T` but is closer by
  `0.0028/0.0111/0.0344/0.0685 L` at `10/12/14/16 T`.  It also improves the
  total/observed distance integrals from v49's `1.947439/1.331949 L` to
  `1.945327/1.329976 L`; peak normalized force/moment remains
  `0.032252/0.016092`, while maximum speed rises from `0.9602` to
  `0.9831 L/T` and acceleration-limit residence is essentially unchanged
  (`40.17%` versus `40.11%`).
- The inherited logs already falsify a fixed `4.0 L` distance handoff.  The
  remaining semantic discriminator is target-angle motion: the useful early
  release occurs around contraction/sign crossing, whereas the `10-14 T`
  interval that benefits from v50 has de-gaited bearing moving outward.  A
  yaw response alone is therefore insufficient evidence that supplementary
  curvature has completed its job.

## Policy hypothesis

Start from completed v50 without changing its posterior-lag carrier, steering
gains, or actuator allocation.  For only the small phase-even posterior turn
shape, retain the existing response-release annulus and smoothly increase its
geometric completion confidence within the established centerline transition
when the normalized de-gaited bearing is contracting.  Keeping the centerline
factor in both confidence terms prevents contraction oscillations from
reopening v49's broad out-of-band release.  This response-and-contraction
conjunction should recover part of v49's `6-8 T` lead while preserving v50's
target-signed curvature during the later divergent-bearing interval.  Falsify
it if capture,
the `10-16 T` lead, wake organization, or the established
`0.9831/0.032252/0.016092` speed/force/moment envelope regresses, or if the
early checkpoint deficit does not shrink.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG turning and biological burst redirect
source_mechanism: preserve a propulsive rhythm while sensor response gates release of supplementary asymmetric turning
transferable_invariant: release extra curvature only when the requested yaw response and contraction of body-frame target error agree; otherwise retain target-signed turning authority
nontransferable_details: published CPG gains, clock phase, duty ratios, species kinematics, exact vortex phase, and task-specific routes
policy_translation: combine bounded correct-sign de-gaited yaw with normalized bearing-contraction confidence to widen only the posterior residual release; preserve carrier, base redirect, and actuator limits
falsification: reject if the early checkpoint gap remains, the later v50 lead or capture is lost, the readable wake decoheres, saturation rises materially, or speed and normalized load exceed the sampled envelope

## Offline validation after edit

- The guidance-provenance check, lightweight Julia policy contract, and solver
  editable-boundary check pass.  The rendered README contained the same
  assigned-parent marker twice; removing only the duplicate allowed the
  provenance checker to resolve the unchanged assigned parent.
- Every direct `params.FIELD` reference is declared by
  `target_policy_params()`.  A grid of 4,375 finite synthetic body-frame
  states kept both completion/release gates in `[0,1]` and both commands inside
  the `31.415927 rad/T^2` acceleration limit.
- Offline replay of the completed v50 trace shows that the new yaw-release
  mean exceeds v50 by only about `0.0002-0.0033` across 3T bins; retaining the
  centerline factor prevents the contraction cue from reopening the broad v49
  release.  This is a frozen-trace authority check, not a performance claim.
- A supplementary mirror-state audit is not exact because the inherited full
  controller deliberately scales negative and positive turn requests
  differently (`negative_turn_request_gain=0.78`).  This candidate does not
  modify that inherited asymmetry; the added completion factor itself uses
  only absolute bearing and the even product of bearing with bearing trend.
