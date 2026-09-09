# Predictive positive-work carrier governor

## Visual diagnosis before editing

- All four sampled solver rollouts and the assigned-parent rollout satisfy the
  frozen evidence contract: direct uniform `U_infinity=(0,0,0)` initialization,
  no cylinders or prewarm, finite moving-window transport, stable dynamics, and
  `capture`. No semantic termination failure is available, so the informative
  failure is the repeat-bounded path and actuator regression within this common
  capture topology.
- I inspected both rows of the combined keyframe sheets from release to
  termination for the strongest sampled finite result
  `solver_1d05d22ea1fe`, the lowest-scoring sampled result
  `solver_8d0068c45885`, and the assigned-parent repeat. In every top-down row,
  the fish begins in blank still water, turns toward the target under its own
  motion, and leaves a compact alternating caudal vortex street. The matching
  oblique rows show discrete three-dimensional Lambda2 structures trailing the
  caudal region through the shallow capture arc. There is no visual evidence of
  advection, collision, domain exit, unproductive flailing, or wake collapse.
  Preserve the traveling carrier, corrected target sign, course redirect, and
  range-specific approach restoration.
- The strongest sampled range-specific restoration captured at `15.939T`,
  with `1.82008L` distance integral and `13.107L` head path. The same policy
  bytes in the assigned parent captured at `16.198T`, with `1.82807L` integral
  and `13.185L` path; therefore a timing change smaller than this `0.259T`
  repeat spread is not a reliable mechanism improvement. The other sampled
  captures occupy `16.022--16.088T`, `1.82203--1.82375L`, and
  `13.129--13.166L`, consistent with visually similar late arcs.
- Actuator diagnostics expose a more repeatable deficit. Across the four
  sampled captures, the anterior joint spends `17.50--17.71%` of the rollout
  above 90% of the hard rate and `11.93--12.18%` above 99%; the assigned-parent
  repeat remains at `17.39%/11.85%`. The posterior joint is lower but still
  reaches the rate envelope. Mean acceleration stays near
  `16.5/15.3 rad/T^2`, while soft-limited peaks approach `30.5/31.0`. Thus the
  existing positive-work/reversal decomposition preserves capture but its
  actual-rate trigger acts too late to establish actuator protection.

## One-candidate policy hypothesis

Use the evaluated approach-restored carrier as the baseline and add one new
feedback mechanism: a short phase-space lookahead for outward carrier work.
For each joint, project normalized absolute rate over a small fraction of the
state-feedback oscillator period using only the bounded carrier acceleration
that has the same sign as current joint velocity. Drive the existing smooth
rate gate from the larger of measured and projected rate. Continue to attenuate
the two positive-work carrier components with one common scale, pass
negative-work reversal according to the evaluated range-specific release, and
leave target-conditioned steering residuals untouched.

Expected signature: preserve capture, early milestones, shallow target arc,
and coherent top-down/oblique wakes while materially reducing anterior
greater-than-99% rate residence and ideally greater-than-90% residence without
increasing command, load, path, or distance integral. Because identical-policy
timing varies by at least `0.259T`, actuator relief must be visible directly and
any timing/integral claim must exceed repeat spread. Falsify if capture or far
progress is lost; either wake loses coherence; joint margin, command, peak
force/moment, path, terminal yaw/slip, or distance integral worsens; or rate
residence does not fall enough to distinguish prediction from the prior
actual-rate-only guard.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and reactive traveling-wave propulsion
source_mechanism: close the rhythmic-drive loop on observed locomotor state so excess positive work is withdrawn before an actuator envelope is reached while phase-coupled reversal is retained
transferable_invariant: regulate energy-adding carrier action prospectively from normalized joint state without cancelling energy-removing reversal or target-conditioned steering
nontransferable_details: published CPG gains, dimensional lookahead or cadence, species-specific body waves, full-body kinematics, exact vortex phase, and task coordinates or routes
policy_translation: project each normalized joint rate over a small fraction of the controller period using only same-sign bounded carrier acceleration, feed the maximum projected rate to the existing common positive-work carrier gate, and preserve approach-restored reversal plus the body-frame steering residual
falsification: reject if greater-than-99% and greater-than-90% rate residence do not materially fall, or if early progress, capture, timing beyond repeat spread, integral, path, command, load, joint margin, terminal yaw/slip, finite action, or coherent top-down and oblique wakes regress
