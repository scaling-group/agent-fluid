# Multi-wake policy candidate notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the fish held at the common upper-right
  release pose while four staggered cylinder streets develop and merge around
  the target. The released sheets therefore share one mature-wake initial
  condition; their agreement is deterministic materialization evidence, not
  evidence of robustness to a changed wake.
- The strongest sampled finite policy is the assigned-parent course-consistency
  candidate. Its released sheet shows a coherent body-generated traveling wake,
  continuous self-propelled down-left motion, one broad correction in the
  merged wakes, and first-crossing capture. Three byte-identical samples repeat
  `target_reached` at `45.61`, `1.7222L` mean and `0.7471L` final/minimum
  distance, `-11.06/-4.73L` head displacement, and `453/4406` force/moment RMS.
  Mean body velocity is more upstream than mean local flow (`-0.241` versus
  `-0.174`), so the route is actively propelled rather than downstream
  advection.
- The most useful sampled contrast is the otherwise matched normalized-positive-
  closure policy without course-consistency tail scaling. Its released sheet
  has the same successful topology and reaches slightly earlier at `45.48`,
  with `1.7244L` mean distance and much lower `405/4029` force/moment RMS.
  Course-conditioned tail scaling therefore bought only `0.0023L` in distance
  integral while delaying arrival, increasing force RMS by about `12%` and
  moment RMS by about `9%`, and leaving both joints at their `4.538` rad/time
  rate cap. Three exact repeats add no semantic improvement. This argues
  against amplifying the posterior course multiplier or another gait scalar.
- No failure keyframe is present in the current sampled sheets. The inherited
  parent logs provide the applicable negative boundary without supporting a
  visual claim: a propulsive-priority allocator passed below capture and
  collided at `58.93`, after a `1.872L` closest approach and `537/4995` loads.
  Preserve the successful oscillator, yaw-load gate, distributed half-cycle
  steering, and bounded posterior residual rather than reallocating broad
  propulsion.

## Policy hypothesis

Keep the parent's successful traveling-bend and small course-conditioned
posterior residual, but add one bounded course-over-ground correction in the
route channel. Windowed body-frame bearing rate contains both body yaw and
translation-induced line-of-sight drift; adding observed heading rate isolates
the latter approximately. A small, capped look-ahead of that translational
drift is added to the existing heading-predicted bearing before the unchanged
yaw gate and half-cycle steering. The correction is zero when there is no
history or no translation-induced drift, and it never reads wake phase,
coordinates, elapsed time, or a prescribed route.

The hypothesis is that route-side course information will anticipate lateral
slip in the merged wakes without asking the already cap-contacting posterior
joint for more drive. Falsify it if the next CFD rollout loses capture, exceeds
the `1.7222L` mean-distance baseline, changes to collision/domain exit, or
raises rate-limit residence or `453/4406` force/moment RMS without a useful
trajectory improvement. Success on the fixed snapshot would still not prove
robustness to changed wake phase, inflow, geometry, or target.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG path following and target-geometry steering
source_mechanism: sensor feedback modulates a low-dimensional rhythmic controller through a bounded route residual rather than raw high-frequency joint actuation
transferable_invariant: preserve the established traveling wave and use measured body-frame line-of-sight motion to correct course before increasing propulsive effort
nontransferable_details: published gains, oscillator parameters, robot linkage geometry, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: isolate approximate translation-induced bearing drift as windowed bearing rate plus heading rate, cap a short look-ahead correction, and add it only to predicted body-frame bearing upstream of the existing yaw-gated two-joint steering law
falsification: reject if target capture, distance history, or route topology regresses, or if saturation and hydrodynamic loads increase without compensating progress
