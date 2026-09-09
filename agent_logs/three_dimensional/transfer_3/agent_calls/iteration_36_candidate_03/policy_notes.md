# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled evaluations report `uniform_direct`, zero background
  velocity, no prewarm, finite dynamics, and capture. The assigned parent is
  the actuator-consistent phase policy. Its two exact-hash samples capture at
  `18.6725T` and `18.7330T`, score `-0.13219` and `-0.13142`, and retain
  coherent body-led alternating wakes in both the top-down vorticity and
  oblique Lambda2 rows. Local-flow RMS is only `0.01816U` and `0.01804U`, so
  the motion is self-propelled rather than advection.
- The newest distinct sample adds hard joint-rate anti-windup. Its combined
  sheet shows the same target-directed trajectory, alternating wake, and
  continuous final turn as the parent; it captures at `18.7000T`, inside the
  exact-parent timing spread. Posterior action RMS falls from
  `28.72--28.77` to `28.24 rad/T^2`, and posterior acceleration-limit
  occupancy falls from `75.19--75.46%` to `73.91%`. Force/moment RMS remains
  overlapped (`0.01333/0.00694` versus parent
  `0.01331--0.01335/0.00693--0.00695`), while posterior speed-limit occupancy
  does not improve (`7.35%` versus `7.05--7.36%`). This is useful command-
  feasibility evidence, not a resolved hydrodynamic-load or route advantage.
- The helpful-moment residual also captures at `18.6560T`, but inherited
  exact-policy repeats erased its apparent route advantage. The assigned
  parent logs likewise contain four consecutive captures with scores spanning
  `-0.13676` to `-0.42356`; scalar score and small single-run timing changes
  are therefore not enough to justify another instantaneous response
  allocator.

## Policy hypothesis

Keep the normalized LOS C-bend, response-reversing half-cycle path, traveling
posterior wave, persistent same-side phase recruitment, and componentwise
acceleration projection unchanged. Add one actuator-feasibility mechanism:
project each outward acceleration through a smooth normalized joint-rate
headroom gate using observed `phi_dot` and the owned joint-rate limit. The dry
interface check confirms that this moving-window observation does not expose
an integration interval, so the gate owns a dimensionless `4%` headroom band
instead of inferring a clock or step size. It begins just inside the speed
boundary rather than waiting until the joint is already clipped, but it never
attenuates reverse acceleration. In the active posterior headroom band, use
the current same-side raw demand as the persistence witness for phase
recruitment so feasibility projection does not accidentally erase the proven
route semantics.

Expected result: retain capture and the coherent wake within the parent's
`18.6725--18.7330T` timing band while emitting fewer unreachable posterior
commands than the hard anti-windup sample. The hypothesis is falsified if the
route leaves that band, capture is lost, the alternating wake weakens, action
RMS or acceleration-limit occupancy does not fall below `28.24 rad/T^2` or
`73.91%`, or force/moment RMS separates upward from `0.01335/0.00695`.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-feedback modulation of robotic-fish CPG locomotion
source_mechanism: preserve a low-dimensional rhythmic carrier while bounded proprioceptive feedback adjusts only the actuator-infeasible residual command
transferable_invariant: feedback should preserve the traveling gait and smoothly withdraw only outward action as actuator headroom vanishes
nontransferable_details: published CPG gains, oscillator timing, robot morphology, dimensional joint limits, species kinematics, and task routes
policy_translation: use normalized joint-rate headroom to project only outward acceleration, leaving braking and the two-joint LOS/phase carrier intact
falsification: reject if capture or wake coherence is lost, arrival leaves the replicated parent band, or command clipping and load do not improve beyond the sampled hard anti-windup result
