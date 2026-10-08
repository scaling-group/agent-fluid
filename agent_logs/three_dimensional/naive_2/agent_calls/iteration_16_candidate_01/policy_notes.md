# Mean-preserving joint-phase demodulation candidate

## Visual and metric diagnosis before the edit

- All four sampled solver examples report direct-uniform still-water
  initialization with `U_infinity=[0,0,0]`, no cylinders, and no prewarm.
  They contain the same evaluated policy and reproduce the same nominal
  capture: `0.7477L` at `16.637T`, score `-0.11967`, and 237 moving-window
  shifts. I inspected the combined sheet for `solver_28465671dc6c`. Its
  top-down row shows sustained self-propelled targetward motion and an
  alternating vortex street through capture; its oblique row retains
  tail-connected three-dimensional Lambda2 structures. This is a useful
  propulsive and route-response carrier, not a policy to replace wholesale.
- I also inspected both rows of the inherited posterior-burst failure
  `solver_1e883e41dfee`. It keeps a finite alternating top-down wake and
  connected oblique structures but passes above the target, curls upward, and
  leaves the domain at `25.05T` after a `3.254L` minimum. The trajectory and
  inherited notes additionally show joint-2 hard-limit contact and peak
  planar force/moment near `0.0450/0.0206`. Coherent wake appearance therefore
  does not rescue added terminal mean curvature; the differentiating issue is
  route-response semantics.
- The sampled capture is physically bounded but still actuator-intensive:
  maximum joint magnitudes are about `0.550/0.560 rad`, peak planar
  force/moment are `0.0369/0.0186`, at least one acceleration is within 5% of
  its limit for about `74.0%` of logged steps, and at least one joint speed is
  within 1% of its limit for about `27.5%`. Those figures argue against adding
  another steering burst or strengthening the carrier merely to improve the
  scalar score.
- The inherited raw-yaw regressions attributed `93.3--99.7%` of short-window
  yaw variance inside `6L` to anterior joint phase. Removing that component
  changed the prior `2.169L` upper-exit topology into the replicated nominal
  capture. However, the evaluated implementation reconstructs carrier yaw
  from raw `q1` even after defining `q1_carrier = q1 - head_course_center`.
  During approach, raw `q1` therefore mixes the bounded slow anterior course
  center with the fast oscillator, so the demodulator can subtract part of the
  directional response it is supposed to measure.

## Single policy hypothesis

Preserve every evaluated propulsion, route, phase-selective relief, and
actuator parameter. Make one semantic change: reconstruct carrier-correlated
yaw from `q1_carrier` rather than raw `q1`, retaining `q1_dot` as the observed
phase-rate cue. This makes the phase remover mean-preserving: a slow bounded
course center remains in directional yaw while only the oscillatory anterior
coordinate is subtracted.

The edit is reflection-equivariant, body-frame, clock-free, and does not add
curvature, whole-wave attenuation, or gain tuning. Expected behavior is to
retain the target-crossing arc and organized 3D wake while preventing the yaw
tracker from cancelling its own approach steering, especially if target pose
or course demand changes. Falsify it if capture is lost, arrival or distance
integral worsens materially, the same targetward arc is not retained, the
demodulated residual remains carrier-correlated, or joint contact, near-limit
action residence, force, moment, or wake organization worsens.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and fish turning by phase-compatible asymmetry
source_mechanism: preserve a rhythmic propulsive carrier while directional feedback modulates a distinct slow or phase-selective steering channel
transferable_invariant: estimate fast carrier-correlated response from a mean-removed oscillator coordinate so slow body-frame route response remains available to feedback
nontransferable_details: published gains, robot and species geometry, dimensional beat timing, exact vortex phase, prescribed maneuver duration, and task-specific routes
policy_translation: use the existing bounded anterior course center to form `q1_carrier`, subtract the yaw reconstructed from that oscillatory coordinate and joint velocity, and retain the resulting residual in the established posterior response tracker
falsification: reject if nominal capture does not repeat, carrier correlation persists, the targetward trajectory or connected wake degrades, or loads, saturation, or joint-limit contact worsen materially

## Evaluation boundary

No CFD outcome is claimed for this child. The later evaluation should compare
capture and arrival first, then distance integral, target-relative trajectory,
raw-versus-compensated yaw phase correlation, acceleration and speed-limit
residence, joint contact, peak force/moment, and both wake views against the
completed `solver_28465671dc6c` carrier.
