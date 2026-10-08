# Evaluated braking-reserve candidate

## Visual and quantitative diagnosis before the policy edit

- The four sampled solver examples are byte-identical replications of the
  course-preview controller. Each satisfies the frozen contract (direct
  uniform still water, `U_infinity=[0,0,0]`, no cylinders, no prewarm) and
  self-propels to capture at `24.5795T` with minimum/final distance
  `0.746968L`. Their common top-down row starts wake-free, develops a coherent
  alternating wake along the diagonal approach, and redirects into the target
  circle. The oblique row shows compact three-dimensional Lambda2 structures
  persisting through capture, so the useful route is propelled rather than
  advected.
- The inherited predictive braking-reserve descendant is the strongest finite
  comparison. It preserves the same visible route and coherent wake and
  captures at `24.6290T`, `0.748702L`. Relative to the sampled controller it
  removes sampled posterior `45 deg` hard-stop occupancy (`23.45%` to `0%`),
  limits maximum posterior bend to `0.7680 rad`, and reduces peak absolute
  body-frame force/yaw-moment coefficients from
  `0.269/0.178/0.143` to `0.0241/0.0303/0.0149`. This is a semantic actuator
  improvement despite its slightly lower scalar score.
- Two inherited rate-barrier descendants provide replicated negative evidence.
  Both preserve zero posterior hard-stop occupancy and low loads, and reduce
  exact joint-rate exposure from the braking reserve's `15.163%` to `0%` and
  `0.236%`. Yet they miss the target at `0.8484L` and `0.9332L`, respectively,
  then execute the same broad upward curl and leave the domain near
  `36.75--37.27T`. The failure sheet still shows a coherent self-generated wake
  rather than instability or passive drift. The intervention began around
  `2T` on the rhythmic carrier, well before terminal steering; eliminating
  downstream rate dwell changed route-scale thrust/turn balance. A different
  near-limit blend strength did not rescue capture.
- The inherited logs also close output-only acceleration projection,
  conditional relief handoff, late recapture, and another predictive-threshold
  edit. Those changes either duplicate downstream clipping, spend the narrow
  capture margin, or leave the same failure topology. The current evidence
  therefore supports preserving the successful constraint mechanism rather
  than stacking another actuator filter.

## Policy hypothesis

Replace the prefilled course-preview controller with the exact evaluated
predictive braking-reserve policy. Preserve its target geometry, velocity-course
preview, traveling-bend carrier, steering-priority allocation, and all gains.
Add only its mirror-equivariant posterior feasibility layer: projected stopping
stroke advances the existing bounded priority guard, and a final posterior
braking reserve supplies sufficient inward acceleration before the `44 deg`
reserve without conditioning that brake on route phase. Deliberately omit both
joint-rate barriers; the completed rollouts show that local removal of
rate-limit occupancy is not dynamically neutral for this carrier.

Expected evidence is replication of capture, coherent diagonal approach, zero
sampled posterior hard-stop occupancy, and the low-load class. Falsify this
selection if it does not capture, materially changes the established far path,
returns the posterior hard stop, or exceeds the inherited
`0.0241/0.0303/0.0149` peak load class. The candidate's CFD result is not
available to this worker and is not claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish rhythmic control and elongated-body posterior reactive swimming
source_mechanism: proprioceptive feedback protects finite posterior stroke while retaining the phase-lagged traveling bend that supplies reactive thrust
transferable_invariant: reserve bounded inward posterior acceleration when observed angle and outward rate predict a stroke conflict, while leaving feasible rhythmic motion unchanged
nontransferable_details: published gains, dimensional cadence, species-specific kinematics and envelopes, exact vortex phases, and task-specific routes
policy_translation: use normalized posterior angle and rate with the owned stroke guard and acceleration envelope to predict stopping stroke and filter only the second-joint command near infeasible outward motion
falsification: reject if capture, far-route coherence, zero posterior hard-stop occupancy, or the inherited low-load class is not reproduced

## Pre-evaluation validation

- The candidate is byte-identical to the completed braking-reserve controller
  with SHA-256
  `9fc91d274d3f711369ff4927dc92df91c1fcc8abffa685307778ac30dfe3052e`.
- All `82` direct `params.FIELD` references resolve among the `84` fields
  returned by `target_policy_params()`. The prescribed public-contract state
  returns two finite accelerations.
- Focused reserve probes pass through an inside-band command exactly, activate
  bounded inward braking for the evidenced outward near-stop state, and are
  mirror-equivariant to numerical tolerance.
- The configured check runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this account. Its three declared no-CFD commands were run
  directly and separately: the reusable-guidance semantic check, Julia policy
  contract, and solver editable-boundary audit all pass. No formal CFD was run.
