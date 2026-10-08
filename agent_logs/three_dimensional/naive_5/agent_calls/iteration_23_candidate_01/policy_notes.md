# Coordinated acceleration-envelope promotion

## Evidence diagnosis before editing

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and inertial moving-window
  transport. They reduce to two independently repeated trajectories, and all
  four terminate in capture; duplicate traces establish deterministic behavior
  at this fixed initial condition, not held-out robustness.
- The assigned parent is the selective joint-speed viability controller. Its
  two byte-identical runs capture at `0.749366L` and `27.5770T`, with zero angle
  and speed contacts, but `1686/10028` joint-action samples hit the
  `30 rad/T^2` policy clamp. In the combined sheets, the top-down row shows
  genuine self-propulsion from rest, an organized alternating wake, sustained
  target approach, and a late correct-sign hook into the capture circle. The
  oblique row shows a connected three-dimensional Lambda2 wake along the same
  route. The trailing wake and direct-uniform initialization rule out imposed
  advection and a moving-window translation artifact.
- The two sampled coordinated-envelope descendants also byte-match one another
  in trajectory and both visual rows. They preserve the coherent carrier and
  capture route while removing every exact acceleration-clamp sample and
  retaining zero angle and speed contacts. Relative to the assigned parent,
  capture improves from `27.5770T` to `26.2955T`, mean distance from `2.61279L`
  to `2.51998L`, and the `8/16/24T` distances from
  `10.7118/6.7111/2.4363L` to `10.4619/6.2293/1.8961L`. Peak planar force and
  yaw moment fall from `0.02218/0.01034` to `0.01883/0.00979`; maximum
  command-step change also falls from about `28.17` to `21.03 rad/T^2`.
- The sampled result resolves the parent's componentwise-clipping defect with
  a qualitatively coordinated projection, whereas the inherited stronger
  fixed-rate brake left rate contacts and raised clamp/load exposure. The
  evidence therefore supports promotion of the common envelope, not another
  scalar strengthening of the angle, speed, or navigation gains. No sampled
  non-capture exists, so the assigned parent is the informative failure only
  with respect to acceleration feasibility, load, arrival, and route cost.

## Policy hypothesis

Promote the independently reproduced coordinated soft acceleration envelope
without altering the capture-proven carrier, body-frame target-line response,
terminal release logic, or angle/rate viability guards. Once the completed
two-joint command exceeds the `27 rad/T^2` soft band, smoothly compress its
peak toward the hard limit and multiply both commands by one common factor.
This leaves viable commands unchanged and preserves instantaneous anterior to
posterior command direction and ratio instead of allowing independent hard
clipping to distort the traveling bend. Keep both observed-joint safety guards
downstream so the projection cannot weaken their full inward braking authority.

The formal candidate should reproduce capture, the coherent top-down and
oblique wakes, zero angle/rate contact, zero acceleration-clamp residence, the
earlier approach, and lower load peaks. Reject the transfer if sub-band
commands change, capture or wake coherence is lost, any joint limit contact or
clipping returns, the safety guards lose authority, arrival regresses, or
force/moment exposure exceeds the assigned parent. The new CFD evaluation is
performed only after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: classical traveling-wave fish propulsion and sensor-modulated low-dimensional robotic-fish CPG control
source_mechanism: productive rhythmic swimming depends on coordinated anterior-to-posterior wave structure, while bounded feedback should modulate rather than independently truncate that carrier
transferable_invariant: actuator-feasibility projection should preserve the relative direction and ratio of a viable two-joint traveling-bend command
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, full-body waveforms, exact vortex phases, Strouhal targets, and task-specific routes
policy_translation: retain normalized body-frame target feedback and jointly scale only above the soft acceleration band, with observed-state angle and speed guards downstream
falsification: reject if repeat capture or coherent self-propulsion is lost, sub-band commands change, angle/rate contact or acceleration clipping returns, or arrival and force/moment loads worsen

## Non-CFD implementation audit

- The mandated checker agent was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account. After removing one duplicated assigned-parent
  marker from the rendered workspace README, its three configured commands were
  run directly and separately; the guidance semantic-delta/schema check, finite
  Julia policy contract, and solver editable-boundary check all pass. No CFD was
  run in this workspace.
- The candidate byte-matches the independently reproduced sampled
  coordinated-envelope policy, and only the allowed candidate file changed
  under `solver/`. The new direct parameter reference is owned by
  `target_policy_params()`.
- A deterministic grid of 243 finite states confirms bounded two-joint output
  and lateral reflection equivariance. The envelope materially changes 156
  states relative to the assigned parent and exactly passes through 87 states.
  This is a contract/mechanism audit, not a new rollout or a held-out
  performance claim.
