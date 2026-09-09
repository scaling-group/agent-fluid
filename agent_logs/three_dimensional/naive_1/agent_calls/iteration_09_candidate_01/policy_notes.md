# Phase-gated differential-curvature candidate

## Evidence diagnosis before the edit

- All four sampled evaluations are valid direct-uniform, zero-inflow runs and
  capture at `0.7464--0.7493L` in `19.019--19.228T`. Their combined sheets
  show self-propelled target approach with a persistent alternating top-down
  street and compact caudal Lambda2 structures. The wake remains coherent at
  capture; the visible variation is which side of the terminal circle is
  crossed, not a different wake or termination class.
- The strongest sampled terminal-lateral-velocity candidate captures at
  `19.019T`; the persistent, final-projected, and progress-qualified variants
  capture at `19.228T`, `19.135T`, and `19.168T`. Mean distance remains tightly
  grouped (`7.87--7.94L`), so this is evidence for preserving the established
  route controller, not for interpreting score differences as gain evidence.
- The trajectories retain substantial actuator contact: the projected
  variants spend about `10.8%/14.1--14.6%` of samples at the anterior/posterior
  rate limits. Inherited evidence also shows that an outward-rate gate loses
  capture and exits after approaching only `5.3386L`. A new pointwise limiter
  is therefore not the next mechanism.
- The top-down trajectory is broadly direct by `12T`, while the body continues
  through beat-scale yaw excursions. This leaves a testable opportunity to
  allocate a small amount of existing steering curvature to the useful
  half-cycle without disturbing the already successful terminal controller.

## Candidate hypothesis

Preserve the normalized target-side request, sign-preserving yaw release,
opposite-sign mean-curvature allocation, terminal body-lateral-velocity lead,
and final acceleration projection. Add one small half-cycle steering primitive:
outside the terminal regime, infer phase from normalized joint-1 velocity and
increase differential curvature only while joint 1 moves toward the bend
requested by target geometry. Fade the increment out before the terminal lead
becomes active so the evidenced capture crossing remains the baseline. This
should improve early/middle route alignment without a clock, world route, or
instantaneous wake phase.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and fish turning by propulsive-rhythm asymmetry
source_mechanism: target-directed half-cycle amplitude or duty-ratio asymmetry
transferable_invariant: persistent turn geometry may strengthen only the target-supporting half-cycle while preserving the alternating traveling bend
nontransferable_details: published gains, duty ratios, species kinematics, exact oscillator or vortex phase, and task-specific routes
policy_translation: multiply bounded body-frame target curvature by a rectified normalized joint-1 velocity phase, apply a small opposite-sign two-joint curvature increment only outside the terminal regime, and retain final command projection
falsification: reject if capture is lost, arrival or distance history is not meaningfully better than the sampled repeat band, the same yaw excursions remain, wake coherence degrades, or rate contact and force or moment loads materially worsen
