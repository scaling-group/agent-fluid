# Rate-reserve curvature-allocation candidate

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no cylinders or prewarm,
  finite moving-window transport, stable dynamics, and `capture` at
  `15.560--15.604T`. There is no failed termination in this batch, so the
  informative negative is the persistent actuator cost shared by four
  successful carrier-governor mechanisms.
- I inspected the combined release-to-capture sheets for the highest-score
  prefill `solver_cd24c4de2d66` and lowest-score
  `solver_d00ba28cf8bc`, including the top-down mid-plane vorticity row and
  oblique 3D body/Lambda2 row. Both fish self-propel from blank quiescent
  water, establish compact alternating shed vortices and coherent discrete 3D
  structures, make an early target-directed bend, and follow a shallow late
  curve into capture. Neither is passively advected, collides, exits, becomes
  unstable, or loses its traveling wake. The near-identical useful topology
  gives no basis for a new slip, load, or terminal steering residual.
- Metrics distinguish the mechanisms. Course-resolved joint-local release
  `solver_cd24c4de2d66` has the best score/distance integral
  (`0.09410/1.78768L`) but the longest path (`13.190L`) and still spends
  `17.31/9.06%` of samples above 90/99% of the anterior rate envelope. The
  plain joint-local full-demand guard `solver_d00ba28cf8bc` has the weakest
  score/integral (`0.08493/1.79624L`) but the shortest path (`12.994L`) and
  essentially the same anterior rate residence (`17.43/9.08%`). The
  posterior-work release reaches `13.016L` path with `17.36/8.87%` anterior
  residence; the common steering-aware guard raises peak planar force/yaw
  moment to `0.04226/0.02076` without reducing rate residence. Across all
  four, posterior greater-than-90/99% residence is only `6.35--6.66/0.00%`
  while the anterior joint reaches the `260 deg/T` hard envelope.
- The assigned parent and inherited step-36--39 notes already tested common
  versus joint-local carrier withdrawal, carrier reversal release, and
  course-resolution handoffs. Those changes retained capture and coherent
  wakes but left the anterior rate bottleneck at roughly the same level. This
  rejects another onset, strength, distance, response, or load scalar tune.
  The repeated asymmetry instead supports testing whether target-conditioned
  curvature can use the posterior joint's observed rate reserve.

## One-candidate policy hypothesis

Preserve the prefilled corrected-sign body-frame target geometry,
distance/closing drive relief, full velocity-course redirect, joint-phase
steering, posterior wave handoff, course-resolved carrier reversal, joint-local
full-demand preview, positive-work carrier withdrawal, soft command bounds,
and public two-joint contract. Add one rate-reserve steering allocation after
the existing full-demand preview: when target-conditioned head steering is
pushing joint 1 farther in its current velocity direction and its smooth
preview guard is active, remove a bounded share of that steering acceleration
from joint 1 and add the same share to joint 2 only to the extent that the
posterior preview guard reports reserve. This preserves the pre-limit sum of
the two joint accelerations (the mean-curvature channel), leaves the traveling
carrier and reversal logic unchanged, and uses only normalized joint state.

Expected signature: retain capture, early milestones, distance integral, the
short shallow approach, and both coherent wake views while reducing anterior
greater-than-99% rate residence without creating posterior contact. Falsify if
capture or wake coherence is lost; timing/integral leaves the current sampled
class without a material actuator benefit; or path, posterior rate residence,
joint-angle margin, mean command, planar force/yaw moment, terminal course, or
finite-action checks regress. The new CFD result occurs only after this worker
exits and is not evidence claimed here.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and Lighthill-style distributed reactive propulsion
source_mechanism: sensor feedback allocates a target-conditioned residual around a phase-coupled traveling bend while retaining posterior propulsive participation
transferable_invariant: preserve traveling-wave direction and total requested curvature while shifting bounded corrective effort toward the actuator with observed instantaneous reserve
nontransferable_details: published gains, dimensional frequencies, clocked phases, species-specific envelopes, full-body joint distributions, exact vortex phases, and source-task coordinates or routes
policy_translation: use each joint's normalized full-demand rate preview; transfer only outward target-conditioned anterior steering to the posterior joint while posterior reserve remains, leaving carrier phase, reversal, and body-frame target feedback intact
falsification: reject if anterior rate residence does not materially fall or if capture, timing/integral, path, posterior margin, loads, finite action, terminal course, or coherent top-down and oblique wakes leave the sampled useful class
