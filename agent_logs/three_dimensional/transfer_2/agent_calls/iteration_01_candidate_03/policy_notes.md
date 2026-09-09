# Candidate diagnosis and hypothesis

## Evidence read before editing

- The only sampled rollout is finite and numerically stable but terminates
  `left_domain` at `26.18T`; it is therefore both the best finite sample
  available and the informative failure sample. No inherited optimizer note is
  present in this fresh workspace.
- The evidence confirms direct uniform quiescent initialization
  (`U_infinity=[0,0,0]`), no cylinders, and no prewarm snapshot.
- In the top-down row the fish self-propels and sheds a coherent alternating
  wake, but its trajectory rotates from the initially useful left/down heading
  into an increasingly downward path. The oblique Lambda2 row confirms a
  three-dimensional alternating wake attached to active body motion rather
  than passive advection; no imposed flow exists to advect the fish.
- Distance falls from `12.33L` to `6.18L` at about `17.16T`, then rises to
  `10.60L` before the head crosses the lower virtual boundary. Reconstructed
  body-frame bearing is already about `+0.32` rad by `8T` and remains strongly
  positive while the fish passes below the target, reaching roughly `+1.48`
  rad near `20T`. The inherited 2D port therefore recognizes large target
  error but its tail-only mean bias, half-cycle modulation, and branch-heavy
  rate recovery do not redirect the 3D body soon enough.
- The drive itself is useful but actuator-infeasible as commanded: joint speed
  is at the `260 deg/T` limit in about 9%/11% of samples, while raw joint
  acceleration exceeds the `1800 deg/T^2` limit in about 70%/77% of samples.
  Angle limits are not approached. This clipping leaves little interpretable
  steering authority and makes the imported 2D branch logic a poor semantic
  transfer even though the visible wake is propulsive.

## Policy hypothesis

Keep the observed traveling-bend propulsion mechanism, but slow its
state-feedback oscillator enough that its nominal head and tail kinematics fit
the measured actuator envelope. Replace the inherited asymmetric branch stack
with one symmetric, bounded mean-curvature command computed directly from
normalized `target_body_L`. Apply the command as anterior and posterior joint
equilibrium offsets so persistent body-frame target error changes the mean body
shape without erasing the lagged propulsive wave. The sign is calibrated from
the rollout: positive tail tangent coincides with the interval in which heading
finally decreases toward the positive-bearing target, so positive target
lateral error requests positive mean curvature.

Falsify this candidate if it still exits through the lower boundary without
improving the `6.18L` closest approach, if the coherent wake or closing progress
collapses, or if the distributed curvature merely replaces acceleration
clipping with persistent angle/speed saturation. A better termination class or
a meaningfully different target-directed trajectory is useful evidence even
without capture.

bookshelf_consulted: true
source_domain: biological elongated-body propulsion and robotic-fish turning
source_mechanism: posterior-lagged traveling bend with bounded target-driven mean curvature
transferable_invariant: preserve directional phase lag for thrust and steer by shifting average curvature according to persistent body-frame target geometry
nontransferable_details: published gains, dimensional cadence, species envelopes, exact vortex phase, and any source-specific route
policy_translation: retain a joint-state oscillator and lagged tail target; map normalized target_body_L to bounded anterior and posterior equilibrium offsets owned by target_policy_params
falsification: reject if target approach or exit class does not improve, the propulsive wake collapses, or joint saturation remains persistent
