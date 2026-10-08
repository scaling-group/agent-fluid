# Multi-Wake Policy Candidate Notes

## Evidence diagnosis

The shared prewarm sheet shows the fish held above and downstream of four fully
developed, interacting vortex streets. It is a common initial condition, not a
candidate result. All four sampled released sheets terminate by first target
capture and show an actively propelled compact diagonal transit: the fish turns
down and upstream, maintains a body-generated traveling wake, enters the dense
cylinder wake only late in the approach, and exhibits no visible coasting,
route reversal, collision precursor, or loss of joint-wave structure. No
sampled failure keyframe is available, so the inherited downstream-exit and
no-traveling-wave cases define the adverse topology rather than a new visual
failure claim.

The assigned prefill reaches the target at `32.33997`, with mean distance
`1.63773L`, command-energy mean `1423.42`, power-proxy mean `108.78`, relative
crossflow RMS `0.24372`, and force/moment RMS `65.12/888.56`. Two sampled
response-supervised repeats reach at `32.31796` and improve the mean distance
only to `1.63741L`; force RMS rises to `65.52`, while moment RMS falls to
`881.45`. The strongest sampled policy instead admits measured target-signed
yaw assistance at the same optional posterior-residual gate. It preserves the
visible route but reaches at `31.56447`, lowers mean distance to `1.60525L`,
command-energy mean to `1420.86`, and power-proxy mean to `108.30`. Relative
crossflow remains comparable at `0.24105`; force/moment RMS are `66.32/887.63`.
Its smaller peak joint excursions (`0.5191/0.5555 rad` versus the response
policy's `0.5244/0.5748 rad`) coexist with both joints still touching velocity
and acceleration limits. Thus the benefit is faster progress while preserving
the traveling wave, not established wake avoidance, efficiency, desaturation,
or held-out-phase robustness.

The assigned parent notes also report that response-conditioned withdrawal in
another controller layer regressed to `32.4555`, and the experience bank shows
an undirected physical-limit gate delayed capture to `33.9405`. Those negative
results argue against stacking more response conditions or weakening the base
wave. The sampled yaw-assistance mechanism is the only material improvement in
the current evidence and changes the controller at one already-guarded locus.

## Policy hypothesis

Materialize the strongest sampled mechanism on the assigned closure-supervised
policy. Preserve bounded bearing-to-distributed-curvature steering, the
anterior oscillator, the unit-gain lagged posterior wave, and the coherent-
closure supervisor. During coherent target closure only, sign normalized body
yaw moment by the persistent body-frame turn request; when the fluid moment
assists that turn, include it as pressure to withdraw only the optional `8%`
posterior half-cycle residual. Opposing or absent moment leaves the evaluated
controller unchanged. This should reproduce the compact target capture while
testing whether avoiding redundant active turning preserves the sampled
`0.75`-time arrival and distance-integral improvement. Falsify it if capture or
the direct traveling-wave route is lost, arrival and mean distance regress,
loads or saturation residence rise without navigation benefit, or a held-out
wake exposes phase-sensitive switching.

bookshelf_consulted: true
source_domain: biological Karman-gait and wake-exploitation studies
source_mechanism: swimmers can yield optional active effort to organized vortex-induced loading instead of cancelling every lateral wake motion
transferable_invariant: preserve useful hydrodynamic assistance only when a measured body-frame load agrees with the current task-directed turn and coherent progress
nontransferable_details: trout kinematics, muscle-activity values, single-cylinder phase locking, dimensional frequency, published gains, exact wake phase, and prescribed routes
policy_translation: sign normalized `moment_z_L2` by bounded persistent bearing feedback and use the soft agreement signal only to withdraw the optional posterior half-cycle residual during coherent closure
falsification: reject if target capture or the compact traveling-wave route is lost, if arrival and distance integral regress, or if force, moment, effort, or saturation rise without a compensating navigation benefit

## Scope

This candidate does not infer vortex phase, cancel crossflow, use cylinder
coordinates, or alter scalar gait gains. Its CFD outcome is deferred to the
post-worker evaluation.
