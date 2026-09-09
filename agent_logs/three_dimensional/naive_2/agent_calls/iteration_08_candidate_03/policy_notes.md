# Candidate wake-policy notes

## Evidence and visual diagnosis before editing

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. In both rows of each
  combined sheet, the fish creates a body-connected alternating vorticity
  street and coherent oblique Lambda2 structures before the route fails. The
  motion is self-propelled and stable; the common defect is directional and
  terminal control rather than advection or loss of the propulsive wake.
- The highest scalar sample, `solver_ec81137f627b`, follows the straightest
  leftward route and has the lowest mean distance (`6.304L`), but its
  joint-angle phase subtraction leaves the fish high of the target. It reaches
  only `4.650L`, pins the posterior joint for `5.081T` beyond `40 deg`, and
  exits left at `20.034T`. Its better `-7.405` score is therefore not a useful
  terminal-control improvement.
- The assigned parent `solver_815b9ef451f0` visibly forms a tighter approach
  arc and reaches `2.664L`, but its mean-bend release leaves the posterior
  joint beyond `40 deg` for `6.352T` and the route curls away before a left
  exit at `26.287T`. Its peak planar force and yaw moment are `0.488` and
  `0.220` in the logged normalizations.
- The prefilled posterior-bend release `solver_6acb145d7f64` is a concrete
  negative result. Tail dwell beyond `40 deg` falls to `0.929T` and
  simultaneous two-joint dwell to `0.016T`, but closest approach regresses to
  `3.312L`, exit arrives earlier at `23.027T`, and peak planar force/moment rise
  to `0.890/0.414`. Releasing from instantaneous tail bend therefore improves
  an actuator-occupancy proxy without improving the route or loads.
- The inherited half-cycle formulation explains why state-triggered release
  has been repeatedly recruited: near a misaligned target it reduces the
  symmetric carrier to `0.35` while permitting posterior directional
  asymmetry up to `0.65`. On the opposed half-cycle, the signed steering term
  can exceed the carrier term and remove restoring acceleration altogether.
  Mean- or tail-angle thresholds react only after this one-sided action has
  accumulated and also switch within the propulsive oscillation.

## Single candidate hypothesis

Retain the evidenced full-circle body-frame pursuit, phase-compensated yaw
response, wrong-side-slip redirect, distance/misalignment approach relief,
and traveling-bend carrier. Replace the posterior joint-angle burst gate with
one structural reverse-half-cycle reserve: cap the magnitude of shared
directional asymmetry by the current carrier scale and the largest joint share.
This guarantees that, before the final smooth acceleration envelope, the
opposed half-cycle retains a fixed fraction of its carrier acceleration on
both joints. The cap is inactive during ordinary cruise and introduces no
joint-threshold switching, time, route, or world-frame cue.

The mechanism is supported if it retains at least the parent's `2.664L`
approach while reducing posterior-limit dwell and producing a return arc or a
better termination class; beating the inherited `2.319L` near miss or capture
is stronger support. It is falsified by another left-boundary curl, approach
worse than `2.664L`, loss of the coherent cruise wake, posterior pinning, or
force/moment peaks above the parent's `0.488/0.220` without a semantic route
improvement.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and biological target-directed turning on an undulatory carrier
source_mechanism: turn by strengthening the useful half-cycle without replacing the bidirectional propulsive rhythm with static curvature
transferable_invariant: bounded directional modulation must preserve an opposed restoring half-cycle so the traveling bend remains reversible during a turn
nontransferable_details: published duty ratios and gains, robot linkage geometry, species kinematics, dimensional frequency, exact vortex phase, and any task-specific route
policy_translation: in the two-joint state-feedback law, cap target-signed asymmetry by normalized live carrier scale and joint steering share so each joint retains a parameter-owned reverse-half-cycle fraction
falsification: reject if closest approach exceeds 2.664L, the left-exit topology remains, posterior dwell or load peaks do not improve, or the far-field alternating wake loses coherence

## Dry validation only

A `58,320`-state grid spanning joint angles/rates, fore/aft and lateral target
geometry, distance, slip, and yaw response produced finite commands strictly
inside the smooth `30 rad/T^2` envelope and exact left/right reflection
(maximum error `0.0`). The carrier-relative algebraic check confirms a minimum
opposed-half-cycle fraction of `0.25` on both joints; at cruise scale the cap
lies above the maximum requested redirect and is inactive. The configured
contract, schema, guidance-materiality, and editable-boundary checks are run
separately. No CFD was run; the later formal evaluation must decide every
physical falsifier above.
