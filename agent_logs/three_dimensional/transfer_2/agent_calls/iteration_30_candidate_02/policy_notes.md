# Wake-policy diagnosis and candidate hypothesis

## Evidence diagnosis

- All four sampled rollouts use `uniform_direct` initialization with
  `U_infinity=(0,0,0)`, contain no cylinders, and capture. The motion is
  therefore self-propelled rather than imposed advection. In both combined
  views, the fish builds an alternating top-down vorticity street and compact
  three-dimensional Lambda2 structures that remain coherent through approach.
- The best finite sample, `solver_3fdd63b3fbda`, captures at `16.0435T` with
  score `0.05824`, distance integral `1.82409L`, head path `13.1775L`, peak
  planar force/yaw moment `0.03579/0.01770`, and greater-than-90%-rate
  residence `17.8/8.1%`. Its byte-identical repeat `solver_fae128ecdedf`
  captures at `16.0930T`; that spread is the local repeat boundary.
- The informative regression, `solver_3cd7c6486ead`, replaces the
  response-priority common carrier governor with a predictive rate barrier.
  It keeps a coherent wake and shortens head path to `12.5280L`, while lowering
  peak planar force/yaw moment to `0.03001/0.01495`, but delays every distance
  milestone and capture to `17.4185T`, raising the distance integral to
  `1.93044L`. Its lower loads are therefore coupled to excessive propulsion
  withdrawal rather than a better target trajectory.
- Instantaneous body-load relief in `solver_df7e79c50e02` also fails to clear
  repeat variation: capture is later at `16.2580T`, integral is `1.83377L`,
  path grows to `13.1906L`, and peak force/moment falls only to
  `0.03500/0.01755`. Productive self-generated load is not a reliable generic
  guard request in this direct-quiescent release.
- Inherited step-26--29 score logs remain in the same capture class while
  moving from negative to about `0.05`; together with the current predictive,
  load-aware, and repeat results, they satisfy the three-iteration plateau
  trigger for a new controller mechanism rather than another threshold edit.

## Candidate hypothesis

Preserve the assigned parent's complete target/capture scaffold and its common,
phase-preserving carrier scale. Change only how the guard releases: once the
bounded body-frame route request has a same-sign measured yaw response, use
net negative carrier work as a joint-state phase signal and continuously
restore the common traveling carrier during reversal. Before that response,
the existing unfulfilled-redirect term keeps full steering priority; during
positive net carrier work, the existing uncancelled positive-work guard remains
active. This tests response-gated reversal authority without a clock, route,
load threshold, or scalar-only gait retune.

Expected result: retain the `16.044--16.093T` capture/timing class and coherent
two-view wake while reducing late path, rate residence, or force/moment relative
to the repeated baseline. Reject the mechanism if arrival or distance integral
falls outside repeat variation without a material actuator/load/path benefit,
if the predictive-barrier delay returns, or if joint margin or wake coherence
regresses.

bookshelf_consulted: true
source_domain: biological burst turning combined with elongated-body reactive swimming
source_mechanism: release a strong redirect into a posterior traveling beat when the observed turn response appears
transferable_invariant: preserve bounded steering priority until same-sign yaw response, then restore reversal phases that maintain a directed traveling bend
nontransferable_details: species kinematics, published gains and frequencies, exact C-start stages, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame course/target error, bounded measured yaw response, joint velocity, and carrier acceleration to release one common carrier scale only during net negative carrier work
falsification: reject if capture timing or integral leaves the baseline-repeat class without material path/load/rate improvement, or if joint margin, terminal control, or either wake view regresses
