# Multi-wake candidate diagnosis

## Evidence read before the edit

- The four sampled solver results and the additional inherited optimizer
  rollout all share the same held-fish prewarm sheet (identical SHA-256). It
  shows the fish held at the upper-right release pose while four developed
  vortex streets extend downstream across the target corridor. This anchors
  the initial condition but does not distinguish policies.
- The target-blind `0.55`-period, `28 deg` seed is still the strongest finite
  trajectory: its released sheet shows genuine upstream propulsion, and its
  head moves `-3.545L` in x. It then turns nearly vertical, moves `-13.300L` in
  y, and exits the lower boundary at `50.1269`; its transient `8.61495L`
  closest approach rebounds to `12.1226L`. Both joints hit the exact
  `260 deg/time` and `1800 deg/time^2` caps, with mean command energy `1496.25`,
  RMS lateral force `21.94`, and RMS moment `541.70`. The visible displacement
  is therefore useful propulsion coupled to uncontrolled, cap-limited lateral
  motion, not target navigation or productive wake entry.
- Every reduced-drive finite candidate instead leaves through the downstream
  side after about `16.1-16.75` units without improving on the initial
  `12.4239L` distance. The `18 deg`, `0.80` energy-regulated oscillator moves
  the head `+2.575L` in x; the inherited `11 deg`, `0.75` tail-only steering
  candidate moves it `+2.590L`; and the assigned-parent `14 deg`, `0.80`
  common-curvature candidate moves it `+2.172L`. Their sheets show advection
  along the upper-right margin rather than entry into the wake corridor.
- The assigned parent also exposes a structural startup failure. At the
  initial positive bearing its bounded steering bias is approximately `+8
  deg`, exactly the configured initial `q1=+8 deg`; with `q1_centered=0` and
  `qd1=0`, its centered Van der Pol oscillator has no phase energy. Evaluation
  agrees: both joint angles peak at exactly `8 deg`, mean command energy is
  only `0.6915`, and inflow carries the head downstream. Steering must not
  redefine the anterior oscillator origin so that a valid initial joint state
  becomes an equilibrium.
- The remaining sampled policy shares an `18 deg` steering command with the
  anterior joint. Its released sheet curls immediately and it terminates as
  `unstable_dynamics` after `1.9207`, with `q1` at the `45 deg` angle limit,
  RMS relative crossflow `3.70`, RMS force `1.19e5`, and RMS moment `1.24e6`.
  This co-occurrence does not isolate steering sign, but it rules out another
  large anterior steering-center change as the next evidence-based test.

## Policy hypothesis

Keep propulsion phase independent of steering and regulate its phase-space
radius explicitly. An `18 deg`, `0.65`-period anterior oscillator is faster
than all three downstream-advection candidates while its nominal boundary
rate and acceleration are about `174 deg/time` and `1682 deg/time^2`, inside
the episode caps. A bounded `30 rad/time^2` policy clamp guards transient tail
coupling without asking the episode hard limit to define the nominal gait.
In a joint-only `0.0055`-step integration over the full `300`-unit horizon,
constant bearings from `-0.15` to `0.35 rad` kept the largest angle, rate, and
acceleration at `20.48 deg`, `174.07 deg/time`, and `1680.69 deg/time^2`, with
zero policy-clamp contacts. This is an envelope check, not CFD or navigation
evidence.

Apply target feedback only to the posterior traveling-wave target: positive
body-frame bearing receives a smooth negative bias, following the inherited
frame-sign hypothesis, limited to `8 deg`. A clipped bearing-window rate supplies a
short lead without using coordinates, elapsed time, target identity,
prescribed inflow, or remote wake probes. Moderate posterior lag and damping
sit between the weak finite variants and the saturated seed.

The falsifiable expectation is survival beyond `16.75` with active joint
oscillation, negative rather than positive x displacement, and no hard
angle/rate/acceleration contact, while bearing feedback prevents the seed's
large downward-to-upstream displacement ratio. If the run is still swept
downstream, this cap-feasible frequency is below the thrust threshold and
later work should adjust propulsion separately. If bearing or lateral offset
grows while upstream motion returns, weaken or reverse the posterior bias
before adding wake sensing. Repeated contact with the internal clamp falsifies
the claimed nominally unsaturated regime.
