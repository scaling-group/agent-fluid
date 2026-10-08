# Evidence-selected progress-gated posterior-thrust candidate

## Visual diagnosis before editing

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics, and
  `capture`.  The two repeated completion-gated parents capture at
  `26.4110 T` with score `-0.7105018`; the aligned cadence-recovery branch
  captures later at `26.5430 T` with score `-0.7041927`; and the
  progress-gated posterior-thrust branch is strongest at `26.0425 T`, score
  `-0.6947168`, and distance integral `2.5975 L`.
- I inspected the combined top-down vorticity and oblique Lambda2 rows for the
  strongest posterior-thrust sample and the reproduced parent comparison.
  Since every sample captures, the parent is an optimization failure rather
  than a semantic failure.  Both sheets show motion created by the fish, not
  ambient advection: a compact alternating wake develops from quiescent flow
  by `8 T`, remains coherent through the large redirect, and trails the
  posterior body into the capture circle.  Neither view shows wake collapse,
  a collision, or a destabilizing load event.  The useful difference is the
  target approach, not a more dramatic vortex sheet.
- Trajectory metrics corroborate the visual comparison.  At `24 T` the
  posterior-thrust branch is at `2.064 L` versus `2.246 L` for the parent; it
  reaches a slightly higher mean/max speed (`0.508/0.717 L/T` versus
  `0.501/0.667 L/T`) while keeping peak force and moment coefficients at the
  same sampled scale (`0.0297` and `0.0148`).  Its joint angles and speeds
  remain within essentially the same envelope, and its parameter-owned final
  acceleration projection bounds both issued commands at `31.416 rad/T^2`.
- The aligned cadence-recovery control is a negative comparison: although it
  improves scalar score over the parent, it arrives `0.5005 T` later than the
  posterior-thrust branch, is farther away at `24 T` (`2.304 L`), and raises
  sampled peak force/moment to about `0.0319/0.0159`.  Together with the
  inherited outward-speed guard regression, this argues against combining
  the selected mechanism with another cadence or speed-envelope branch.
- The assigned parent guidance and inherited step-6 notes identify the slow
  launch as the remaining opportunity and isolate a posterior-only,
  response-gated residual.  The completed step-6 CFD result now supplies the
  missing evidence: it does not clearly improve the first `8 T`, but it
  preserves capture and the two-view wake while improving the later route,
  arrival, and distance integral.

## One-candidate policy hypothesis

Promote the sampled progress-gated posterior-thrust controller as the single
candidate.  Preserve its completion-gated body-frame redirect, target
guidance, cadence schedule, half-cycle steering, and componentwise output
projection.  When normalized measured closure is poor, far/approach authority
is available, and steering load is small, modestly increase only the observed
head-velocity term that sets posterior lag.  Release the residual continuously
as closure establishes, the target nears, or steering demand rises.

This is a state-triggered traveling-wave mechanism, not a global gain retune.
It uses normalized body-frame geometry, closing response, turn load, and joint
state; it adds no clock, world coordinate, target identity, stored route, or
exact wake phase.  Expected result: reproduce the sampled `capture` topology
near `26.0425 T`, the lower distance integral, and the coherent alternating 3D
wake.  Falsify it if reevaluation loses or delays capture, returns to the
parent's slower trajectory, materially increases joint-limit residence or
the sampled speed/load envelope, or breaks wake coherence.

bookshelf_consulted: true
source_domain: Lighthill-style reactive propulsion and sensor-modulated robotic-fish CPG control
source_mechanism: emphasize the posterior traveling bend while measured locomotion response and steering demand gate an auxiliary propulsive residual
transferable_invariant: tail-end kinematics can supply thrust through a bounded posterior-only residual that releases when closure establishes or steering needs the proven base gait
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics and amplitude envelopes, clocked CPG phase, exact vortex phase, and prescribed routes
policy_translation: scale only the posterior target's observed-head-velocity lag by normalized closing deficit, distance authority, and inverse turn load while retaining completion-gated target-relative steering and the two-joint state-feedback oscillator
falsification: reject if capture time or distance integral regresses, the later-route and 24T closure lead does not reproduce over the completion-gated parent, or wake coherence, joint-limit residence, speed, force, or moment materially worsens

## Scope

The completed sampled rollout supports selecting this mechanism.  No CFD
result is claimed for the candidate materialized by this worker; formal
evaluation occurs after exit.
