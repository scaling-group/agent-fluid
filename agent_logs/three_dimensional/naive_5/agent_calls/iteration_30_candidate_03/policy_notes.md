# Two-joint phase-rejected route response

## Evidence diagnosis before policy edit

- All four sampled evaluations satisfy the direct-uniform still-water
  contract (`U_infinity=[0,0,0]`, no cylinders or prewarm) and capture between
  `26.2405T` and `26.3615T`, with final distances
  `0.748338--0.748829L`. There is no failed termination in this sample. The
  strongest finite example is `solver_8e7135ef9173` (`0.748338L`,
  `26.2460T`, mean distance `2.518971L`); the most informative divergent
  comparator is `solver_730e610b0618` (`0.748792L`, `26.3615T`, mean distance
  `2.519735L`).
- Both combined sheets were inspected from release through capture. Their
  top-down rows show genuine self-propulsion, a regular alternating wake, and
  the same late upward hook into the target circle. Their oblique Lambda2 rows
  retain an organized three-dimensional wake without breakup, passive
  advection, boundary interaction, or moving-window-induced yaw. The slower
  comparator does not expose a useful alternative topology.
- Metrics support the visual diagnosis. All four samples have the same peak
  joint magnitudes (about `0.766/0.772 rad`), joint speeds
  (`4.513/4.507 rad/T`), and commands (`29.726/29.686 rad/T^2`), with zero
  angle, speed, or acceleration contacts. Their peak planar force envelope is
  about `0.01883` and peak yaw moment is `0.00979--0.00990`. Thus neither
  propulsion nor actuator feasibility explains the remaining shallow capture.
- The assigned guidance and inherited step-28/29 logs close two more scalar
  observer branches: translation/history magnitude blends still produced the
  common late hook and captured at only `0.749383L` and `0.749053L`. Preserve
  the best sampled translation-consistent steering side and the proven desired
  response magnitude; another blend threshold or gain is unsupported.
- The response measurement itself is not phase rejected. Within `4.5L`, a
  least-squares diagnostic against a centered one-carrier-period mean yaw rate
  gives stable joint-velocity cancellation coefficients across all four
  samples: anterior `0.5267--0.5358` and posterior `0.1362--0.1407`. The
  existing `heading_rate + 0.45*qd1` has `0.253--0.271 rad/T` RMS error from
  that slow response, whereas `heading_rate + 0.53*qd1 + 0.14*qd2` reduces it
  to `0.0956--0.0983 rad/T`. The omitted posterior traveling-wave motion is a
  repeatable observer defect, not evidence for more steering amplitude.

## Policy hypothesis

Start from the strongest sampled translation-consistent policy and preserve
its traveling-bend carrier, large-bearing redirect and its evaluated release,
target-line desired-response magnitude, posterior capture allocation, coupled
command governor, and angle/rate guards. Add one mechanism only to the
navigation response comparison: estimate slow body turn from heading rate plus
both normalized joint velocities, using the cross-sample coefficients above.
Keep the original anterior-only estimate for redirect release so far-field
burst-release logic is unchanged. The positive-deficit structure remains one-
sided, so the new observer can stop joint-induced apparent yaw from suppressing
a needed target-line correction without cancelling an adequate turn.

Formal CFD should retain the coherent two-view wake, capture, zero hard-limit
contacts, and the sampled load envelope while changing the middle/near route
more than the inherited milliscale cluster or adding capture clearance. Reject
the mechanism if it loses capture, increases limit/load exposure, produces a
new oscillatory steering mode, or repeats the shallow late hook without a
meaningful trajectory, arrival, or clearance improvement. The new CFD result
is not available in this worker.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and classical traveling-wave locomotion
source_mechanism: separate slow sensor-observed route response from fast joint-coordinated propulsive motion before modulating the rhythmic steering residual
transferable_invariant: preserve the productive traveling carrier and remove repeatable gait-correlated motion from the measured turn response before deciding that route authority is adequate
nontransferable_details: published gains, oscillator topology, robot or species morphology, dimensional frequency, exact vortex phase, duty ratio, and task-specific routes
policy_translation: use reflection-equivariant anterior and posterior joint-velocity terms to phase-reject normalized body yaw only in the existing target-line response-deficit gate
falsification: reject if capture or wake coherence is lost, the route remains in the shallow cluster, reflection symmetry fails, or joint-limit and force/moment exposure rises

## Non-CFD implementation audit

- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable on this ChatGPT account. Its three configured checks were then
  run directly and separately. The rendered README contained the identical
  assigned parent twice; removing only that duplicate repaired the validator.
  The material guidance/notes check, finite two-joint Julia contract, parameter
  schema guard, and solver editable-boundary check all pass.
- Frozen-state replay over all `4,772` rows of the strongest sampled trace
  changes `946/9,544` command components relative to that policy, including
  `517` changes above `0.05 rad/T^2`; RMS and maximum changes are
  `0.0637` and `0.7293 rad/T^2`. The maximum replayed command remains
  `29.72585 rad/T^2`. This is a material observer test, not a claim of
  hydrodynamic improvement.
- A deterministic grid of `39,366` body-frame states has finite commands no
  larger than `30 rad/T^2` and zero numerical reflection error. All `47`
  direct `params.FIELD` references are present in `target_policy_params()`.
  No formal CFD was run.
