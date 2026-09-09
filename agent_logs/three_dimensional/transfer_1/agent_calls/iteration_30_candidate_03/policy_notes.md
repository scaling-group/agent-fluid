# Step 30 target-policy diagnosis

## Evidence read before the edit

- All four sampled evaluations report direct uniform still-water initialization
  with `U_infinity=(0,0,0)` and terminate by capture. The three exact-byte
  speed-reserve samples (`solver_2d0a4a628957`, `solver_6b0e320e2f55`, and
  `solver_6f904f98394f`) reach `0.7466--0.7494L` at
  `18.3205/18.6010/18.2875T`. The distinct fixed anterior-transfer sample
  (`solver_55f3a103ab95`) reaches `0.7492L` later, at `18.7495T`.
- In both the best-distance baseline sheet and the anterior-transfer sheet,
  the top-down row develops a clean alternating signed-vorticity street from
  release through capture. The oblique row shows bilateral three-dimensional
  Lambda2 structures and continued body undulation at the target. The fish is
  self-propelled, does not coast, and shows no visible terminal wake collapse
  or numerical instability. The fixed allocation transfer therefore has no
  visible propulsion advantage.
- The sampled metrics and inherited comparison quantify the same negative
  result: the transfer leaves head/tail action clipping near
  `68.76%/70.75%` and exact speed-limit residence near `10.74%/11.62%`, within
  the baseline envelope rather than improving it. It is not a reason to tune
  the transfer fraction.
- The assigned parent records two additional exact-byte speed-reserve lower
  exits at closest passes `1.6463L` and `1.4642L`, so the available baseline
  record is `3/5`, not robust success. At the first `3L` crossing, the sampled
  captures have body-frame target bearings `-0.076-- -0.195 rad` and
  same-sign achieved-course errors, whereas a restored failure has a
  `+0.171 rad` bearing but only `-0.008 rad` course error before projected miss
  opens to `1.95L`. The step-27 through step-29 inherited solver logs likewise
  contain only stable lower exits (`1.196--1.939L` closest passes), so another
  terminal allocation or scalar replay is not supported.

## Candidate hypothesis

Preserve the exact traveling-bend carrier, achieved-course servo, intercept
release, and sparse outward-carrier speed reserve. Add one bounded outer-
terminal target-bearing rescue: only in the `4.0--2.75L` annulus, and chiefly
when target bearing and achieved-course error do not request the same turn,
add a small target-signed body-frame residual to the raw course error. This is
zero outside the annulus, fades before the existing inner intercept guard, and
does not replace achieved course. It should supply steering in the evidenced
failure signature where course error becomes nearly zero despite unresolved
cross-track bearing, while remaining nearly inactive at the same-sign `3L`
capture signatures.

Falsify the candidate if it changes far-field closure, loses any repeated
capture, weakens either wake row, retains the lower-exit branch, or moves speed,
clipping, force, or yaw moment outside the repeat-backed speed-reserve
envelope. A lone threshold capture is insufficient evidence.

bookshelf_consulted: true
source_domain: robotic-fish direction tracking and target-vector-to-curvature steering
source_mechanism: bounded sensor-feedback modulation of a propulsive rhythm by target geometry
transferable_invariant: preserve the traveling propulsive bend while unresolved body-frame lateral target geometry supplies a bounded mean-turn request
nontransferable_details: published CPG gains, species kinematics, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: retain the two-joint state-feedback carrier and add only a speed-valid, disagreement-gated body-frame bearing residual before the inner intercept band
falsification: reject if repeat capture reliability, wake coherence, far-field closure, or actuator/load metrics worsen, or if the same lower-pass topology survives
