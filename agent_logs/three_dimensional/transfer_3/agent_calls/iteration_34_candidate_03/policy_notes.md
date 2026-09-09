# Complementary actuator-headroom steering candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled solver rollouts and the assigned-parent rollout satisfy the
  frozen experiment contract: direct uniform `U_infinity=(0,0,0)`
  initialization, no prewarm, no cylinders, finite dynamics, and capture.
  Their local-flow RMS remains `0.01807--0.01821U`, so the approach is
  self-propelled rather than environmental advection.
- I inspected every sampled combined sheet and the inherited sheets in both
  views from release through capture. The best-score exact baseline
  (`solver_ed121cf46867`) shows a compact, body-led alternating vorticity street
  top-down and coherent three-dimensional Lambda2 structures shed behind the
  tail obliquely. The slower stress-gated residual has the same useful wake and
  no collision, boundary approach, growing sway, or instability. The
  assigned-parent exact repeat also preserves that topology, so the carrier,
  LOS route, and phase actuator should not be replaced.
- The two current exact-policy samples capture at `18.6725T`, score
  `-0.13219/-0.13362`, with anterior/posterior acceleration-limit occupancy
  `40.71--42.15% / 75.46--76.11%` and force/moment RMS
  `0.01331--0.01350 / 0.00693--0.00703`. The assigned-parent same-hash repeat
  captures at `18.7935T`, score `-0.14258`, while posterior occupancy happens
  to fall to `74.04%`. That replication spread makes a small timing or load
  change insufficient evidence, but consistently identifies posterior
  clipping as the remaining asymmetric actuator constraint.
- The current helpful-moment and stress-gated moment controls capture at
  `18.6560T` and `18.7440T`; neither separates its route, load, or occupancy
  from the exact-policy replication envelope. This agrees with inherited logs
  that instantaneous moment allocation is not a supported response channel.
- I also inspected the newly completed joint-phase recoil-observer branch as
  the informative failure. Both views retain a coherent alternating wake, but
  the top-down route advances substantially less by `4--12T` and requires a
  late stronger correction. It still captures only at `22.0110T`, with score
  `-0.42356` and mean distance `2.31828L`, versus `18.6725--18.7935T` and
  `2.02018--2.03024L` for exact-policy samples. Its lower posterior occupancy
  (`60.62%`) and force/moment RMS (`0.01177/0.00612`) therefore reflect lost
  useful propulsion/route response, not an efficiency improvement. An
  offline fit to a centered beat average is not a safe causal replacement for
  the replicated yaw observer.

## Policy hypothesis recorded before editing

Preserve the evaluated normalized bearing-plus-LOS-rate route, recoil-aware
yaw response, distributed C-bend, autonomous traveling carrier,
response-reversing half-cycle steering, persistent same-side phase gate,
coefficient-norm-preserving posterior phase rotation, and physical command
projection. Add one bounded allocation mechanism after phase modulation:
isolate only the half-cycle steering contribution to the posterior target;
when that contribution is sign-coherent with persistent posterior stress and
both predicted and previously realized anterior commands show headroom, move a
bounded share of its acceleration from joint 2 to joint 1. Equal removal and
addition conserves pre-limit joint-sum steering acceleration, while the base
posterior wave, mean curvature, and phase actuator remain unchanged.

This is not wholesale curvature transfer: it is inactive without posterior
stress, helpful steering-stress alignment, and persistent anterior headroom.
The expected useful effect is to retain capture and the coherent wake while
reducing posterior limit occupancy below the replicated `74.04--76.11%` band
without reproducing the phase-observer branch's slower trajectory. Support
requires capture inside the inherited `18.6560--19.0080T` useful band, mean
distance no greater than `2.03024L`, both wake views remaining coherent, and a
posterior-occupancy reduction that does not push anterior occupancy above the
sampled `42.15%` ceiling or force/moment RMS above `0.01350/0.00703`. Falsify
the allocator if it loses capture, delays the route, transfers clipping to the
anterior joint, weakens the traveling wake, or leaves posterior occupancy
inside replication spread; later workers should then preserve the exact
actuator-consistent baseline and avoid further instantaneous residual
allocation until genuine beat-history state is available.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and residual path-following control
source_mechanism: preserve a productive traveling rhythm while distributing a bounded asymmetric steering residual across redundant joints according to observed actuator availability
transferable_invariant: keep the posterior-lag carrier primary and reallocate only a sign-coherent steering residual when one actuator is constrained and another has persistent headroom, conserving the net steering contribution before physical limits
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, full-body waveforms, exact vortex phases, learned routes, and source-specific actuator leverage
policy_translation: retain normalized body-frame LOS C-bend and observed two-joint phase recruitment; shift only the stress-aligned half-cycle acceleration residual from posterior to anterior using current predicted demand and previous feasible action
falsification: reject if capture leaves 18.6560--19.0080T, mean distance exceeds 2.03024L, either wake loses coherence, posterior occupancy does not fall below replication spread, anterior occupancy exceeds 42.15%, or force/moment RMS exceeds 0.01350/0.00703

The candidate's own CFD result is unavailable in this worker and is not used
as evidence; it becomes evidence only after this worker exits.
