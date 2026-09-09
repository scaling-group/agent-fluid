# Moment-anticipated half-cycle release candidate

## Evidence and visual diagnosis before editing

- All four sampled episodes satisfy the frozen direct-uniform contract:
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window
  transport, and capture. The combined keyframe sheets for the strongest
  finite sample `solver_3fdd63b3fbda` and the informative lowest-score capture
  `solver_b505efd9ced6` were inspected from release through termination in both
  rows. Both fish self-propel from blank still water, shed coherent alternating
  top-down vorticity and three-dimensional Lambda2 structures, and turn toward
  the target without collision or wake collapse. The strongest sample reaches
  capture on a visibly faster, broader sweeping arc; the lower-score sample
  follows a shorter but slower terminal route. Thus the contrast is allocation
  and trajectory shape, not advection or instability.
- The evaluated redirect-priority parent is the clear performance reference:
  it advances the `10/8/6/4/2/1L` milestones at
  `5.863/7.838/9.779/11.726/14.201/15.604T`, captures at `16.044T`, and has
  distance integral `1.82409L`. The predictive rate barrier and joint-wise
  positive-work variants preserve coherent capture but regress to
  `17.418T/1.93044L` and `17.413T/1.94829L`, respectively.
- The inherited load-magnitude hypothesis does not survive this batch as a
  useful carrier governor. It slightly advances the first `10/8L` crossings,
  but then captures at `16.258T/1.83377L`, widens head path from `13.178L` to
  `13.191L`, and raises sub-`2L` mean absolute yaw/lateral speed from
  `0.094 rad/T / 0.359U` to `0.128 rad/T / 0.366U`. Its small reductions in
  peak force/moment (`0.03579/0.01770` to `0.03500/0.01755`), mean commands,
  and greater-than-90%-rate residence do not compensate for the slower,
  less-settled approach.
- Signed trajectory reconstruction explains why: 625 of the parent's 649
  samples above `|Mz|=0.01` have normalized yaw moment aligned with the
  instantaneous body-frame turn request. Magnitude-only withdrawal therefore
  suppresses mostly useful, self-generated reactive response. The observed
  force/moment peaks occur far from capture and well below the rate envelope;
  they are not evidence of an external disturbance or impending instability.

## One-candidate policy hypothesis

Restore the evaluated redirect-priority parent exactly except for one
response-gated steering mechanism. Keep the phase-preserving carrier, mean
target curvature, terminal course redirect, distance/closing relief, and
existing rate governor unchanged. Interpret signed normalized yaw moment that
agrees with the requested turn as an early indication that hydrodynamic turn
response has arrived. While either aligned moment or measured yaw rate reports
that response, smoothly release only the extra joint-state half-cycle steering
asymmetry; retain the symmetric traveling rhythm and all mean steering. This
preserves strong asymmetric onset while avoiding continued useful-stroke
amplification after the fluid is already producing the requested yaw.

Expected signature: retain the parent's early milestone and capture class
while reducing its `13.178L` arc, `0.03579/0.01770` load peaks, and/or
`17.76/8.12%` high-rate residence more materially than magnitude-only carrier
withdrawal. Falsify if capture or either coherent wake view is lost, timing or
integral regresses outside the `16.044--16.258T` / `1.82409--1.83377L`
reference band without a clear path/load/rate improvement, early milestones
slow, terminal yaw/slip worsens, angle margin falls, or command/load peaks
increase. If falsified, retain the redirect-priority parent and avoid both
load-magnitude carrier relief and moment-based steering release for this
direct-quiescent release; revisit signed load feedback only when a held-out
inflow or pose exposes genuinely adversarial load.

bookshelf_consulted: true
source_domain: response-gated C-start turning and sensor-modulated robotic-fish CPG direction control
source_mechanism: apply strong asymmetric turning while response is absent, then release the extra asymmetry continuously as measured body response appears
transferable_invariant: distinguish signed useful turn response from load magnitude and preserve the phase-lagged propulsive carrier while releasing only surplus directional asymmetry
nontransferable_details: published gains, species-specific C-start timing and kinematics, dimensional cadence, exact vortex phase, full-body envelopes, and task-specific routes
policy_translation: form bounded response fulfillment from normalized body-frame turn request, recent yaw rate, and signed normalized yaw moment; use it only to attenuate the joint-state half-cycle asymmetry while leaving carrier, mean curvature, target geometry, and terminal redirect intact
falsification: reject if early progress or capture timing regresses beyond the parent/load-aware band without a material path, load, or rate benefit, or if wake coherence, terminal yaw/slip, joint margin, or command effort worsens
