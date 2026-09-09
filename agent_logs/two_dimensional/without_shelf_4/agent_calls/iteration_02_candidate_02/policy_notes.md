# Multi-wake target-policy diagnosis

## Evidence reviewed before the policy edit

- The common prewarm sheet shows the fish held at the upper-right release pose
  while the four staggered-cylinder streets develop and merge through the
  target corridor.  Every sampled policy starts from this same vortex field,
  so the sheet is initial-condition evidence rather than a controller result.
- The target-blind seed is the best finite score (`-14.2942`) and the only
  sample with upstream world displacement.  Its released sheet shows a strong
  body wave followed by a nearly vertical descent outside the useful wake
  corridor.  It exits the lower boundary at `50.1269`, after moving
  `(-3.545, -13.300)L`; a transient `8.615L` minimum distance rebounds to
  `12.123L`, leaving progress at only `0.0243`.  Both joint rates and
  accelerations reach the exact `260 deg/time` and `1800 deg/time^2` limits,
  and command-energy mean is `1496.25`.  This is uncontrolled, saturated
  motion rather than target acquisition.
- Three slower, smaller bearing-feedback candidates remove the seed's hard
  limit contact but all exit the downstream/right boundary in about `16`
  released time units without entering the target wake.  The posterior-only
  negative-bias candidates move about `(2.58, -2.1)L`, have negative progress
  near `-0.16`, and have mean velocities close to their sampled local flow:
  the `0.80`-period, `18 deg` candidate has mean relative flow only
  `(0.0311, -0.0230)` despite command-energy mean `224.26`; the
  `0.75`-period, `11 deg` candidate is similarly advected despite mean command
  energy `307.74`.  The opposite-sign common-curvature candidate is even less
  active (command-energy mean `0.69`) and also exits downstream at `16.7474`.
  The released sheets agree: these fish turn or bend but never translate into
  the developed wake corridor.
- The prefilled distributed-steering candidate is not a stronger comparator:
  it becomes numerically unstable after only `1.9207`, reaches the exact
  `45 deg` anterior angle and anterior rate/acceleration caps, and produces
  RMS lateral force `1.19e5` and moment `1.24e6`.  Its state-dependent anterior
  center shift is therefore an unsafe way to restore authority.
- The assigned parent lesson correctly warns against the saturated seed gait,
  but inherited evaluations now falsify its broad suggestion that simply
  lowering nominal gait strength and adding bounded bearing feedback is enough.
  The missing intermediate test is a cap-feasible gait with more authority
  than the three downstream-exit variants, without the prefill's anterior
  steering transient.

## Candidate policy hypothesis

Use the finite `0.80`-period posterior-steering policy as the structural base,
but shorten its energy-regulated oscillator period and raise its convergence
gain while retaining a requested phase-space radius below the episode limits.
Clamp both policy accelerations below the environment cap.  Keep mean steering
out of the anterior oscillator and apply a bounded negative tail-tangent bias
from body-frame bearing only; clamp and lead the windowed bearing rate so the
bias begins unwinding before the fish overshoots into the steep descent seen in
the keyframes.  This uses target-relative history and joint state, not a clock,
global coordinates, a route, prescribed inflow, remote probes, or target-flow
fields.

The falsifiable expectation is survival past the approximately `16`-unit
downstream exits with negative x displacement beginning before boundary loss,
while avoiding the seed's joint-rate/acceleration caps and the prefill's load
spike.  The candidate should also improve progress over `-0.15` without
reproducing the seed's `13.30L` lateral ejection.  If it still exits downstream
near `16`, fixed gait authority rather than steering sign is insufficient and
later work should test a calibrated local-flow/closing-speed modulation.  If
it turns more steeply away while producing upstream displacement, weaken or
reverse only the posterior bearing path before changing propulsion again.

## Controller-only sanity check after the edit

A deterministic `300`-unit joint integration (no fluid simulation) was run
for aligned, constant `0.15 rad` bearing, and smooth `0.15 rad` bearing-sweep
inputs.  Across the probes, maximum joint magnitudes were approximately
`17.0/13.5 deg`, rates `157.1/85.6 deg/time`, and accelerations
`1450.5/762.4 deg/time^2`; neither policy acceleration used its internal clamp.
This only verifies nominal envelope headroom and finite feedback.  It does not
claim wake traversal or validate the CFD hypothesis, which is evaluated after
this worker exits.
