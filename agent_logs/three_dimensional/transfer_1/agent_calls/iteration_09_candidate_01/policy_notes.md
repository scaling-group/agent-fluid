# Phase-neutral steering-allocation candidate

## Evidence and visual diagnosis before editing

- Every sampled rollout is a finite semantic capture from direct uniform still
  water: `U_infinity=(0,0,0)`, no prewarm, no cylinders, and no advection
  source.  The two repeated v24 rollouts are identical at `26.0425 T`, mean
  distance `2.59751 L`, and score `-0.69471683`, so comments, promotion, and
  other repackaging of that controller are exhausted.
- The best-score sampled sheet, v25 carrier-first steering allocation, shows a
  self-propelled continuous targetward arc in the top-down row and a coherent
  alternating posterior Lambda2 wake in the oblique row through capture.  Its
  route closes at `25.9545 T`, improves mean distance to `2.55008 L` and score
  to `-0.64778945`, and sharply reduces issued acceleration saturation from
  v24's head/tail `69.5%/38.2%` to `30.8%/3.5%`.  This is not the already
  exhausted final output clamp: projecting the carrier before adding steering
  lets opposite-sign target feedback unload a saturated beat.
- The sampled phase-neutral response controller retains the same self-powered
  wake family but visibly develops more separated alternating structures by
  `16--24 T` and follows a more aggressive late arc.  Metrics agree: it has
  the fastest sampled capture at `25.0745 T`, mean/max speed
  `0.5269/0.7806 L/T`, and distance `1.3852 L` at `24 T`, versus v24's
  `2.0645 L`.  It also raises head/tail acceleration saturation to
  `68.6%/53.7%`, overshoots the instantaneous heading reference at `24 T`
  (heading error `-0.5221 rad`), and its mean distance `2.55414 L` and score
  `-0.65392204` narrowly trail the carrier-first result.  Thus the improvement
  is real but leaves an actuator-allocation and late-turn-efficiency weakness.
- The inherited speed-released posterior energy-envelope rollout is the most
  informative negative control.  Its two-view sheet retains coherent
  propulsion and capture, but the route is visibly slower rather than a new
  useful topology; metrics regress to `26.9170 T`, mean distance `2.60943 L`,
  and score `-0.70525680` despite slightly better distance at `2--8 T` than
  v24.  Adding posterior phase-aligned energy from low-speed deficit therefore
  does not solve the whole-route objective and should not be stacked here.
- Force and yaw-moment extrema are essentially identical across the compared
  rollouts (`0.02974/0.01484` in normalized planar magnitude), so the evidence
  selects response interpretation and actuator allocation, not load relief or
  a scalar carrier gain.

## Policy hypothesis

Produce one small combination of the two independently positive sampled
mechanisms.  Retain the phase-neutral controller's joint-state estimate of
carrier-locked yaw so target-relative rate feedback reacts to macroscopic turn
response.  At the actuator boundary, project the propulsive carrier first and
then add the target-derived steering residual before a final finite clamp.
These mechanisms occupy different modules: one changes the feedback signal,
the other preserves the resulting steering residual inside the physical
acceleration envelope.  No scalar gait gain is changed and no low-speed energy
residual is added.

The direct expectation is to preserve the phase-neutral route's faster
`20--24 T` closure while reducing its `68.6%/53.7%` command saturation and
late heading overshoot toward the carrier-first envelope.  Falsify the
combination if capture is lost or slower than v24, mean distance or score is
worse than either positive parent, the late arc still overshoots without an
arrival benefit, saturation is not reduced, the alternating two-view wake
loses coherence, or force/moment and joint-limit residence materially grow.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish oscillators and asymmetric flapping control
source_mechanism: separate a state-feedback rhythmic carrier from bounded target-derived turn modulation
transferable_invariant: estimate route-scale response without carrier-locked oscillation and preserve a bounded steering residual when the rhythmic carrier reaches the actuator envelope
nontransferable_details: published oscillator gains, clocked CPG phase, dimensional cadence, species-specific kinematics, exact vortex phase, and prescribed routes
policy_translation: retain normalized body-frame target and joint-state feedback, add the observed phase-neutral yaw estimate in guidance, then project each carrier acceleration before adding its target-steering residual and applying the final parameter-owned clamp
falsification: reject if the combination fails to improve closure and saturation together, loses capture or wake coherence, worsens the route integral, or raises normalized loads or joint-limit residence

## Evidence boundary

All numerical and visual comparisons above are completed inherited or sampled
CFD evidence.  The combined candidate is unevaluated in this worker; its formal
rollout after exit must decide whether the two mechanisms are compatible.
