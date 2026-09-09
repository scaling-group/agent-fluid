# Response-released carrier-reversal candidate

## Evidence and visual diagnosis written before editing

- All four sampled episodes are valid direct-uniform still-water releases:
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window
  transport, stable dynamics, and `capture`. There is no semantic failure in
  this cohort, so the predictive-rate capture is the informative regression
  rather than evidence for replacing the successful target route.
- Both rows of every combined keyframe sheet were inspected from release to
  capture. The strongest finite redirect-priority sample
  `solver_3fdd63b3fbda` develops a compact alternating top-down vorticity wake
  from blank quiescent water, follows a continuous shallow arc toward the
  target, and retains coherent oblique Lambda2 structures behind the caudal
  region. The lower-scoring predictive-rate sample `solver_3cd7c6486ead`
  shows the same self-propelled wake class but visibly advances more slowly;
  neither view shows passive advection, wake collapse, collision, exit, or
  instability before capture. The load-aware and repeat redirect sheets
  support the same diagnosis.
- The two byte-identical redirect-priority rollouts delimit repeat variation:
  capture at `16.044/16.093T`, distance integral `1.82409/1.82848L`, and
  scores `0.05824/0.05428`. They reach `10/8/6L` by about
  `5.86/7.84/9.79T`, materially ahead of the predictive-rate policy at
  `6.331/8.591/10.752T`, `17.418T`, and `1.93044L`. The response-aware
  target redirect is therefore preserved.
- That fast class has a repeatable actuator/load boundary: anterior residence
  above 99% of the `260 deg/T` rate envelope is `12.24%`, head path is
  `13.09--13.18L`, and peak planar-force/yaw-moment coefficients are
  `0.03579--0.03634/0.01770--0.01794`. The predictive barrier lowers those
  quantities to `4.23%`, `12.528L`, and `0.03001/0.01495`, but sacrifices
  progress. The sampled instantaneous force/moment gate captures at
  `16.258T/1.83377L`, slightly lengthens path to `13.191L`, and lowers the
  peaks only to `0.03500/0.01755`; it does not justify another load-threshold
  tune.
- Inherited optimizer logs supply the complementary negative result.
  Unconditionally passing negative-work reversal lowers path, load, and
  terminal yaw, but regresses to `17.413T/1.94829L` and raises mean command.
  Thus neither scaling all carrier reversal during an already-established
  turn nor releasing all reversal at every phase is supported. The unresolved
  mechanism is the handoff between these regimes, using measured directional
  response rather than distance, time, or a load threshold.

## One-candidate hypothesis and falsification

Start from the evaluated redirect-priority controller and preserve its
corrected-sign body-frame target vector, course redirect, distance/closing
relief, half-cycle steering, posterior handoff, traveling carrier, and bounded
command contract. While course redirection lacks same-sign measured yaw,
retain the evaluated common scale on the full carrier so steering has
priority. As normalized yaw aligns with the turn request, continuously restore
only each joint's negative-work carrier component; positive-work carrier and
all target-conditioned steering retain their existing treatment. This is one
state-released burst-to-rhythm mechanism, not a scalar gait tune or a new
terminal route.

Expected signature: retain the redirect samples' early milestone and coherent
capture class while moving head path, near-bound rate residence, peak load,
and terminal yaw toward the reversal-preserving class. Falsify the mechanism
if capture/integral regress beyond the observed `0.050T/0.0044L` repeat spread
without a material path/load/rate benefit; if early `10/8/6L` progress moves
toward the predictive or unconditional-release class; or if joint margin,
commands, terminal slip/yaw, path, force/moment, or either coherent wake view
exceeds the sampled redirect-priority boundary.

bookshelf_consulted: true
source_domain: fish C-start redirection, sensor-modulated robotic-fish CPG control, and slender-body reactive propulsion
source_mechanism: strong bounded curvature redirects the swimmer until measured directional response appears, then releases into a coordinated posterior-lag traveling bend
transferable_invariant: use observed signed turn response to hand authority continuously from a directional burst back to phase-coherent joint reversal
nontransferable_details: species-specific C-start kinematics, published gains and cadence, dimensional load scales, full-body waveforms, exact vortex phase, and task-specific routes
policy_translation: while normalized body-frame course error is unfulfilled, retain the evaluated common full-carrier scale; as normalized yaw aligns with the bounded target turn request, restore only negative carrier-work reversal in the two-joint state feedback while steering residuals pass unchanged
falsification: reject if early progress or capture regresses outside repeat variation without lower path, load, rate residence, and terminal yaw, or if the traveling wake, joint margin, or bounded action contract deteriorates

## Post-edit non-CFD validation

- The configured guidance-materiality check passes after removal of the
  duplicated assigned-parent marker in the rendered workspace `README.md`.
- The solver boundary check passes: only
  `cases/dogfish_3d_shape_policy/candidate_target_policy.jl` differs from the
  solver baseline, so exactly one downstream candidate is present.
- A static schema audit finds all 35 direct `params.FIELD` references among
  the 36 fields returned by `target_policy_params()`, with no missing field or
  forbidden time, randomness, mutable state, or cylinder-coordinate token.
- The candidate is byte-identical to the inherited response-released branch
  artifact whose optimizer log reports a passing finite two-acceleration Julia
  contract. The mandated local Julia invocation could not be repeated because
  this workspace has no `julia` executable on `PATH`; no CFD was run.
