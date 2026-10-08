# Candidate wake-policy notes

## Evidence-led visual diagnosis

- The sampled rollouts all report direct uniform still-water initialization.
  In the combined sheets for the mechanically strong finite sample
  `solver_a22308633a65` and the informative hard-stop failure
  `solver_3991cf23285f`, the top-down row shows the same sustained alternating
  wake from release through the target approach. The oblique row shows compact
  three-dimensional Lambda2 structures convecting behind the fish rather than
  ambient-flow advection. This agrees with the traces: peak swimming speed is
  about `1.329U`, versus only `0.0315U` peak local flow, and both policies
  capture near `18.27T`.
- Their mechanical outcomes differ despite nearly identical route topology.
  The fixed-width brake reaches exactly `-45 deg` at the posterior joint and
  peaks at `0.17183/0.07699` force/yaw moment. The velocity-conditioned barrier
  remains near `-43.0 deg` and lowers those peaks to `0.03716/0.01907` while
  preserving capture and the visible wake. The prefilled global continuous
  barrier therefore remains the safety baseline.
- The sampled in-policy hard-clamp variant and the prefilled downstream-clamp
  variant have identical `-0.248133` score, `18.276T` arrival, trajectory,
  joint extrema, wake sheets, and loads. The clamp changes only the reported
  raw peaks (`59.87/88.41` to `31.42 rad/T^2`); both applied commands still sit
  at the acceleration envelope for about `51.3/46.4%` of samples. Thus
  duplicating the actuator clamp is contract cleanup, not control relief.
- The inherited score-only history corroborates repeatable capture for the
  global barrier at steps 20 and 21, followed at step 22 by an uncharacterized
  left exit with only `5.621L` closest approach. Because that inherited log
  does not contain the failed policy or wake diagnostics, it is evidence to
  make the next actuation change conservative, not evidence for a particular
  causal diagnosis.

## Policy hypothesis

Keep the demonstrated body-frame target/course observation, zero-centered
anterior oscillator, posterior steering reserve, and global stopping-risk
barrier. Add one state-feedback-compatible, continuously differentiable soft
shoulder to the requested carrier accelerations before the posterior safety
projection. Commands below a normalized knee are unchanged; larger requests
approach a ceiling below the physical envelope. The candidate uses a `0.80`
knee and `0.95` ceiling, both expressed as fractions of the owned acceleration
limit rather than dimensional source gains. The posterior barrier remains
downstream and may use the full owned envelope when kinetic stopping risk
requires it. This should replace routine actuator clipping with a bounded
rhythmic command while preserving exceptional braking authority.

The candidate is falsified if it loses capture, materially changes the broad
route or alternating 3D wake, lets the posterior joint approach either hard
stop, exceeds the `0.0372/0.0191` load baseline, or fails to materially reduce
ordinary near-limit command occupancy. The new CFD result is not available to
this worker and is not claimed here.

bookshelf_consulted: true
source_domain: robotic-fish CPG control and classical elongated-body propulsion
source_mechanism: retain a low-dimensional state-feedback rhythm while bounding its amplitude and preserving posterior traveling-wave emphasis
transferable_invariant: a propulsive traveling bend can remain phase-coherent when its routine command envelope is bounded continuously rather than delegated to repeated hard clipping
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phases, and source-task routes
policy_translation: express a C1 acceleration shoulder as fractions of the owned acceleration limit, apply it to both state-feedback carrier requests, and leave target-course allocation plus posterior kinetic-margin braking in control of steering and safety
falsification: reject if capture, wake alternation, angle clearance, or load ceiling is lost, or if ordinary near-limit occupancy is not reduced
