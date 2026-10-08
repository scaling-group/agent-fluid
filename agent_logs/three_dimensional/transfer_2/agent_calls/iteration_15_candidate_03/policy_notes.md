# Joint-rate-reserve candidate

## Evidence diagnosis before the policy edit

- The four sampled solver examples are byte-identical course-preview controls.
  Each starts from direct uniform still water with U_infinity=[0,0,0], no
  cylinders, and no prewarm, then captures at 24.5795T with minimum/final
  distance 0.746968L and mean distance 2.36044L. Their shared top-down row
  shows a self-propelled diagonal approach, coherent alternating mid-plane
  vortex street, and late target-directed redirect. Their shared oblique row
  shows compact three-dimensional Lambda2 structures persisting through the
  redirect and crossing, with no wake breakup, passive advection, or unstable
  motion.
- The sampled capture is physically useful but actuator-limited: the posterior
  joint occupies the 45 deg hard stop for 23.383% of its trace, any joint
  occupies the 260 deg/T rate limit for 15.149%, and peak absolute planar
  body-frame force/yaw-moment coefficients are 0.269/0.178/0.143.
- The assigned-parent inherited logs contain two later completed mechanisms.
  Outward-rate prediction retains capture at 24.5960T, reduces peak
  force/moment coefficients to 0.149/0.097/0.0667, but does not improve
  hard-stop or rate occupancy (12.634/15.139%). Its successor's bounded
  braking reserve retains capture at 24.6290T, minimum/final distance
  0.748702L, and mean distance 2.36161L; eliminates sampled posterior
  hard-stop occupancy; and further lowers force/moment peaks to
  0.0241/0.0303/0.0149. Both visual rows preserve the coherent wake and
  route topology. This is a strong semantic improvement and is the controller
  to preserve.
- The braking-reserve trace isolates a remaining carrier defect. Any-joint
  rate-limit occupancy is still 15.163%: 9.357% on the anterior joint and
  5.806% on the posterior joint. Every rate-limit sample still has
  acceleration aligned with joint velocity, with mean velocity-aligned
  acceleration 13.80 and 22.82 rad/T^2, respectively. Thus rate clipping
  is not necessary braking or the terminal stroke filter; it is an unchanged
  rhythmic command continuing to accelerate an already saturated joint.

## Policy hypothesis

Start from the completed braking-reserve controller without changing course
preview, route requests, posterior stroke logic, cadence, or traveling-wave
targets. Add one actuator-level velocity barrier after existing allocation.
For each joint, use absolute observed joint rate to blend a permitted
velocity-aligned acceleration from the owned acceleration envelope toward a
small inward braking reserve over 250--260 deg/T. Replace only a command
that exceeds this permitted value; preserve commands below the band and
commands already braking the measured motion. The construction is symmetric
under joint/velocity sign reversal and contains no target route, clock, or
world-frame direction.

Expected evidence is preserved capture, far-path/wake topology, zero sampled
posterior hard-stop occupancy, and the braking-reserve load class, together
with any-joint rate-limit occupancy below 15.163%. Falsify the mechanism if
capture is lost, the final crossing margin is weaker than the inherited
conditional handoffs, the coherent traveling wake changes materially, the
posterior hard stop returns, peak planar loads leave the v32 low-load class, or
rate-limit occupancy does not decrease. Raw acceleration-envelope exposure is
not an acceptance criterion because inherited output projection was
dynamically equivalent to downstream clipping.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and elongated-body posterior reactive swimming
source_mechanism: proprioceptive feedback modulates a bounded rhythmic command while preserving the phase-lagged traveling wave that supports posterior reactive thrust
transferable_invariant: finite joint rate should shape only the velocity-increasing part of a state-feedback rhythm before downstream clipping, while unconstrained phase and already-braking commands remain intact
nontransferable_details: published gains, dimensional cadence, species kinematics, full-body envelopes, exact vortex phase, Strouhal targets, and task-specific routes
policy_translation: apply a sign-symmetric joint-rate barrier to both final joint commands using normalized observed rate and the owned rate and acceleration envelopes
falsification: reject if capture, coherent wake, zero posterior hard-stop occupancy, or the inherited low-load class is lost, or if any-joint rate-limit exposure does not fall below 15.163 percent

## Pre-evaluation validation

- All 85 direct params.FIELD references resolve among the 87 fields returned
  by target_policy_params(), and the prescribed public-contract state returns
  two finite accelerations.
- A 52,488-state grid spanning range, target side, bearing, closing behavior,
  body-frame lateral velocity, joint angle, and sub-band joint rate is exactly
  equal to evaluated v32. An 8,181-probe grid over joint rate and acceleration
  returns finite outputs and is mirror-equivariant to numerical tolerance.
- Fixed-state replay over the completed v32 trace would modify 11.925% of
  anterior and 6.811% of posterior commands, first at 2.6015T and 2.0790T.
  This is deliberately a carrier-envelope test rather than a far-path-dormant
  route edit; only a new CFD rollout can establish its trajectory and wake
  consequences.
- The guidance semantic check, Julia public contract, focused rate probes,
  parameter-schema audit, and solver editable-boundary check pass. The
  configured check runner was invoked, but its pinned model is unsupported on
  this account; its three declared no-CFD commands were run directly and
  separately. No formal CFD was run.
