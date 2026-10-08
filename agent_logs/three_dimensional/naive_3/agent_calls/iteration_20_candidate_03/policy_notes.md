# Feasible-output projection candidate

## Visual diagnosis and completed evidence

- All four sampled evaluations report direct uniform still-water
  initialization with `U_infinity=(0,0,0)`, no cylinders, and no prewarm.
  Their nearly identical translation and wake development are therefore
  controller-generated, not ambient advection or moving-window transport.
- The combined sheets show a coherent alternating top-down vorticity street
  and compact three-dimensional Lambda2 structures through `12T`, `16T`, and
  capture for every sampled policy. Peak body speed is `1.329U`, while peak
  local flow is only `0.0315U`. The established target-ray/velocity-course
  observation, zero-centered anterior oscillator, posterior lag, and terminal
  acceleration reserve should therefore remain unchanged.
- The unguarded capture is the informative safety failure despite its
  successful termination: it reaches exactly `-45 deg` at the posterior
  joint, has 13 samples at or beyond `44 deg`, and produces peak planar force
  and yaw-moment coefficients of `0.20756/0.09276`. The fixed-width brake is
  the best scalar-scoring sample, but it retains the same contact count and
  only lowers those peaks to `0.17183/0.07699`.
- Both velocity-aware policies preserve capture at `18.276T`, keep the same
  visible route and wake, eliminate posterior samples at or beyond `44 deg`,
  and reduce the peak force/moment coefficients to `0.03716/0.01907`. The
  hard viability switch reaches exactly the posterior acceleration limit in
  15 logged samples; the smooth stopping-risk barrier obtains the same load
  and contact improvement without those additional exact-limit barrier
  commands. This supports the inherited smooth barrier rather than another
  fixed margin or bang-bang viability switch.
- A separate contract defect remains after that physical improvement. About
  `51.3%/46.4%` of the sampled smooth-barrier trace's joint-1/joint-2 policy
  outputs exceed the owned `1800 deg/T^2` envelope, with maxima of roughly
  `3430/5066 deg/T^2`. The episode clips those commands downstream, so this
  is not evidence that more drive reaches the body; it is evidence that the
  policy exposes infeasible commands and delegates a known constraint to the
  adapter.

## Policy hypothesis written before the solver edit

Preserve the sampled smooth stopping-risk controller and add one final
feasible-action projection: clamp each returned joint acceleration to the
already-owned symmetric acceleration envelope after the posterior barrier.
This is an actuator-interface mechanism, not a gain increase or a change to
the carrier, steering geometry, target schedule, morphology, or environment.
Because the episode already applies the same componentwise limit, the expected
CFD trajectory, capture time, alternating wake, posterior `43 deg` clearance,
and low terminal loads should be unchanged while policy-output exceedance
falls to zero.

Falsify the implementation if either returned acceleration exceeds the owned
envelope or if the deterministic rollout differs materially from the sampled
smooth-barrier capture. Do not interpret success as lower physical saturation:
exact-limit occupancy will expose the carrier's existing reliance on the
envelope, and any later smooth carrier shaping must be evaluated separately
against capture and wake coherence.

```text
bookshelf_consulted: true
source_domain: constrained robotic-fish CPG control and traveling-wave propulsion
source_mechanism: preserve the productive rhythmic state-feedback carrier while enforcing the actuator envelope at the command interface
transferable_invariant: a demonstrated propulsive rhythm should emit bounded feasible actuation rather than rely on hidden downstream clipping of an unbounded internal command
nontransferable_details: published gains, robot linkage geometry, species-specific kinematics, dimensional cadence, exact vortex phase, source actuator ratings, and task-specific routes
policy_translation: retain normalized target_body_L versus velocity_body_U course feedback and the two-joint joint-state carrier; project both final phi_ddot components into the existing params-owned symmetric acceleration envelope
falsification: reject if policy outputs still exceed the envelope or if capture, the alternating 3D wake, posterior joint clearance, or low terminal loads differ materially from the sampled smooth-barrier rollout
```
