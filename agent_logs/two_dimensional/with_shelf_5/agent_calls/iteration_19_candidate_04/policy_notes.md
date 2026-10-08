# Wake Policy Candidate Notes

## Evidence diagnosis

- The shared prewarm sheet shows the common held fish above and downstream of
  four developed, interacting vortex streets; it is an initial condition, not
  evidence distinguishing policies.
- All four sampled released sheets show the same useful trajectory class: an
  immediate target-directed redirect from the upper-right release, followed by
  a direct left/down transit into the green capture circle without collision or
  domain exit. At the compact keyframe scale, the late trajectory is embedded
  in the interacting wakes but does not show a distinct wake-synchronized gait.
- The sampled set contains no failed termination. Its most informative negative
  comparator is therefore the response-conditioned whole-gait relief, while the
  inherited common-seed lower-boundary exit supplies the genuine failure class.
  The current prefill has the fastest sampled capture (`39.0499`) and lowest
  mean distance (`1.91369L`), but its RMS force/moment are `57.05/783.02`.
  Releasing only auxiliary half-cycle steering captures at `39.1104` with lower
  `54.19/754.87` loads. Adding aligned whole-gait amplitude relief to that
  carrier is dominated: capture slows to `39.2149`, mean distance, command
  energy, crossflow, force, and moment all rise (`1.91592L`, `50246`, `0.22014`,
  `55.32`, `764.02`). This rejects further tuning of that gait-relief selector.
- Embedded wake diagnostics cross-check the visible direct paths: every sample
  has useful relative motion against the mean local flow, but both joints hit
  exactly the `4.53786` rate cap and `31.41593` acceleration cap. Peak joint
  excursions remain below the angle limit. The remaining evidenced defect is
  therefore actuator-envelope contact, not missing target direction or a
  terminal miss.

## Policy hypothesis

Preserve the prefilled circular-history route, sign-coherent posterior request,
response-completion releases, and terminal range schedule. Add one actuator-level
mechanism after those semantic commands are formed: a continuous odd acceleration
projection that is exactly identity below a parameter-owned knee and approaches
a parameter-owned limit below the episode hard cap. This tests whether hard
acceleration clipping can be removed without weakening ordinary carrier commands.
It deliberately does not add an uncalibrated flow/load residual, another phase or
rate selector, or another whole-gait amplitude gate.

Expected evidence is retained direct capture, peak acceleration below
`31.41593`, and lower command effort and force/moment without a worse rate-cap
residence. Falsify the mechanism if capture is lost or materially delayed, or if
the acceleration cap moves inward while effort/load and rate-cap evidence do not
improve.

bookshelf_consulted: true
source_domain: robotic-fish CPG and residual-command control
source_mechanism: keep a low-dimensional rhythmic and steering command while enforcing a bounded actuator-level command
transferable_invariant: preserve the gait and route semantics, then smoothly project only actuator-infeasible command magnitude
nontransferable_details: published CPG gains, servo limits, dimensional frequencies, species kinematics, vortex phases, and task routes
policy_translation: apply an identity-below-knee smooth bound to each raw joint acceleration using only the two-joint state-feedback output contract
falsification: reject if direct capture degrades or acceleration-cap relief does not also improve effort, load, or rate-cap evidence
