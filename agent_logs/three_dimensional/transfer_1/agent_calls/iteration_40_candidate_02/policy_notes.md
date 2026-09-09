# Step 40 wake-policy diagnosis

## Evidence read before the edit

- All four sampled solver rollouts satisfy the direct-uniform still-water
  contract (`U_infinity=(0,0,0)`, no cylinders, no prewarm) and capture at
  `0.74846--0.74986L`. Three are exact repeats of the assigned-parent
  `dogfish3d_intercept_guarded_speed_reserve_v1`; the fourth is the
  outer-terminal unsupported-bearing qualifier. In every combined sheet, the
  fish self-propels from release, forms a persistent alternating top-down
  vorticity street, and retains bilateral oblique Lambda2 structures through
  capture. The candidate therefore must preserve the traveling carrier and
  address interception geometry rather than add propulsion or cadence.
- The strongest sampled scalar result is the bearing qualifier's `0.74986L`
  capture at `18.6560T` and score `-0.14991`, but inherited exact replay passed
  at `1.18462L` and exited below with the same organized wake. Its `1/2`
  record makes scalar tuning or replay less informative than a response cue
  with independent repeat evidence. The assigned-parent speed-reserve baseline
  is likewise semantically fragile at `4/6`, despite the three current sampled
  captures.
- The most informative inherited failure is the hard capture-corridor
  certificate. Its direct-uniform rollout remained visibly self-propelled with
  both coherent wake views before and after a `1.67826L` closest pass, then
  over-turned below the target and exited at `10.28354L`. Replacing graded
  response release with binary full steering retention therefore failed on
  terminal path geometry, not advection, carrier collapse, or instability.
- Two soft pre-pass mechanisms then captured while preserving both wake views.
  Partial outer steering retention is only `1/1`. More decisively, exact bytes
  of `dogfish3d_outer_los_rate_intercept_v1` captured twice: first at
  `0.74605L` and `18.2985T`, then at `0.74957L` and `18.8980T`. The second
  repeat's head/tail action clipping (`68.42%/70.78%`), speed-limit residence
  (`10.54%/11.35%`), and peak body-force/moment coefficients
  (`0.01476/0.02872/0.01566`) remain inside the sampled baseline envelope.
  Its scores are not better because mean-distance cost is slightly higher;
  the reusable improvement is repeated capture without disrupting the wake or
  actuator/load envelope.

## Candidate hypothesis

Install the exact evaluated `dogfish3d_outer_los_rate_intercept_v1` policy,
without tuning or stacking another mechanism. It preserves the assigned
parent's raw achieved-course servo, response-conditioned inner intercept
guard, sparse outward-only carrier reserve, two-joint steering shares, and
posteriorly lagged traveling bend. Its sole addition is a bounded body-frame
residual that opposes inertial line-of-sight rotation only while approaching
between `4L` and `1.5L`; it fades before capture and cannot become post-pass
recovery.

This is a mechanism promotion based on two exact-policy semantic successes,
not a scalar gain sweep. Falsify it if another direct-uniform repeat misses or
exits, changes far-field closure, weakens either wake view, or moves clipping,
joint-speed residence, force, or moment beyond the repeat-backed baseline
envelope. The current worker does not claim a same-worker CFD result.

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish direction tracking over an independently sustained rhythmic CPG
source_mechanism: bounded line-of-sight-rate interception feedback superposed on an independently sustained propulsive rhythm
transferable_invariant: use observed target-response geometry for a small steering residual while keeping the propulsive traveling bend independently active
nontransferable_details: published gains, clocked CPG phase, robot morphology, dimensional timing, species kinematics, exact vortex phase, and task-specific routes
policy_translation: derive normalized inertial LOS rate from body-frame target and velocity cross product, apply one bounded approaching outer-terminal residual through the existing two-joint steering shares, and release it before inner capture
falsification: reject if another exact repeat loses capture, retains the coherent lower-exit topology, degrades either wake, or moves actuator and load metrics outside the repeat-backed envelope
