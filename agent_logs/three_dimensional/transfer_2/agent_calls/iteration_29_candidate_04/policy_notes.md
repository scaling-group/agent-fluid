# Response-released carrier-reversal candidate

## Evidence and visual diagnosis before editing

- All four sampled episodes are valid direct-uniform still-water releases:
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window
  transport, stable dynamics, and capture. There is no sampled semantic
  failure, so `solver_b505efd9ced6` is the informative regression rather than
  a fabricated non-capture.
- The combined sheets were inspected in both rows from release to capture.
  In the highest-scoring redirect-priority sample `solver_3fdd63b3fbda`, the
  top-down row shows motion developing from blank quiescent water, a compact
  alternating tail wake, and a strong target-directed sweep; the oblique row
  shows coherent three-dimensional Lambda2 structures remaining attached to
  that self-propelled trajectory. The lowest-scoring positive-work sample
  retains the same coherent wake and target turn, but visibly advances more
  slowly. The predictive-rate and load-aware sheets likewise preserve wake
  coherence, so none supports changing the gait or cancelling lateral motion.
- Metrics identify redirect priority as the useful mechanism. The evaluated
  whole-carrier redirect captures at `16.044T`, distance integral `1.82409L`,
  with milestones `5.863/7.838/9.779/11.726/14.201/15.604T` at
  `10/8/6/4/2/1L`. Preserving negative-work reversal unconditionally slows
  capture to `17.413T/1.94829L`, but shortens the head path from `13.178L` to
  `12.269L`, reduces peak force/moment from `0.03579/0.01770` to
  `0.03050/0.01564`, and lowers sub-`2L` mean absolute yaw from `0.0943` to
  `0.0244 rad/T`.
- The inherited load-aware worker tested norm-triggered carrier withdrawal.
  Its evaluated child `solver_df7e79c50e02` preserved early `10/8L`
  progress but captured later at `16.258T/1.83377L`, widened path slightly to
  `13.191L`, and raised sub-`2L` yaw to `0.1282 rad/T`, while improving peak
  force/moment only to `0.03500/0.01755`. Productive axial load and deliberate
  lateral turning load therefore should not be treated as a generic overload
  request on this still-water release.

## One-candidate policy hypothesis

Start from the evaluated redirect-priority controller. Keep its target
geometry, course redirect, approach schedule, joint-state oscillator,
carrier/steering decomposition, common carrier scale, and final command
contract. While the requested redirect lacks same-sign measured yaw response,
continue scaling the full two-joint carrier so directional steering has
priority. As aligned yaw response appears, continuously restore only the
negative-work carrier components that reverse each joint, in proportion to
that response. This is a response-driven release from a burst redirect into
the traveling bend; it adds no stage counter, load threshold, terminal gate,
or scalar gait tune.

Expected signature: retain the redirect sample's early milestone class and
capture while moving peak load, path, rate residence, and terminal yaw toward
the reversal-preserving sample. Falsify the mechanism if capture or either
coherent wake view is lost; if the `10/8/6L` milestones or timing/integral
regress toward the `17.41T/1.95L` class without material path/load/rate benefit;
or if joint margin, commands, terminal slip/yaw, path, force, or moment exceed
the redirect-priority sample. Because the new CFD result arrives only after
this worker exits, these are predictions, not current evidence.

bookshelf_consulted: true
source_domain: fish C-start burst redirects, sensor-modulated robotic-fish CPG control, and slender-body traveling-wave propulsion
source_mechanism: strong curvature redirects the body until measured heading response appears, then releases into coordinated anterior-to-posterior rhythmic propulsion
transferable_invariant: use observed signed turn response to hand authority continuously from directional steering back to phase-coherent joint reversal
nontransferable_details: species-specific C-start kinematics, published gains and cadence, full-body waveforms, dimensional load scales, exact vortex phase, and task-specific routes
policy_translation: while body-frame course error is unfulfilled, apply the evaluated common scale to the full carrier; as normalized yaw aligns with the bounded turn request, restore only negative carrier-work reversal at both joints without changing steering residuals
falsification: reject if early progress or capture regresses without lower path, load, rate residence, and terminal yaw, or if the traveling wake, joint margin, or bounded action contract deteriorates
