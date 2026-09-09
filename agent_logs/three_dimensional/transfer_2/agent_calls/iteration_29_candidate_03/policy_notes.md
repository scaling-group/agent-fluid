# Predictive response-priority carrier candidate

## Evidence read before editing

- All four sampled episodes satisfy the release contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no prewarm or cylinders, finite
  moving-window transport, and capture. There is no semantic non-capture in
  this batch, so `solver_b505efd9ced6`, the lowest-scoring capture, is the
  informative regression rather than an invented failure class.
- The combined sheets for best finite `solver_3fdd63b3fbda` and regressed
  `solver_b505efd9ced6` were read from release through capture in both rows.
  The top-down vorticity views show self-propulsion from blank still water and
  coherent alternating tail-shed structures, not advection. The oblique
  Lambda2 views show three-dimensional vortex packets remaining organized
  through each turn with no wake collapse or instability. The best case makes
  a broader early sweep and reaches a nearly straight terminal corridor sooner;
  the regression retains the wake class but spends longer on a shallow,
  gently wavering approach.
- Metrics support retaining response-priority redirect. It captures at
  `16.044T` with distance integral `1.82409L`, advancing every inherited
  `10/8/6/4/2/1L` milestone, while the positive-work and predictive-barrier
  samples capture at `17.413/17.418T` with integrals `1.94829/1.93044L`.
  Its boundary remains a wider `13.178L` head path, peak planar force/yaw
  moment `0.03579/0.01770`, and `17.76/8.12%` residence above 90% joint rate.
- The assigned load-aware parent does not establish hydrodynamic-load carrier
  withdrawal as a useful mechanism. Relative to the redirect sample it reduces
  peak force only `0.03579 -> 0.03500`, peak moment `0.01770 -> 0.01755`, and
  rate residence only `17.76/8.12 -> 17.49/7.85%`; capture regresses to
  `16.258T`, integral to `1.83377L`, and path to `13.191L`. This misses the
  parent's own material load/path falsification test, so the new candidate
  removes the load guard rather than tuning its scalar thresholds.
- The predictive common-carrier barrier separately demonstrated a meaningful
  actuator effect: versus the positive-work guard, it reduced greater-than-90%
  rate residence from `16.14/8.81%` to `15.03/0.73%`, reduced command-bound
  residence from `35.82/31.14%` to `23.24/20.52%`, and slightly lowered peak
  force/moment from `0.03050/0.01564` to `0.03001/0.01495`, while preserving
  capture timing (`17.418T` versus `17.413T`) and the coherent wake class.

## One-candidate policy hypothesis

Restore the evaluated redirect-priority controller and compose its one useful
new trajectory mechanism with the evaluated predictive common-carrier rate
allowance. For each joint, forecast outward rate from normalized joint state
and separated carrier/steering accelerations over a short gait-phase fraction;
the smaller allowance scales both carrier commands together. Retain the
existing body-frame unfulfilled-course request as a bounded additional
allowance reduction only near the rate envelope, so directional steering keeps
priority until signed yaw responds, while the carrier phase and steering
residual remain intact. No load feedback, terminal gate, route coordinate, or
scalar gait retuning is added.

Expected signature: retain the redirect sample's early milestone and capture
class while moving posterior rate and command residence toward the predictive
barrier class, without worsening its coherent two-view wake, zero angle-limit
residence, path, force/moment, integral, or terminal yaw/slip. Falsify the
composition if capture slows outside repeat variation without a material rate
benefit, if the `10/8/6L` milestones regress toward the non-redirect samples,
or if path/load, joint margin, command effort, wake coherence, or stability
worsens. If falsified, keep the evaluated redirect-priority controller and do
not revive scalar load suppression.

bookshelf_consulted: true
source_domain: classical slender-body swimming, C-start turning, and sensor-modulated robotic-fish CPG control
source_mechanism: release a strong target-conditioned redirect into a coordinated posterior-lag propulsive wave once measured turning response appears
transferable_invariant: preserve inter-joint carrier phase and directional steering while state feedback bounds outward rhythmic rate and releases redirect priority on measured response
nontransferable_details: published gains, dimensional cadence, species-specific body envelopes, exact vortex phase, full-body kinematics, and task-specific routes
policy_translation: combine normalized two-joint predictive rate allowances with the existing body-frame course-error and signed-yaw response request, then apply the single most restrictive bounded scale to both carrier accelerations while leaving steering residuals intact
falsification: reject if early target progress or capture regresses without material rate and command headroom, or if path, loads, joint margins, stability, or either coherent wake view worsens
