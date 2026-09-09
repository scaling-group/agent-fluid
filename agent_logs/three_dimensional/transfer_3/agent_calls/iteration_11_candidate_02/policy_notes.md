# LOS-response-triggered distributed C-bend candidate

## Evidence diagnosis recorded before the policy edit

- All sampled and inherited evaluations used direct uniform initialization in
  still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their
  translation and wakes are self-generated rather than imposed advection or a
  moving-window artifact.
- Both the top-down vorticity and oblique Lambda2 rows were inspected. The
  assigned parent (`solver_adc862529891`) generates a compact coherent wake
  but rises to `y=15.20L`, reaches only `5.658L`, and exits upward at `16.77T`.
  Its favorable scalar score is therefore not a favorable pursuit topology.
  The LOS-rate baseline (`solver_3b6bd84298a5`) preserves a long alternating
  wake to `30.12T`, but crosses the target x station at `y=12.895L`, misses by
  `3.369L` at about `0.88U`, and exits left.
- The sampled bearing-triggered distributed C-bend
  (`solver_5188c80f90a6`) is the strongest semantic result. It preserves the
  long coherent wake, lowers the target-station crossing to `y=11.351L`, and
  improves minimum distance to `1.897L`. Local-flow RMS remains only `0.0208U`,
  so this is added route authority rather than wake advection. It still passes
  about `1.85L` above the target and exits left; raw acceleration-envelope
  occupancy rises modestly from the LOS baseline's `57.7%/74.0%` to
  `62.2%/76.4%`, so raising carrier or curvature gains is not supported.
- The inherited continuous yaw-residual allocation
  (`solver_342060d7a013`) brackets the target from the other side: it reaches
  `2.317L`, crosses the target station at `y=6.461L`, and exits the lower
  boundary with `69.3%/75.1%` raw acceleration-envelope occupancy. A raw
  continuously distributed residual therefore has ample authority but does
  not release into a capture route.
- The C-bend trace exposes an activation mismatch rather than a magnitude-only
  failure. At about `12T`, normalized bearing activates roughly `97%` of the
  anterior redirect; near `16T`, while range has fallen to about `4.1L` and the
  bounded bearing-plus-LOS demand is still saturated, the bearing-only gate
  falls to roughly `56%`. It returns near full authority only at the target
  station, too late to remove the remaining lateral offset. Range-only carrier
  damping already worsened the LOS baseline from `3.369L` to `3.392L`, so it
  should not be repeated as the fix.

## Policy hypothesis recorded before editing

Start from the evaluated LOS-rate distributed C-bend, preserving its
`28 degree`, `0.55T` state-feedback traveling wave, posterior response
curvature, and `6 degree` anterior redirect bound. Change one controller
semantic: gate the anterior redirect with the magnitude of the already-bounded
bearing-plus-LOS route demand rather than raw bearing alone. The rigid-body LOS
response can keep the redirect recruited when bearing temporarily shrinks even
though the approach is still drifting high; as route demand relaxes or
reverses, the same bounded response releases or reverses the mean bend without
a clock, route, or mutable state.

Expected evidence is the C-bend's coherent far-field wake and finite loads,
with sustained mid-approach redirect, target-station crossing below
`11.351L`, and capture or minimum distance below `1.897L`. Reject this
activation semantics if it reproduces the more-than-`1L` high left pass,
switches to the continuous-residual candidate's lower pass, weakens the
traveling wake, or materially increases acceleration occupancy or loads.

bookshelf_consulted: true
source_domain: biological burst redirects and robotic-fish closed-loop CPG direction tracking
source_mechanism: a sensory route-response demand recruits bounded mean curvature on a persistent propulsive rhythm and releases it when the observed response no longer requires the redirect
transferable_invariant: preserve the traveling wave, recruit distributed curvature from bounded observed route demand rather than a clock, and release or reverse it continuously with route response
nontransferable_details: published gains, species-specific C-start shapes and timing, robot linkage geometry, dimensional rates, clock phase, exact vortex phases, and task-specific routes
policy_translation: retain normalized body-frame bearing and rotation-invariant LOS rate, use their bounded yaw demand to gate and sign the anterior oscillator-center shift, and retain the phase-conditioned posterior curvature in the two-joint state-feedback contract
falsification: reject if the `1.897L` high pass does not improve, the route flips to the inherited lower pass, carrier coherence degrades, or acceleration and load occupancy materially worsen

## Validation status

- The guidance semantic-change guard passes after removing a duplicated copy
  of the same assigned-parent marker from the rendered workspace `README.md`;
  the assigned parent itself did not change.
- The solver boundary guard passes, and a deterministic field comparison finds
  every direct `params.FIELD` reference in `target_policy_params()`.
- The mandated check-runner was invoked and rerun. Its guidance and boundary
  checks pass, but its Julia execution probe cannot start because this worker
  environment has no `julia` executable. An attempted temporary official
  runtime fetch was rejected by an outbound TLS reset and left no staged
  files. This is an environment limitation rather than a passed runtime test.
- No CFD rollout was run, and no outcome for this candidate is claimed here.
