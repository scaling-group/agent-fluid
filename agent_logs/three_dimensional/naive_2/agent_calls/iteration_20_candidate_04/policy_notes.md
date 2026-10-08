# One-update speed-viability candidate

## Visual and metric diagnosis before the edit

- All four assigned solver examples are exact repeats: candidate, trajectory,
  top-down sheet, and oblique sheet have matching hashes. Each satisfies the
  direct-uniform still-water contract (`U_infinity=[0,0,0]`, no cylinders,
  no prewarm), captures at `0.745621L` and `16.609995T`, and scores
  `-0.115560`. Thus the four samples establish fixed-case repeatability, not
  four independent mechanisms or held-out robustness. There is no sampled
  semantic failure to invent; the informative controlled comparator is the
  inherited pre-guard captured carrier.
- I inspected both rows of the combined sheet for the repeated projected
  capture and the inherited pre-guard capture. In both, the fish visibly
  self-propels along a curved targetward arc. The top-down row develops a
  coherent alternating red/blue street that remains connected to the tail,
  while the oblique row retains compact, alternating three-dimensional
  Lambda2 structures through target crossing. The nearly unchanged visible
  wake class agrees with the matched controller comparison: speed-constraint
  handling did not replace the useful traveling-wave carrier.
- Relative to the inherited captured carrier, the sampled smooth `0.99--1.00`
  speed guard is a completed positive result. It arrives about `0.022T`
  sooner (`16.6100T` versus `16.6320T`), improves distance integral
  (`1.999656L` versus `2.001992L`), reduces joint excursions from about
  `0.548/0.556` to `0.541/0.549 rad`, and lowers peak planar force/moment
  from about `0.03678/0.01827` to `0.03583/0.01776`.
- The completed guard does not eliminate hard speed contact. The repeated
  trace still places joint 1 and joint 2 exactly at `260 deg/T` during about
  `8.81%` and `14.17%` of logged steps, while residence in the final one
  percent of the envelope is about `11.59%/15.83%`. The guard scales outward
  acceleration from speed alone, so a large bounded command can still cross
  the remaining speed margin in one `0.0055T` update and be clipped by the
  released integrator. This is the remaining evidence-backed constraint
  mismatch; it is not evidence for shedding carrier energy.
- Inherited failures bound the edit tightly. Whole-wave relief, startup
  recruitment, added terminal anterior curvature, and posterior mean bursts
  damaged approach, speed, joint clearance, or loads. The captured route,
  mean-preserving yaw demodulation, phase-selective steering, acceleration
  limiter, and inward beat reversals should therefore remain unchanged.

## Single policy hypothesis

Replace only the speed-only guard with a one-update viability projection. Use
the parameter-owned maximum update horizon and a `0.99` normalized soft speed
boundary to compute how much outward acceleration fits in the remaining
velocity margin. Pass the smaller of that feasible amount and the existing
bounded outward request, while passing every inward or reversal request
unchanged. This is joint-state feedback and contains no clock phase, elapsed
time, target identity, coordinate route, or mutable memory.

Unlike widening a scalar guard band, the intervention depends jointly on
measured speed headroom and current acceleration demand. It should prevent the
controller from asking the integrator to cross the soft speed boundary during
the largest permitted update while preserving the already captured carrier.
Falsify it if capture, target arc, reversal timing, or the connected wake
changes materially; if distance integral, arrival, joint excursion, force, or
moment worsens; or if exact hard-limit residence is not reduced. The update
horizon is actuator-contract-specific and must be revised or removed if a
held-out runtime uses a larger policy integration step.

bookshelf_consulted: true
source_domain: classical reactive fish propulsion and sensor-modulated low-dimensional robotic-fish CPG control
source_mechanism: preserve a phase-lagged propulsive carrier while applying a distinct bounded feedback correction compatible with actuation constraints
transferable_invariant: keep the directed traveling bend and its inward reversals intact while restricting only a command component that cannot remain inside the measured joint-speed envelope
nontransferable_details: published gains, species or robot kinematics, dimensional beat frequencies, waveform envelopes, exact vortex phases, maneuver timing, and task-specific routes
policy_translation: retain the normalized body-frame route and two-joint carrier, then cap only same-direction acceleration by the joint-speed headroom available over one parameter-owned maximum update horizon
falsification: reject if capture or the connected three-dimensional wake fails to repeat, target approach or reversal timing changes materially, loads or joint excursions rise, or hard-speed contact is not reduced

## Evaluation boundary

No CFD result is claimed for this child. Its evaluation should compare
semantic capture first, then arrival and distance integral, exact
target-relative arc, joint-speed residence at `0.99` and `1.00` of the hard
limit, requested versus clipped acceleration, reversal timing, joint
excursions, peak force/moment, and both visual wake rows against the four exact
sampled projected captures. A different actuator update horizon lies outside
the current fixed-case evidence.

As a post-edit algebraic preflight on the inherited unprojected capture trace,
the viability map changes `10.81%/15.54%` of joint-1/joint-2 samples, preserves
all `1425/1352` inward samples exactly, and lowers trace-evaluated mean absolute
requests from `22.77/25.43` to `21.34/22.15 rad/T^2`. This verifies scale,
polarity, and selective application only; it is not a counterfactual fluid or
trajectory result.
