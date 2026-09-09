# Candidate diagnosis and hypothesis

## Evidence diagnosis

- All four sampled rollouts satisfy the direct-uniform still-water contract
  (`U_infinity=[0,0,0]`) and capture, so there is no advection or initialization
  artifact to exploit.  The combined top-down and oblique sheets show a
  self-propelled, compact alternating wake and the same broadly direct route in
  both the best-score posterior-residual policy and the weaker persistent-line-
  rate policy.  Propulsion and far-field route acquisition should be preserved.
- Capture quality remains threshold-limited.  The assigned force-response
  parent reaches `0.748409L` at `15.7384T`, but its reconstructed terminal
  constant-course miss is `0.7441L` at speed `1.3106L/T`; the terminal body-yaw
  rate is `-1.812rad/T`.  The fastest sampled tail-only predicted-miss residual
  reaches `0.742902L` at `15.1403T`, but still carries `0.6511L` predicted miss
  at `1.4794L/T` and raises peak normalized planar force/moment to about
  `0.0404/0.0190`.  The two target-line-rate variants and the parent span
  `0.6740--0.7470L` terminal miss.  Thus the family repeatedly crosses the
  capture edge with substantial transverse course rather than settling a
  robust approach.
- The inherited experience rejects more target-line-rate completion logic,
  persistent-curvature sign/gain work, and broad carrier braking.  It asks for
  a separately scheduled terminal residual that tends rapidly to zero on an
  already-centered course.  No inherited optimizer note exists under
  `logs/optimize/` in this rendered workspace, so the assigned parent source,
  sampled policies, durable experience, trajectories, diagnostics, and visual
  sheets are the available inherited evidence.

## Policy hypothesis

Preserve the assigned parent's oscillator, unified geometry/response handoff,
posterior pulse, and carrier-separated force re-engagement.  Add one approach-
hold mechanism: while the target is close and still ahead, reduce only the
posterior traveling-wave target when the measured constant-course miss exceeds
a normalized margin.  The anterior rhythm and both steering channels remain at
full authority; the posterior relief goes exactly to zero once the predicted
course is centered.  This should exchange a small amount of excess near-field
thrust for another corrective beat without repeating broad carrier braking.

Falsify the mechanism if it loses capture, degrades the direct route or compact
wake, merely delays an equally marginal crossing, increases load/joint-limit
occupation, or fails to reduce course-miss spread relative to the sampled
`0.651--0.747L` range.

bookshelf_consulted: true
source_domain: elongated-body propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: posterior kinematics provide a thrust lever, and observed approach state can continuously modulate a rhythmic command
transferable_invariant: separate near-field thrust authority from steering authority and release the thrust modification when target-relative course geometry is already centered
nontransferable_details: published gains, dimensional beat settings, species-specific envelopes, full-body waves, and any prescribed approach route or exact wake phase
policy_translation: use normalized body-frame target and velocity to gate bounded posterior-only drive relief by close-range closing alignment and excess predicted miss; retain the two-joint state-feedback oscillator and steering contract
falsification: reject if capture margin and terminal course improve neither together, or if translation, wake coherence, load scale, or joint reserve deteriorates
