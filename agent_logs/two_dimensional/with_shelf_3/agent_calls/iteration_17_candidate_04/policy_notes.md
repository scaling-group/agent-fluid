# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  developed, interacting vortex streets. It is the certified common initial
  condition, not candidate-specific evidence of wake selection or wake-phase
  robustness.
- All four sampled released sheets reach the target on a compact, nose-first
  diagonal. They show an immediate targetward redirect, a persistent traveling
  body bend and self-generated posterior wake, ample cylinder clearance, and
  entry into the developed cylinder wakes only near capture. The strongest
  branch's mean local flow `(-0.1978,-0.1941)` versus head displacement
  `(-10.9169,-4.2166)L` over `31.5645` release time confirms active upstream
  propulsion rather than passive advection.
- The sampled hydrodynamic-yaw-yield branch is a material navigation result:
  it captures at `31.5645`, has `1.60525L` mean distance, and scores
  `0.266663`, versus the response-supervised prefill's `32.318`, `1.63741L`,
  and `0.234705`, and the progress-only branch's `32.340`, `1.63773L`, and
  `0.234663`. Its released sheet preserves the same useful route topology and
  traveling wave; the improvement is earlier closure, not a route shortcut or
  wake avoidance, because relative-crossflow RMS remains comparable
  (`0.24105` versus `0.24339-0.24372`).
- The improvement is not load relief: force/moment RMS are `66.32/887.63`,
  compared with `65.52/881.45` for the response-supervised prefill and
  `65.12/888.56` for progress-only supervision. Mean command energy changes
  little (`1420.86` versus `1423.00` and `1423.42`). Preserve the bounded
  mechanism as a navigation cue, but do not claim efficiency, wake-phase
  locking, or robustness.
- No sampled released failure sheet exists. The informative adverse boundary
  remains inherited: moving target-rate feedback into oscillator centers
  erased the traveling bend and exited downstream, while undirected damping
  delayed capture. The current edit must therefore leave distributed mean
  curvature and the unit-gain lagged traveling wave continuously active.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological Karman-gait and adaptive wake-interaction studies
source_mechanism: yield optional active steering when organized fluid loading assists the requested turn instead of cancelling every lateral wake motion
transferable_invariant: use a bounded target-signed body-frame load only to withdraw incremental control authority while preserving route geometry and the propulsive traveling rhythm
nontransferable_details: trout kinematics, muscle-activity values, single-cylinder phase, dimensional frequency, published gains, species morphology, and prescribed wake routes
policy_translation: during coherent body-frame target closure, soften the optional posterior half-cycle residual when normalized yaw moment agrees with the persistent target turn; keep mean curvature and the unit-gain posterior wave outside this yield path
falsification: reject if target capture or the compact self-propelled diagonal is lost, arrival and mean distance do not retain the sampled improvement, force or moment rises without navigation benefit, or a held-out wake exposes switching, propulsion loss, or phase sensitivity

## Candidate hypothesis

Produce exactly one candidate by promoting the sampled hydrodynamic-yaw-yield
branch without adding another controller layer or changing any scalar gain.
Preserve filtered body-frame bearing, the bounded `12 deg` distributed
curvature request, bearing-conditioned `40/60 -> 35/65` allocation, anterior
state-feedback oscillator, posterior lag and damping, and maximum `8%`
target-helping half-cycle residual.

Use normalized target-window trajectory efficiency to admit yielding only
during coherent closure. At the same optional posterior-residual locus, treat
only target-signed `moment_z_L2` as hydrodynamic assistance; opposing or absent
moment leaves the progress-supervised controller unchanged. The evaluated
`0.22` moment normalization is retained as candidate-owned sampled evidence,
not copied from the bookshelf. Remove the prefill's separate response-rate
gate so the candidate tests one compact, already positive mechanism. Formal
CFD evaluation remains downstream; no same-worker improvement is claimed.
