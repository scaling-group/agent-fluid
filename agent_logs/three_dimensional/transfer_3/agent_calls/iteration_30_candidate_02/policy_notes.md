# Candidate diagnosis and hypothesis

## Evidence diagnosis

- All four sampled evaluations are valid direct-uniform still-water runs with
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, finite capture, and both
  prescribed views. Their top-down rows show body-led alternating vortex
  streets from release through capture; their oblique rows show compact
  three-dimensional Lambda2 structures following the swimmer. The fish is
  self-propelled rather than advected: local-flow RMS is only
  `0.018008--0.018088U`, while body-speed RMS is `0.7023--0.7077U`.
- The useful contrast is allocation quality, not wake survival. Raw helpful-
  moment amplitude relief captures fastest at `18.655998T`, on a `12.447344L`
  center path, with force/moment RMS `0.013277/0.006912` and anterior/posterior
  acceleration-limit occupancy `40.743%/75.767%`. The assigned-parent
  stress-gated relief remains coherent and captures, but takes `18.743996T`.
  Actuator-consistent phase alone captures at `18.672497T`.
- Carrier-demodulated opposition-only recruitment is the informative negative
  control. It preserves the same visible alternating wake and captures, but is
  slowest at `18.804493T`, lengthens the center path to `12.501928L`, and raises
  force/moment RMS to `0.013519/0.007041` and anterior limit occupancy to
  `42.615%`. Thus an opposing instantaneous residual is not evidence that the
  established primary phase actuator needs more authority.
- Available inherited optimizer logs contain scalar capture records only. They
  corroborate that recent branches remain in the capture class but do not add
  mechanism diagnostics beyond the sampled wake evidence and assigned parent.

## Policy hypothesis

Preserve the normalized body-frame bearing/LOS-rate route, traveling-bend
carrier, distributed C-bend, persistent same-side phase recruitment, and hard
command projection. Demodulate the normalized yaw moment by the already
sampled joint-state carrier model, but use the residual only as a one-sided
allocator for redundant half-cycle amplitude: a helpful residual may relax
amplitude as yaw error closes; an opposing residual leaves the established
route and phase actuators unchanged. This changes response semantics rather
than carrier gains and remains reflection-equivariant.

Falsify the hypothesis if the new evaluation loses capture or visible wake
coherence, arrives outside the inherited `18.656--18.804T` sampled band,
lengthens the path beyond `12.502L`, exceeds `76.141%` posterior acceleration
occupancy, or exceeds baseline force/moment RMS `0.013499/0.007028`. A result
indistinguishable from the raw helpful-relief run would show that carrier
demodulation adds no useful selectivity in this low-flow regime.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and adaptive wake interaction
source_mechanism: preserve the rhythmic propulsive carrier while sensor feedback allocates only a bounded residual steering channel
transferable_invariant: separate joint-phase carrier response from hydrodynamic residual response, then avoid cancelling helpful fluid-induced motion
nontransferable_details: published gains, species-specific kinematics, exact vortex phases, dimensional frequencies, full-body waveforms, and task-specific routes
policy_translation: subtract a parameter-owned joint-state estimate from normalized body-frame yaw moment and let only helpful residual alignment relax posterior half-cycle amplitude while the two-joint LOS and phase controller remains intact
falsification: reject the transfer if capture, coherent propulsion, route length, saturation, or force/moment load leaves the evidence-backed bounds above
