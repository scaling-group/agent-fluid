# Multi-wake candidate diagnosis

## Evidence read before the edit

- The assigned parent proposed bounded target-bearing mean curvature around an
  amplitude-regulated traveling bend. Its completed rollout is the strongest
  finite sample: it changes the seed's `left_domain` termination at `50.13` to
  a full `300`-unit horizon and reduces RMS yaw moment from `541.70` to
  `270.96`. This is a real stability improvement, but not a useful approach:
  the released keyframes show a compact looping trajectory on the far-right
  side, head motion is only `(-1.19,-3.78)L`, and closest/final distance remain
  `10.28/10.48L`.
- The common target-blind seed visibly self-propels upstream (`-3.55L`) before
  diving `-13.30L` through the bottom boundary. Its `8.61L` closest approach
  regresses to `12.12L`, while both joint speeds and accelerations reach their
  hard limits. It proves that the posterior-lagged wave can make upstream
  thrust, but not that its high-effort path is useful navigation.
- Two simpler bearing-to-static-curvature candidates do worse. They leave the
  right boundary after only `16.63` and `19.87` units with `+2.18L` and
  `+2.22L` downstream displacement. One barely develops its intended anterior
  wave (`max |phi1| = 0.245 rad`); the other reaches roughly `0.52 rad` and near
  the acceleration cap yet is still advected downstream. Together with the
  finite loop, this falsifies another scalar adjustment of the same static
  mean-bias architecture: placing persistent route error in the oscillator
  center can trade away the alternating wave's useful thrust.
- The common prewarm sheet shows four fully developed interacting streets and
  the fish initially outside the organized target wake. None of the released
  candidates reaches the second-row target neighborhood, so there is not yet
  evidence for exact vortex-phase tracking or terminal approach scheduling.

## Candidate hypothesis

Return the propulsive oscillator to a zero-mean traveling-bend scaffold and
translate body-frame bearing into bounded half-cycle amplitude asymmetry. Joint
state `(phi1, phi_dot1 / omega)` supplies oscillator phase: the half-cycle on
the requested bend side receives a larger amplitude envelope and the opposite
half-cycle a smaller one. The posterior joint continues to track a lagged,
amplified anterior wave, so steering modulates propulsion instead of replacing
it with static curvature. A realizable base gait leaves actuator headroom for
the asymmetric half-cycle.

The rollout should preserve visible alternating propulsion, avoid immediate
right-boundary advection, and turn targetward without the parent's far-right
loop. Falsify the mechanism if it turns in the wrong sign, fails to produce
upstream displacement, retains the same looping or early-exit topology,
suppresses posterior lag, or makes velocity/acceleration saturation persistent.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping and duty-ratio modulation
source_mechanism: sensor-driven half-cycle amplitude asymmetry layered on a continuing propulsive rhythm
transferable_invariant: persistent body-frame direction error can make the requested bend-side half-cycle stronger while a posterior-lagged alternating wave continues to generate thrust
nontransferable_details: published gains, dimensional beat settings, robot linkage geometry, species-specific envelopes, clock-driven phase, exact vortex phase, and source-task routes
policy_translation: normalize current bearing through a smooth bound, infer beat side continuously from anterior joint angle and velocity, modulate the two half-cycle amplitude envelopes, and retain the state-feedback posterior lag
falsification: reject if target-bearing feedback still causes downstream advection, wrong-sign turning, the far-right loop, loss of upstream thrust, persistent actuator clipping, or greater load without distance improvement

## Pre-evaluation contract audit

A joint-only numerical integration of the candidate law (not CFD and not
rollout evidence) under fixed bearings of `-0.5`, `0`, and `+0.5 rad` confirms
that the mechanism reverses continuously: at `+0.5 rad`, joint 1 spans about
`-18.3` to `+23.1 deg`, and the span swaps under negative bearing. The lagged
joint 2 stays within about `-19.6` to `+19.6 deg`. Approximate peak joint speeds
are `182/156 deg/time`, and raw accelerations are `1770/1445 deg/time^2`, below
the formal `260/1800` limits. This checks bounded state-feedback realization
only; hydrodynamic turn sign, thrust, wake interaction, and target progress
remain falsifiable by the later formal rollout.
