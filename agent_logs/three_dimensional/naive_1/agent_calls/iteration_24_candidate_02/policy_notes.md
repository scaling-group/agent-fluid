# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four assigned samples satisfy the frozen contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and `termination=capture`. I
  inspected every combined sheet's top-down vorticity and oblique
  body/Lambda2 rows, then cross-checked them against observations, metrics,
  diagnostics, trajectories, executable policies, assigned-parent guidance,
  and inherited optimizer notes.
- The four current sheets form one productive wake class. Alternating
  body-attached vorticity grows into a coherent target-bending street, compact
  caudal Lambda2 structures persist through approach, and motion develops from
  zero initial fluid and body velocity; progress is self-propulsion rather
  than advection. The current sample set contains no failure-class sheet.
- The two executable-identical common half-cycle envelope redistributions are
  now positive replication evidence, not a one-run result. They capture at
  `18.82649--18.88149T`, reproduce mean distance
  `2.088545--2.088964L`, and score from `-0.201056` to `-0.200406`. Their acceleration
  contact (`60.85--61.00%` anterior, `72.97--73.27%` posterior), rate contact
  (`11.04--11.07%`, `14.88--14.93%`), and two-view wakes overlap, so the
  reusable benefit is far/middle route allocation rather than arrival or
  demand relief.
- The rearward-route multiplier also captures, but normalized forward target
  fraction remains positive on every row (`0.35412--1.0`); its added recovery
  branch never activates. It arrives later at `18.96399T` and its
  `2.090724L` mean distance lies close to the replicated carrier, so it does
  not support post-overshoot recovery or carrying the dormant branch forward.
- The broadside curvature-reserve sample captures at `18.70550T`, keeps the
  target substantially more forward (`forward_fraction >= 0.76134`) and caps
  absolute lateral fraction at `0.64836`, versus maxima `0.88732--0.93971`
  and forward minima `0.34198--0.46116` in the redistributed captures. Its
  mean distance (`2.093857L`) and score (`-0.205763`) remain in the inherited
  geometry-carrier band rather than the redistributed band. Thus the reserve
  is capture-safe evidence for a less-broadside terminal geometry, but does
  not independently establish a better distance integral.
- For the required failure contrast, the inherited posterior-only wave-relief
  rollout is also direct-uniform still water. Its top-down street remains
  energetic and the oblique row retains compact caudal structures, yet the
  route bends down and away, reaches only `3.92476L`, and exits left at
  `26.21302T` and `6.74099L`. Preserving both target-signed curvature shares
  and the common traveling-wave carrier is therefore a hard boundary; wake
  coherence alone cannot justify another posterior allocation.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological burst redirect and closed-loop robotic-fish asymmetric mean-curvature steering
source_mechanism: large observed target-direction error receives a bounded curvature reserve while the traveling propulsive rhythm and response-based release remain active
transferable_invariant: separate persistent normalized body-frame route geometry from the propulsive wave, add redirect authority without changing turn sign, and release it as correcting yaw appears
nontransferable_details: published gains, dimensional cadence, species-specific C-start shapes, robot duty ratios, clock phase, exact vortex phase, world-frame paths, and task-specific routes
policy_translation: retain the twice-captured common half-cycle redistribution carrier and add the already capture-safe body-frame broadside reserve to both target-signed mean-curvature shares; preserve displacement-only phase, posterior lag, response release, and final acceleration projection
falsification: reject the composition if capture or either coherent wake row is lost, mean distance leaves the replicated redistribution band without a meaningful arrival or terminal-geometry gain, the route repeats a downward left exit, or actuator and planar-load contact materially exceed the sampled bands

## Single-candidate policy hypothesis

Compose exactly two individually evidenced compatible layers: use the current
twice-captured common half-cycle envelope redistribution for far/middle
progress, and add the sampled broadside curvature reserve after the saturated
route command. The reserve is a smooth function of normalized body-lateral
target direction, is limited to a small fraction of the established anterior
and posterior curvature shares, is gated to a forward target, and inherits the
same non-inverting correcting-yaw release. It changes neither the common
rhythmic envelope nor the posterior displacement-plus-lag wave.

This candidate tests whether the redistribution's lower distance integral can
coexist with the reserve's less-broadside terminal geometry and earlier
capture. It is a mechanism composition, not scalar-only gain tuning: every
carrier value and both already evaluated mechanisms remain unchanged. No
distance stage, approach release, rearward branch, velocity residual, flow
phase, posterior-specific allocation, clock, world coordinate, or memorized
route is added. Formal CFD occurs only after this worker exits; no same-worker
performance claim is made.

## Implementation and non-CFD validation

The candidate adds the four parameter-owned broadside-reserve fields and the
same normalized body-frame gate that completed a sampled capture, while
leaving the replicated common redistribution, response release, oscillator,
posterior lag, and final projection unchanged. The provenance/material-change
check and solver edit-boundary check pass after the final edit. A deterministic
schema audit confirms that every direct `params.FIELD` reference has a field
returned by `target_policy_params()`.

The required check-runner was invoked. Its Julia contract command could not
run because this host has no `julia` executable on `PATH`, in the filesystem
search, or in the environment-module tree; no assertion or policy exception
occurred. The new expressions are the direct composition of two sampled
Julia-executed policy fragments, but this is not reported as a substitute
runtime pass. No CFD was run.
