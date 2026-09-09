# Multi-wake candidate diagnosis

## Evidence read before the edit

- The assigned parent guidance preserves the common seed's state-feedback
  traveling-bend idea but requires a body-frame navigation mechanism before
  more oscillator gain or frequency. The common prewarm sheet shows the fish
  released above and to the right of four developed, interacting vortex
  streets; every candidate therefore starts outside the useful target-wake
  region under the same developed flow.
- The target-blind seed is actively self-propelled, not merely advected: its
  released sheet shows a vigorous repeated body wave and a steep curved path.
  It nevertheless exits the lower domain at `50.1269`, displacing its head
  `(-3.545,-13.300)L`. It briefly reaches `8.615L` distance but finishes
  `12.123L` away with only `0.0243` progress. Both joint speed and acceleration
  reach the hard caps, while RMS force/moment reach `21.943/541.704`.
- Three first-generation direct bearing-to-static-bend policies fail in a
  common, materially worse topology. The `04f3`, `6b08`, and inherited `6475`
  rollouts all move about `+2.18L` downstream and leave the right domain after
  only `16.63`--`19.87` released time units, with negative progress
  (`-0.148` to `-0.137`) and final distance above `14.13L`. Their keyframes show
  no entry into the organized wake corridor. This repeated result makes another
  direct saturated bearing-to-mean-bend variant a poor evidence-led choice.
- The `a66c` policy is the sole semantic improvement: its slower radial
  state-feedback oscillator, posterior lag, bounded curvature, and
  bearing-rate damping survive the full `300`-unit horizon. It displaces the
  head `(-1.187,-3.785)L`, improves final distance to `10.484L`, and lowers RMS
  moment to `270.955`; its observed maxima (`0.489/0.436 rad` angle,
  `2.533/2.708 rad/time` speed, and `18.665/20.127 rad/time^2` acceleration)
  remain below the hard actuator envelope. However, its released sheet shows
  repeated compact loops in the upper-right rather than sustained translation
  into the wake, and closest distance is still `10.276L`. Thus the radial
  oscillator and lag are worth preserving, while persistent mean curvature is
  not yet a useful route controller.

## Policy hypothesis

Retain the `a66c` actuator-feasible radial oscillator, bearing-rate damping,
and posterior traveling-wave lag. Replace its persistent joint-center offset
with a bounded half-cycle amplitude asymmetry: infer oscillator side from
normalized `(phi1, phi_dot1)`, enlarge the target-side excursion, and shrink
the opposite excursion. The restoring equilibrium remains unshifted, so a
persistent bearing request should redirect the beat without locking the body
into the repeated static-curvature loops visible in `a66c`. Apply a smaller
copy of the same half-cycle asymmetry to the lagged joint-2 target so the two
joint means support the requested turn without a separate steering offset.

This candidate is supported if it preserves full-horizon finite propulsion,
reduces repeated tight looping, produces substantially more upstream
translation than `1.187L`, and improves closest/final distance beyond
`10.276/10.484L`. It is falsified by the three-policy right-boundary exit
topology, recurrence of the seed's lower exit, collapsed oscillation,
persistent cap contact, higher load spikes, or the same upper-right loops with
no useful target-wake entry.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and duty-ratio turning layered on rhythmic propulsion
source_mechanism: target-dependent half-cycle amplitude asymmetry while retaining a posterior-lagged traveling bend
transferable_invariant: strengthen the beat half-cycle on the requested body-frame turn side while preserving the alternating traveling wave and releasing the asymmetry as bearing converges
nontransferable_details: published gains, dimensional beat frequencies, robot linkage geometry, species-specific envelopes, clock-driven phase, exact vortex phase, cylinder layout, and source-task routes
policy_translation: combine bounded body-frame bearing and bearing-rate damping into a turn request, infer beat side from normalized joint angle and velocity, modulate the radial oscillator amplitude symmetrically about zero, and apply a smaller matching half-cycle modulation to the lagged second-joint target
falsification: reject the transfer if it loses the full-horizon stability of a66c, retains tight looping or early domain exit, fails to improve target distance and upstream displacement, collapses thrust, or drives joint and load caps

## Pre-evaluation actuator audit

A joint-only semi-implicit integration of the candidate equations (not CFD and
not new rollout evidence) checked constant bearings of `-0.5`, `0`, and
`+0.5 rad`. At zero bearing, joint 1 remained symmetric at approximately
`+/-20.00 deg`; at positive bearing its extrema became
`-17.98/+20.39 deg`, with the negative-bearing case mirrored. Across the
three checks, joint-2 extrema stayed within about `20.84 deg`, speed within
`155 deg/time`, and raw acceleration within `1139 deg/time^2`, below the
`45/260/1800` envelope. This only establishes a bounded, sign-responsive
half-cycle deformation; hydrodynamic turn direction, thrust, wake entry, and
target progress remain the rollout falsification tests.
