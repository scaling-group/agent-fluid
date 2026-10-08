# Wake-policy candidate notes

## Evidence diagnosis

- The shared prewarm sheet shows the held fish above and downstream of four
  fully developed, interacting vortex streets. It is common initial-condition
  evidence rather than a controller difference.
- All four sampled released sheets reach the `0.75L` target and contain no
  visual failure. They show a sharp clockwise redirect followed by a coherent,
  self-propelled upstream traverse into the merged second-row wake. The best
  finite baseline reaches in `36.471`, moves the head
  `(-10.914,-4.216)L`, and sheds a strong posterior wake; the negative
  boundary must therefore come from inherited failures and finite metric
  contrasts rather than a sampled failure sheet.
- The half-cycle baseline materially shortened the earlier route, but it also
  raised RMS force/moment from `49.36/799.31` to `63.59/953.42` and touches
  both the `30.0` acceleration envelope and `4.5379` joint-speed limit. Its
  independent phase gate is applied to both the anterior steering joint and
  the posterior joint that supplies the lagged traveling bend.
- The sampled near-target scheduler attenuates half-cycle asymmetry inside
  `2.25L`, yet is physically indistinguishable from the unscheduled baseline:
  arrival `36.454` versus `36.471`, mean distance `1.68617L` versus
  `1.68603L`, mean command energy `1335.35` versus `1335.33`, and RMS
  force/moment `63.25/950.58` versus `63.59/953.42`. Because first-crossing
  capture ends the episode at `0.75L`, that late intervention is too brief to
  establish material load relief.
- Inherited logs supply the failure boundary: low-effort replacements that
  disrupt the validated traveling-bend carrier either exit with negative
  progress or become unstable. The carrier, steering sign, raw-bearing reserve
  ownership, and acceleration envelope therefore remain unchanged.

## Policy hypothesis

Use an anterior-steering/posterior-propulsion division of labor. Retain the
joint-state half-cycle gate on joint 1, where it can preserve the evidenced
fast redirect, but give joint 2 the same bounded mean steering residual without
an independent half-cycle multiplier. The posterior oscillator target, lag,
mean steering ratio, allocator, and envelope stay intact. This is a structural
actuator allocation test, not scalar gain tuning: it asks whether the route
benefit comes primarily from anterior phase-gated curvature while posterior
phase gating is an avoidable source of tail loading and saturation.

Expected test: retain target capture and a compact self-propelled upstream
trajectory while reducing RMS moment, lateral force, joint-2 excursions, or
mean command effort relative to `63.59/953.42` and `1335.3`. Reject the
mechanism if capture is lost, arrival regresses beyond the pre-half-cycle
`45.727` baseline, the coherent posterior wake disappears, or load/effort does
not improve enough to compensate for slower arrival. The candidate receives
CFD evaluation only after this worker exits; no same-worker result is claimed.

bookshelf_consulted: true
source_domain: elongated-body swimming and closed-loop robotic-fish turning
source_mechanism: anterior joints sustain target-directed curvature while posterior lag and wave amplitude retain the primary propulsive role
transferable_invariant: preserve a directional traveling bend while confining strong phase-gated steering to the anterior actuator so the posterior actuator can maintain lagged thrust
nontransferable_details: published gains, dimensional beat rates, species envelopes, full-body joint distributions, robot geometry, exact vortex phase, and task-specific routes
policy_translation: keep normalized body-frame bearing and course response in the bounded two-joint mean residual, but apply the joint-state half-cycle multiplier only to joint 1 while joint 2 retains its lagged carrier and bounded mean steering share
falsification: reject if target capture or coherent upstream propulsion is lost, arrival exceeds 45.727, or force, moment, effort, and posterior limit contact show no compensating improvement over the dual-gated half-cycle baseline

## Scope boundary

The evidence uses one deterministic held-fish prewarm. Even a successful new
rollout would not establish robustness to a changed wake phase, inflow, or
layout; loss of capture on any such held-out case falsifies that claim.
