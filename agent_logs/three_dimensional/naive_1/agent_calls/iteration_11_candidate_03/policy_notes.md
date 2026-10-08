# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=[0,0,0]`, no prewarm snapshot, no cylinders, and no numerical
  instability. Their top-down sheets show alternating red/blue caudal wakes,
  while the oblique sheets retain discrete three-dimensional Lambda2
  structures throughout their useful motion. The fish are self-propelled; the
  three failures are planar route-control failures rather than absent thrust.
- The assigned prefill (`solver_c039fddba4d9`) develops a coherent wake but
  follows the inherited lower-going path. It reaches only `4.233L` at
  `19.25T`, already with `1.405 rad` full head-relative error, then exits the
  lower virtual boundary at `31.87T` and `9.176L`. The one-sided anterior
  envelope and same-sign posterior C-bend preserve nearly the same visual
  topology and improve the minimum only to `3.712L` and `3.692L`; neither
  converts the carrier into adequate target-side yaw.
- The inherited assigned-parent notes proposed the distinct reactive-load
  test now represented by `solver_1a1f00e33399`: retain the full-angle
  half-cycle controller, but recruit a posterior mean deflection opposite the
  failed same-sign C-bend using normalized proximity and target error. Its
  top-down path no longer continues through the common lower miss: it bends
  around the target and crosses the `0.75L` capture circle at `24.338T`. The
  oblique row still shows a three-dimensional trailing structure at capture,
  so success is not an inertial coast.
- The capture improves minimum/final distance from the sampled failure range
  of `3.692--4.233L` / `9.176--9.239L` to `0.749625L`, and mean distance to
  `2.224L`. Its approximately `13.0/6.6%` anterior/posterior rate-cap
  occupancy and `0.0317/0.0164` peak normalized force/moment remain comparable
  to the failures. This supports the scheduled opposite-sign posterior load
  as useful yaw authority without sacrificing the carrier or load envelope.
  It does not establish robust terminal stabilization: capture is only about
  `0.000375L` inside the threshold, with full target error about `1.324 rad`
  and beat-scale heading rate about `-1.23 rad/T` at termination.

## One candidate hypothesis

Promote the evaluated capture policy intact as the single candidate. This is
an evidence-backed semantic replacement of the prefilled bearing-relief
failure, not scalar tuning: joint-state phase preserves the autonomous
traveling carrier; full normalized body-frame target angle and distance
recruit the posterior reactive load early enough to change the route; and the
load sign follows the measured yaw response rather than geometric C-bend
appearance. Altering gains after a threshold-grazing success would confound
the first reproducibility test and is not supported by another capture.

The candidate is falsified if the same released configuration does not
reproduce capture near `24.34T`, if the coherent top-down and oblique wake is
lost, or if joint saturation and force/moment loads materially exceed the
sampled envelope. Generalization beyond this still-water pose remains open;
later workers should vary normalized geometry or hydrodynamic conditions only
after replication, and should add terminal yaw/slip damping only if repeated
captures show that the narrow crossing is fragile.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive loading and closed-loop robotic-fish mean-offset steering
source_mechanism: a traveling posterior beat preserves propulsion while an observation-gated mean tail load redirects lateral impulse and releases on alignment
transferable_invariant: preserve the rhythmic traveling carrier and choose steering-load sign and recruitment from measured yaw and target response rather than geometric bend appearance
nontransferable_details: elongated-body coefficients, published robot gains, linkage geometry, species-specific envelopes, dimensional frequencies, prescribed maneuver duration, exact vortex phase, and task-specific routes
policy_translation: normalized distance and full head-relative target angle smoothly gate an opposite-sign posterior mean offset while observed joint state continues the inherited phase-lagged carrier
falsification: reject if capture near 24.34T is not reproduced or wake coherence, joint saturation, force, or moment envelopes degrade materially
