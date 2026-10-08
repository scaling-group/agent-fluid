# Candidate diagnosis and hypothesis

## Evidence read before editing

- The only sampled solver is the assigned transferred-2D parent, so it is the
  informative finite failure; no successful sample is present for a valid
  strong-versus-failure comparison. No inherited optimizer-log directory was
  present; the inherited guidance contains only the initial task strategy and
  evidence-reading contract. The sampled rollout satisfies the experiment
  contract: direct uniform initialization, `U_infinity=[0,0,0]`, no prewarm,
  no cylinders, and both required visual views are present.
- The top-down row shows a self-propelled fish laying down a strong alternating
  wake. It advances from the upper-right toward the target at first, but its
  path remains too far toward decreasing world `y`, passes below the target,
  and then continues to the lower virtual boundary. The target distance falls
  from `12.3277L` to `4.7800L` at `17.853T`, then grows to `9.7089L`; the fish
  exits at center `y=0.7982L` at `27.4945T`.
- The oblique body/Lambda2 row confirms a coherent three-dimensional vortex
  train and continued propulsion through the failure. There is no visible
  loss of the body, wake collapse, imposed-flow advection, or out-of-plane
  instability to explain the miss. This is primarily a planar course-control
  failure, so the inherited traveling-wave carrier should be preserved.
- A reconstruction from `trajectory.csv` and the policy equations exposes an
  actuator-polarity mismatch. Initially the target is only `0.155 rad` to the
  clockwise side of the forward axis, and the inherited guidance requests a
  negative turn, but its negative curvature coefficient converts that into an
  approximately `+6.4 deg` mean posterior tangent. Once the target has been
  passed, the request remains strongly negative while the inherited posterior
  setpoint is about `+10 deg`. Over `20--25T`, the measured mean tail tangent
  remains positive (`8.2 deg`) while body yaw increases by `42.7 deg` and the
  fish travels another `3.68L` downward, leaving the target behind. This
  evidence is consistent with the 2D-inherited curvature polarity steering the
  L64 3D body opposite the requested target correction.
- Raw oscillator commands often exceed the evaluator's acceleration envelope,
  while joint-rate clipping is also visible. That is a durable concern, but
  this candidate does not simultaneously redesign the productive carrier;
  changing carrier effort and steering polarity together would confound the
  next CFD result.

## Policy hypothesis

Replace the inherited direction-asymmetric inverse-polarity curvature map with
one bounded, reflection-equivariant posterior mean-curvature map. The signed
curvature setpoint will have the same sign as the already bounded body-frame
turn request, so a negative target/yaw-rate request produces a negative mean
tail tangent. Preserve target geometry, yaw-rate feedback, approach scheduling,
state-only oscillator, posterior lag, and half-cycle actuation.

The next rollout should retain the coherent propulsive wake while bending the
center trajectory toward the target instead of the lower boundary. Falsify the
hypothesis if the signed target bearing does not contract, if the trajectory
exits another boundary without improving the `4.7800L` closest approach, or if
the sign change destroys forward progress or wake coherence. A capture or a
meaningfully better termination/trajectory topology would support the transfer;
the unevaluated candidate itself is not evidence.

bookshelf_consulted: true
source_domain: robotic-fish turning and averaging models
source_mechanism: bounded target-directed mean-curvature or tail-beat bias superposed on a propulsive rhythm
transferable_invariant: steering authority comes from a signed bounded average bend while the alternating traveling wave remains active
nontransferable_details: published gains, robot geometry, species kinematics, dimensional beat settings, exact vortex phase, and task routes
policy_translation: map the normalized body-frame target and recent body yaw into a bounded signed posterior tangent setpoint under the existing two-joint state-feedback oscillator
falsification: reject if target-bearing contraction and closest approach do not improve, or if the polarity change erases propulsion, wake coherence, or bounded joint behavior
