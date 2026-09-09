# Distributed geometry redirect candidate

## Evidence diagnosis

- All four sampled evaluations report `uniform_direct`,
  `direct_uniform_initial_condition=true`, and background velocity
  `[0,0,0]`; none is a pre-warm or imposed-advection result.
- The combined sheets were inspected in both rows. Top-down views show a
  sustained alternating wake rather than a reciprocal standing wiggle, and
  the oblique Lambda2 views show a self-propelled fish with a coherent curved
  wake through termination. The failures are therefore route-control failures,
  not wake collapse or passive advection.
- The assigned parent `solver_4c50eba7cd00` passes the target x station with
  its head at `y=13.738L` (about `4.24L` high), reaches only `4.128L` at
  `20.44T`, and exits left at `29.66T` with `9.051L` final range. Its RMS local
  flow is only `0.0204U`, its joint angles never approach the `45 degree`
  limit, but its applied anterior/posterior acceleration is clipped in
  `57.8%/73.9%` of rows. The coherent carrier has propulsion and angle margin;
  steering concentrated in the posterior target has little interpretable
  authority left.
- The LOS-rate candidate `solver_3b6bd84298a5` is the best broad approach in
  this sample: it lowers the target-line crossing to `y=12.995L` and reaches
  `3.369L`, but still travels at `0.878U` at closest approach and exits left.
  Range-only carrier damping in `solver_cf44a7c3b1a7` cuts anterior applied
  acceleration clipping from `57.7%` to `34.2%` and lowers speed at closest
  approach to `0.820U`, yet changes the miss by only `0.023L` and repeats the
  same high pass and left exit. Excess approach drive is not the primary
  cause. Conversely, the phase-conditioned response branch
  `solver_adc862529891` curls toward the upper boundary and exits at `16.77T`,
  showing that simply strengthening a posterior response loop can change the
  route in the wrong way.
- Inherited optimizer evidence likewise rejects raw/projected slip retuning,
  full projected-course release, and response-damped posterior half-cycle
  steering. Across those completed iterations, the useful carrier survives
  while algebraic posterior-only steering either preserves the high left pass
  or causes an early upper exit.

## Policy hypothesis

Test exactly one new controller mechanism: a bounded, geometry-gated mean
curvature offset distributed across both joints. Normalized body-frame target
bearing directly sets a slow total-curvature request. A fixed share shifts the
anterior oscillator equilibrium, while the posterior target supplies the
remaining mean curvature and preserves the parent's lagged traveling bend.
Because the offset tends continuously to zero with bearing, target alignment
itself releases the redirect; no time, route stage, world coordinate, or
beat-contaminated velocity projection is introduced.

This isolates actuator distribution from scalar pursuit tuning. The expected
signature is a tighter downward redirect when the target becomes abeam,
without weakening the alternating far-field wake or increasing joint-angle
saturation. Reject the mechanism if it retains the roughly `4L`-high target
line pass, produces the early upper-turn exit, destroys propulsion, or brings
either joint persistently near `45 degrees`; in that case later workers should
stop mean-offset variants and isolate a genuinely beat-scale route estimate.

bookshelf_consulted: true
source_domain: biological rapid redirects and sensor-modulated robotic-fish CPG turning
source_mechanism: large observed direction error creates bounded body curvature across the rhythmic chain and alignment releases it
transferable_invariant: distribute a continuous target-error-driven mean bend across available joints while retaining the propulsive traveling wave
nontransferable_details: species-specific C-start shape, published CPG gains, dimensional beat settings, exact maneuver timing, and task route
policy_translation: normalized body-frame bearing sets bounded total mean curvature; one share shifts the anterior state-feedback oscillator equilibrium and the posterior lag target carries the remainder
falsification: reject if target-line height and closest approach do not improve without wake collapse or new joint-angle saturation, or if the candidate repeats the short upper-boundary curl
