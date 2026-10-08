# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled rollouts report `capture`, direct uniform initialization,
  and `U_infinity=[0,0,0]`; therefore no sampled hydrodynamic failure is
  available.  The informative comparison is the single best finite v38 run
  (`solver_641b8157ca11`) against the three behaviorally identical v34-family
  captures, including the assigned parent behavior (`solver_803afe4381ba`,
  `solver_01890b40df58`, and `solver_e861453f0af8`).
- The complete v34 combined sheet shows self-propulsion from rest, a coherent
  alternating top-down vortex street, discrete three-dimensional Lambda2
  structures shed behind the posterior body, and a smooth target-directed arc
  into capture.  The v38 top-down row retains that productive wake and arc.
  Its oblique row is entirely black despite six declared hero frames, so it is
  missing visual evidence rather than proof that the 3D wake improved.
- Relative to the reproduced v34 trajectory, v38 is closer by
  `0.0240/0.1060/0.1435/0.1415 L` at `4/8/12/16 T` and captures at
  `18.2325 T` rather than `18.4030 T`.  Mean/max speed changes only from
  `0.6963/0.9476` to `0.7034/0.9519 L/T`; peak normalized force/moment remains
  `0.03068/0.01579` versus `0.03068/0.01587`, while any-joint acceleration-limit
  residence falls from `42.15%` to `41.55%`.  The route-wide distance lead,
  nearly unchanged load envelope, and lower clipping make this more than a
  terminal-sample artifact.

## One candidate

Promote the sampled v38 policy unchanged from the assigned v34 parent.  Keep
the posterior-lag oscillator, target feedback, completion-gated redirect,
whole-wave pose rejection, divergence recovery, and actuator allocation.  Add
only v38's phase-odd, band-pass local-crossflow confidence term to the
proportional target-pose projection.  This is a controller-mechanism transfer,
not scalar gain tuning: joint state determines the sign, moderate observed
crossflow supplies confidence, and both vanishing and large disturbance-like
crossflow make the correction yield.  The carrier, redirect selection, route
rates, and actuator projection remain untouched.

Expected result: reproduce the earlier middle/late closure and capture while
retaining the v34 speed/action/load envelope and the coherent top-down and 3D
wake.  Falsify the candidate if the distance lead is absent by `8-16 T`,
capture regresses, acceleration residence or force/moment materially exceed
the sampled envelope, or a valid oblique sheet shows loss of the alternating
three-dimensional wake.  Because the only v38 oblique sheet is invalid, a
reproduction is scientifically useful even if arrival does not improve again.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and adaptive wake interaction
source_mechanism: retain the rhythmic carrier while a bounded sensor-feedback residual modulates direction tracking instead of replacing the gait
transferable_invariant: separate the productive oscillator from a small state-dependent flow correction, and reduce sensory authority when the observation is not informative
nontransferable_details: published oscillator gains, robot or species kinematics, exact vortex phases, organized-wake routes, and dimensional flow thresholds
policy_translation: use normalized body-frame local crossflow magnitude as a band-pass confidence and observed joint phase as the odd sign for a bounded correction to proportional target pose only
falsification: reject if route closure or capture fails to reproduce, if the carrier wake decoheres, or if speed, saturation, force, or moment materially exceeds the v34-v38 envelope
