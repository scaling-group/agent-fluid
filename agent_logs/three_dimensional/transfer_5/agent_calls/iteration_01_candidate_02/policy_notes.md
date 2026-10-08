# Candidate wake-policy notes

## Parent evidence diagnosis

- The assigned parent is the unmodified transferred clean-B iteration-20 2D
  champion. No inherited `logs/optimize/` directory was present, so the
  available lineage evidence is the parent guidance plus sampled rollout
  `solver_24bf67867ea8`.
- The rollout satisfies the evidence contract: it starts from direct uniform
  still water (`U_infinity=[0,0,0]`) with no prewarm or cylinders. The combined
  sheet's top-down row shows the fish forming a strong alternating wake and
  translating under its own actuation; the oblique Lambda2 row confirms a
  three-dimensional, body-attached wake rather than background advection.
- The useful finite segment reduces head distance from `12.3277 L` to
  `4.7800 L` near `17.85 T`. It then passes below the target, continues toward
  decreasing world y, and exits the lower boundary at `27.49 T` with
  `9.7089 L` final distance. The late top-down and oblique frames both show the
  swimmer rotating/advancing away while retaining a coherent wake. Thus the
  failure is lost directional control, not loss of propulsion or numerical
  instability.
- The trajectory corroborates the visual turn failure: center y falls from
  `14.0 L` to `0.798 L`; after the closest approach the speed remains about
  `0.8 L/T`, while the target has moved strongly lateral/behind in the body
  frame. A joint touches the `260 deg/T` speed limit in `23.1%` of samples, and
  `98.0%` of logged raw acceleration requests exceed the `1800 deg/T^2`
  actuator envelope. Therefore the seed's additive turn residual and mild
  mean-curvature bias frequently compete with a clipped propulsion command and
  cannot reliably arrest wrong-way yaw.

## Policy hypothesis

Retain the state-feedback traveling-bend oscillator that produced the useful
approach and coherent wake. Add one continuous response-gated redirect
mechanism: large normalized body-frame target misalignment opens a gate, and
wrong-sign measured yaw increases it; the gate smoothly reallocates the two
joints from the saturated oscillator to a bounded same-sign C-bend posture.
Correct-sign yaw and restored alignment release the posture back into cruise.
This changes the allocation of limited actuator authority rather than merely
raising a steering gain. It should turn upward before the lower-boundary exit
while preserving self-propulsion outside redirects.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG turning
source_mechanism: response-conditioned C-start-like bend blended with a propulsive rhythm
transferable_invariant: allocate bounded curvature authority when target error is large, then release the redirect when observed heading response becomes useful
nontransferable_details: species-specific C-start shape and timing, published robot gains, clock phase, exact tail-beat waveform, and any world-frame route
policy_translation: use normalized body-frame bearing/vector angle and normalized recent yaw rate to blend the two-joint state-feedback oscillator with a bounded joint-angle PD bend of the requested sign
falsification: reject if the rollout retains the same lower-boundary topology, fails to reverse wrong-way yaw, loses the coherent propulsive wake outside redirects, or increases joint saturation without improving minimum/final distance or termination class
