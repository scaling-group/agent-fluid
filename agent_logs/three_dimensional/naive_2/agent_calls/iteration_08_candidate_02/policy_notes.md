# Candidate wake-policy notes

## Evidence diagnosis before edit

- All four sampled evaluations report direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, so the observed translation is self-propulsion,
  not advection or a prewarm artifact.
- In both the top-down vorticity and oblique Lambda2 rows, every controller
  develops a coherent alternating wake during the useful approach. The
  assigned parent reaches `2.703L`, but its terminal sheet folds into a tight
  one-sided turn and its organized wake decays before an upper-boundary exit.
  The trajectory cross-check is decisive: at closest approach (`17.434T`)
  joint 2 is already at `-45 deg`; across the rollout joint 2 is near its angle
  limit for 34.3% of samples and both joints are pinned on the same side for
  20.1%. By `19.612T` both are at `-45 deg` with zero rate, and the fish exits
  at `y=15.203L`.
- Full-circle phase-separated pursuit without bend release is the scalar score
  leader (`-7.405`) but passes no closer than `4.650L`; its sheet preserves a
  longer straight alternating wake, then also folds upward and leaves the
  domain. The sampled mean-bend release is the closest of this group (`2.664L`)
  and eliminates simultaneous same-side pinning, but leaves the posterior
  joint near its limit for 21.7% of samples and still exits upward. Releasing
  both steering and drive relief from posterior bend removes simultaneous
  pinning but worsens closest approach to `3.312L` and repeats the same exit.
- No inherited `logs/` were present before this note. The assigned parent
  guidance and sampled rollouts therefore support a negative conclusion:
  threshold-gating the existing acceleration asymmetry is not a sufficient
  release mechanism. The controller needs an explicit bounded curvature
  equilibrium rather than another threshold or scalar gain adjustment.

## Policy hypothesis

Replace persistent half-cycle acceleration asymmetry and approach hold with
one bounded common-mode mean-curvature servo. Retain the naive seed's
joint-state oscillator and posterior lag unchanged. Use full-circle normalized
body-frame target geometry, body-frame lateral velocity, and carrier-phase-
compensated yaw rate to form the signed turn request. Map that request to a
bounded mean joint-angle target and use damped state feedback on observed mean
bend and mean bend rate. This gives steering a finite equilibrium and an
automatic return arc when target error changes sign, while leaving the
differential traveling bend available for propulsion.

Expected evidence: coherent alternating shedding should survive the approach;
neither joint should dwell at the same `45 deg` limit; and the trajectory
should turn back toward the target after the first pass instead of exiting the
upper boundary. The mechanism is falsified if closest approach is not better
than `2.664L`, either joint still shows long angle-limit dwell, the same upper
exit recurs without a visible return arc, or the carrier wake collapses before
closest approach.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG steering and biological burst redirects
source_mechanism: sensor feedback modulates a rhythmic carrier through bounded mean curvature and releases the redirect when observed response replaces error
transferable_invariant: a turn command should set a finite curvature equilibrium and continuously release from observed joint state and body-frame target response
nontransferable_details: published gains, clock-driven phase, species-specific envelopes, exact vortex phase, and task-specific routes
policy_translation: preserve the joint-state traveling-bend carrier; servo normalized body-frame turn request to bounded common-mode two-joint curvature with mean-rate damping
falsification: reject if coherent propulsion is lost, closest approach does not beat 2.664L, angle-limit dwell persists, or the same upper-boundary topology lacks a return arc
