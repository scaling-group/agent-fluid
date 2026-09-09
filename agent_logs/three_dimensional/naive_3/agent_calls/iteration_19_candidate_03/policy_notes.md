# Candidate diagnosis and hypothesis

## Evidence read before editing

- The assigned parent is the joint-phase-selected terminal posterior
  counterbend. It remains finite and self-propelled, but misses at `2.512L`
  and powers through the lower boundary at `31.471T`; its combined top-down
  and oblique sheet shows the same coherent alternating wake and diagonal
  release as the sampled variants.
- All four sampled evaluations are valid direct-uniform still-water rollouts:
  `U_infinity=[0,0,0]`, no prewarm, no cylinders, and no instability. They all
  retain a long coherent 3D wake, approach laterally, then turn down and exit
  at `y` about `0.8L` after `31.2--31.6T`.
- The yaw-selected posterior half-cycle brake is the strongest sampled closest
  approach (`2.385L`, mean `8.436L`). The course-selected anterior duty
  asymmetry slightly improves mean distance to `8.434L` but worsens closest
  approach to `2.433L` and preserves the lower exit. The response-gated
  posterior S-bend (`2.536L`) and parent counterbend (`2.512L`) are weaker.
- At the brake minimum, speed remains about `0.705U`, the target is strongly
  lateral in the body frame, and raw yaw is in a fast gait half-cycle. The
  assigned guidance reports that target-ray/course error persists inside
  `3L` near `1.53 rad`, while several equilibrium reallocations and a new
  anterior duty action have failed to change the termination class. The
  workspace contains no inherited `logs/optimize` artifact; its completed
  negative results are already distilled in the assigned parent guidance.

## Visual diagnosis

The fish is self-propelled rather than advected: still-water displacement and
the alternating top-down street agree, and the oblique Lambda2 row shows
compact paired structures shed throughout the rollout. The wake remains
coherent through closest approach, so lost propulsion or numerical breakup is
not the primary failure. The trajectory passes above/alongside the target with
finite speed, then rotates onto a steep downward course; the lower-domain exit
is therefore a persistent course-control failure. The near-identical wake and
path topology across the brake, duty, counterbend, and response-gated S-bend
show that another scalar gate adjustment is unlikely to create capture.

## Policy hypothesis

Use the sampled yaw-selected brake as the baseline, and add one new rhythmic
mechanism: near the target, let the slow body-frame target-ray/course error
select a bounded modulation of posterior phase lag. Joint-1 velocity supplies
beat phase. Increasing lag on one velocity half-cycle and decreasing it on the
other creates a transient opposite-sign posterior S-bend while the course
mismatch persists, but adds no static posterior equilibrium. Distance and
speed gates make the modulation vanish during cruise and at undefined
zero-speed course. The normalized selector and the joint-phase product are
reflection equivariant.

Expected evidence: preserve the long coherent cruise wake and far-field
progress, then bend the translational course back toward the target inside
about `3.6L`, improving on `2.385L` or producing capture/recovery/a useful new
termination class without increasing clamp residence. Falsify the mechanism
if it produces the same powered lower exit with no material closest-approach
gain, a short-wake curl, degraded mean distance, or more actuator/load
residence.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and classical traveling-wave swimming
source_mechanism: sensor-selected phase-lag or wave-shape modulation of a posterior traveling bend
transferable_invariant: steer a propulsive rhythm by bounded state-dependent posterior phase modulation while preserving wave direction and posterior emphasis
nontransferable_details: published gains, dimensional beat frequencies, species envelopes, full-body waveforms, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame target-ray/course error and measured joint velocity to modulate only the two-joint posterior lag near approach
falsification: reject if cruise wake or progress degrades, clamp/load residence rises, a tight curl appears, or the minimum and lower-exit class remain materially unchanged

## Controller-only activation audit

Replaying the selector algebra on the sampled brake trajectory (without CFD or
state integration) gives median course error `1.534 rad` and median modulation
weight `0.507` inside `3L`. With the final bounded lag shift, the recorded
states would span posterior lag gains of about `0.582--1.032` and at most a
`5.28 deg` dynamic posterior-target displacement; at the rollout minimum the
counterfactual displacement is about `-4.60 deg`. The initial-distance phase
weight is below `4e-7`, so the sampled cruise scaffold is unchanged to
numerical relevance at release. This audit checks activation and scale only;
it is not evidence of a new hydrodynamic trajectory or improved score.
