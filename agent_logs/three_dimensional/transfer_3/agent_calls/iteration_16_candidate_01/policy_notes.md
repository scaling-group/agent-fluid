# Cue-redundant distributed C-bend candidate

## Visual diagnosis recorded before the policy edit

- All four sampled evaluations report direct uniform initialization in still
  water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. I inspected
  both the top-down mid-plane vorticity and oblique body/Lambda2 rows in their
  combined sheets. Each fish translates against quiescent water while laying
  down a coherent alternating top-down street and compact three-dimensional
  tail-associated vortices. The route is self-propelled rather than ambient
  advection or moving-window transport, and none of the four sheets shows wake
  collapse or a terminal 3D instability.
- The strongest sampled finite rollout is the acceleration-feasible response-
  demand gate: it captures at `19.2335T`, score `-0.17657`, with action RMS
  `25.19/28.56 rad/T^2`, lateral-force RMS `0.01232`, moment RMS `0.00690`, and
  local-flow RMS `(0.01752,0.00405)U`. Its paired sampled replication captures
  at `19.2830T`. Both finish on the low/right side of the target and retain the
  alternating wake through capture.
- The unclipped response-gate and collision-course-gate samples also retain
  coherent wakes and capture, but later at `19.8880T` and `19.7835T`; both
  approach from above. The collision-course gate has action RMS
  `32.01/67.26 rad/T^2`, lateral-force RMS `0.01230`, moment RMS `0.00690`, and
  local-flow RMS `(0.01770,0.00510)U`. Thus both route-demand and predicted-miss
  recruitment are viable, but neither the wake images nor low local flow
  support changing the carrier or adding disturbance rejection.
- The inherited logs expose a robustness failure hidden by the sampled four-
  capture set. A later candidate verified byte-identical to the best feasible
  response-gate policy reaches only `1.845L` and exits left with score
  `-9.7787`. The assigned parent's position/velocity-quadrature recoil observer
  still captures but worsens score from `-0.1822` to `-0.4546`, so offline
  beat-residual fit is not sufficient evidence for another observer expansion.
  Earlier removal of both terminal steering branches missed at `1.712L`, and
  `75%` posterior mean-steering relief missed at `3.191L`; route closure must
  remain distributed through the crossing.

## Policy hypothesis recorded before editing

Start from the sampled collision-course-gated distributed C-bend. Preserve its
normalized body-frame bearing, rotation-invariant LOS rate, phase-conditioned
posterior yaw correction, `28 degree`/`0.55T` traveling carrier, and anterior
predicted-miss recruitment. Add the independently completed response-demand
recruitment as a third smooth OR branch beside bearing and predicted miss.
This cue redundancy is intended to prevent a transient constant-velocity miss
estimate or a small bearing from releasing the anterior C-bend while bounded
LOS route demand remains large. Retain posterior steering continuously and
project both returned accelerations at the parameter-owned physical limit.

The expected outcome is finite capture despite either the sampled high-side or
low-side approach perturbation, with a coherent alternating wake and arrival
inside the completed `19.23--19.89T` band. Falsify the mechanism if the union
overturns or delays the route, loses capture, repeats the inherited `1.845L`
high pass, weakens the wake, increases applied saturation/load beyond the
sampled collision-course policy, or proves no more repeatable than a single
gate. This worker does not claim a new CFD result.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and response-gated burst redirect
source_mechanism: retain a propulsive rhythm while multiple observed route cues recruit and continuously release bounded mean curvature
transferable_invariant: preserve the evidenced traveling bend and keep route curvature closed when either target-demand or current collision-course evidence says steering is still required
nontransferable_details: published gains, species-specific kinematics, robot linkage geometry, dimensional frequencies, exact vortex phases, task-specific routes, and source burst timing
policy_translation: fuse normalized body-frame bearing, bounded LOS route demand, and constant-velocity miss evidence through a smooth OR for the anterior oscillator center while retaining posterior yaw feedback and the two-joint physical acceleration projection
falsification: reject if cue union loses or delays capture, causes oversteer or higher loads, degrades wake coherence, or fails to improve repeatability over the byte-identical single-gate miss

## Validation status

- The independent check-runner reports PASS for the material guidance update,
  PASS for the solver edit boundary, and no missing direct `params.FIELD`
  ownership. The 3D candidate remains non-empty and is the only edited solver
  file.
- Its lightweight Julia contract probe cannot start because this workspace
  image has no `julia` executable; system runtime searches found no alternate
  binary. This is an environment limitation, not a runtime pass.
- A translated 10,000-state audit reports finite acceleration-bounded commands,
  a redirect weight in `[0,1]`, and zero numerical residual under lateral
  reflection. No CFD rollout was run, and no outcome for this candidate is
  claimed.
