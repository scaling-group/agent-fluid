# Hydrodynamic response-deficit candidate

## Evidence diagnosis before policy edit

All sampled and inherited evaluations satisfy the direct-uniform still-water
contract (`U_infinity=(0,0,0)`, no cylinders and no prewarm) and capture with
zero angle, rate, or acceleration contacts.  The strongest sampled finite
example, `solver_8e7135ef9173`, uses translation-consistent target-line
steering and captures at `0.748338L/26.2460T` with mean distance `2.518971L`.
The assigned parent's phase-coherent route/response arbitration is the most
informative mechanism failure: `solver_809061fe0329` captures slightly earlier
at `0.749076L/26.2130T`, but its mean distance is `2.518962L` and it remains in
the same milliscale score and trajectory cluster rather than producing the
hypothesized semantic route change.

Both combined sheets were inspected from release through termination.  Their
top-down rows show genuine self-propulsion, an orderly alternating wake, and
the same late target-side hook; their oblique Lambda2 rows show a coherent
three-dimensional wake through capture.  The diagnostics agree: the compared
routes are identical at `8T` and `16T` to reported precision, retain the same
approximately `0.01883/0.00979` peak planar-force/yaw-moment envelope, and
remain stable.  Therefore the parent's signed-demand combination, course-
priority suppression, carrier relief, and the inherited late observer and
waveform edits do not support another scalar gain, threshold, or terminal
retune.

The strongest trace exposes an earlier observation/action opportunity that
those late edits do not test.  During the first route correction, normalized
fluid-relative crossflow frequently has the course-corrective sign: its median
signed ratio is about `0.38` over `4--8T`, with a positive 90th percentile
through `16T`, while instantaneous yaw moment alternates with median magnitude
about `0.0035--0.0040` and peak `0.00979`.  This indicates target-away slip
under alternating hydrodynamic load, not weak propulsion or wake breakup.  It
also supplies measured scales for a bounded feedback test instead of importing
published gains.

## Policy hypothesis

Start from the strongest sampled translation-consistent policy and preserve
its state-feedback carrier, posterior lag and capture modulation, redirect,
coordinated command envelope, and joint viability guards.  Add one anterior
hydrodynamic response-deficit residual.  Normalize body-frame relative
crossflow by relative-flow magnitude, require it to agree with the slow
target-course correction, and gate the residual further on measured yaw moment
that opposes that correction.  Apply the resulting signed demand through the
existing joint-state half-cycle selector, with course observability and
redirect pass-through gates.  Thus helpful crossflow, aligned yaw load, and
startup without translation pass through, while posterior feedback structure
remains unchanged (the existing common feasibility projection may still scale
both final commands together).

This is intended to change the early route before the `8T/16T` identity point
without strengthening the carrier or reacting indiscriminately to every wake
oscillation.  The formal evaluation should retain capture, the coherent two-
view wake, zero contacts, and the sampled force/moment envelope while producing
a meaningfully earlier target-directed course correction and better distance
integral or arrival.  Reject the mechanism if it loses capture, merely returns
to the shallow milliscale cluster, cancels beneficial crossflow, raises load or
limit exposure, or weakens the posterior traveling wave.

bookshelf_consulted: true
source_domain: organized-wake adaptive swimming and sensor-modulated robotic-fish CPG control
source_mechanism: use measured fluid/load response to modulate only the useful part of a persistent propulsive rhythm rather than cancelling all lateral motion
transferable_invariant: separate slow target-course demand from fast hydrodynamic response and add bounded phase-selective authority only when crossflow and yaw load jointly show an unresolved target-away slip
nontransferable_details: published gains, dimensional flow speeds, robot linkage geometry, species kinematics, exact vortex phase, cylinder layout, and task-specific routes
policy_translation: combine normalized body-frame target/course side, relative crossflow direction, yaw-moment opposition, and anterior joint-state phase into a bounded residual while leaving posterior propulsion and all safety projections unchanged
falsification: reject if capture or coherent wake structure is lost, the route remains milliscale-equivalent, helpful crossflow is suppressed, force/moment or contact exposure increases, or early target-directed translation does not improve

## Non-CFD validation after policy edit

- The required checker agent was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this account.  Running its three commands separately as
  the configured fallback passes the material-guidance check, the finite
  two-joint contract and exact parameter-schema check, and the solver editable-
  boundary check.  No CFD was run.
- A deterministic grid of `10,000` reflected state pairs remains finite and
  inside the `30 rad/T^2` policy envelope, with zero numerical reflection
  error.
- A frozen-state comparison against the strongest sampled policy changes
  `548/4772` rows, including `327` by more than `0.05 rad/T^2`.  It changes
  `486` rows before `16T` (`227/128/84/47` in the `0--4/4--8/8--12/12--16T`
  bins), rather than repeating the inherited after-`19T` intervention.  The
  largest final-command delta is `0.4035 rad/T^2`, and the maximum candidate
  request remains the parent's `29.72585 rad/T^2`; `27` posterior commands
  change only through the pre-existing common feasibility scale.  This proves
  selective, bounded activation on recorded states, not hydrodynamic or score
  improvement before formal downstream evaluation.
