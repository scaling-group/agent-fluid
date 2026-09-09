# Step 37 target-policy diagnosis

## Evidence read before candidate selection

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and stable capture at
  `0.74923--0.74986L` after `18.4525--18.7495T`. The best-scoring qualifier
  (`solver_ac993a461b7c`) and slowest anterior-transfer capture
  (`solver_55f3a103ab95`) both visibly self-propel: their top-down rows retain
  an alternating vorticity street and their oblique rows retain bilateral
  Lambda2 structures from release through capture. There is no visual or
  metric basis for replacing the posteriorly lagged traveling carrier.
- The assigned parent's `dogfish3d_progress_loss_burst_redirect_v1` rollout is
  the informative failure. It also uses direct uniform still water and remains
  numerically stable, but exits the lower boundary after a `1.16080L` closest
  pass and finishes at `9.84225L`. Its combined sheet retains the organized
  wake through the first pass; by `24--31.48T` the body has redirected without
  forming a second target approach. This is a path-response failure, not
  advection, collision, or initial carrier failure.
- The deployed moving-window observation does not contain
  `window_closing_speed_L`, so the parent's `hasproperty` branch used the
  instantaneous `closing_speed_L` fallback rather than the eight-row signal
  described in its notes. Replaying that actual gate over the saved traces
  still gives zero active rows in all four sampled captures, but on the parent
  failure it begins only at `18.843T`, `1.1611L`, and `-0.0404L/T`, after the
  first minimum at `18.826T`. It remains active for 607 rows, reaches the
  configured `10 rad/T^2` residual bound, and has both returned actions clamped
  on only about `6.3%` of active rows. The unchanged termination class is
  therefore not evidence for increasing that symmetric bend or its gain.
- Two current samples are exact bytes of the prefilled
  `dogfish3d_intercept_guarded_speed_reserve_v1` and both capture with coherent
  two-view wakes. Inherited guidance records three exact-byte captures for this
  baseline and also warns that its fixed-condition success is not universal.
  It is nevertheless the strongest repeat-backed rollback after the assigned
  parent's new recovery mechanism failed.

## Candidate hypothesis

Materialize exactly the prefilled intercept-guarded speed-reserve policy (SHA
`567de354e2bf646dce0776b20e284aabc896c7816eafff848839efa2937b9dac`) as a
clean rollback candidate. Preserve raw achieved-course feedback, the inner
intercept release guard, additive steering allocation, sparse outward-only
carrier reserve, and the active posteriorly lagged bend. Do not retain the
late progress-loss mean-curvature residual and do not stack another terminal
cue onto this reliability trial.

This candidate should recover the sampled capture topology without changing
the known wake, actuator, or load mechanism. It is not evidence that baseline
capture is universal. Falsify the selection if the exact repeat exits, loses
the active alternating wake, changes far-field closure, or leaves the inherited
actuator/load envelope. A later recovery proposal should use an evidenced
pre-pass predictor and must audit the field actually exposed by the formal
moving-window observation.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-feedback robotic-fish direction control
source_mechanism: response-gated redirect superposed on a separately sustained rhythmic carrier
transferable_invariant: a redirect must engage from an observed response early enough to change the miss and must release without replacing the propulsive traveling bend
nontransferable_details: species-specific bend angles, published gains, clocked CPG phase, dimensional burst timing, robot morphology, exact vortex phase, and task-specific routes
policy_translation: do not carry the assigned parent's post-pass symmetric redirect forward; retain the normalized body-frame two-joint carrier as the exact rollback control while earlier predictive response remains a separate future hypothesis
falsification: reject the rollback as reliable if its exact repeat misses or disrupts closure, either wake view, actuator use, or loads; reject any future redirect that cannot act before the evidenced first-pass minimum
