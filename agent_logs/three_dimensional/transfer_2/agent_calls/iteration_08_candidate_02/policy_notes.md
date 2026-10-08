# Steering-priority sector-intercept candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform quiescent initialization with `U_infinity=[0,0,0]`, no cylinders,
  no prewarm, finite dynamics, and moving-window transport. Their motion is
  self-propelled rather than imposed advection.
- Both rows of the combined keyframe sheets were inspected, comparing the
  strongest finite closest approach (`solver_a81796f958a5`, `2.579L`) with
  the scalar-worst left-domain failure (`solver_0e39f9f53067`, `3.031L`) and
  the assigned prefill (`solver_b99a83cfb22d`, `3.024L`). The top-down row
  shows a persistent alternating wake behind every translating body, and the
  oblique Lambda2 row shows compact three-dimensional shed structures through
  approach and late turning. Wake breakup or absent propulsion is not the
  limiting failure.
- The three posterior-recapture variants are a concrete negative family.
  Passage recapture, carrier-unloaded recapture, and persistent-route
  recapture reach only `3.031`, `3.024`, and `2.996L`; all execute nearly the
  same broad northward hairpin and leave the upper edge near `49.4T` at
  `7.42--7.53L`. Posterior carrier unloading lowers raw acceleration-envelope
  exposure from `92.77%` to `82.97%`, but does not reacquire the target.
  Another behind-gate threshold or late curvature gain is therefore not the
  useful opening.
- The sector-intercept plus recapture sample is the only current mechanism
  that materially improves the pass: minimum distance is `2.579L`, mean
  distance `6.913L`, versus approximately `3.0L` and `7.02--7.11L` for the
  recapture family. At its closest sample (`25.102T`) the fish is moving at
  about `0.65L/T`, local flow is only about `0.023L/T`, and the wake remains
  coherent, yet the target is still roughly `2.58L` lateral to the head and
  measured yaw rate is `1.81rad/T`. It then follows the same non-capturing
  upper-turn topology and exits earlier at `45.331T`.
- The strongest sample still presents at least one raw joint acceleration
  beyond `1800deg/T^2` on `82.76%` of trace samples and a joint rate at its
  limit on `12.59%`. The inherited steering-priority experiment identifies
  the actuator-allocation consequence: sector curvature summed after the
  large carrier can be erased by downstream clipping even when the geometric
  gate occurs in the right interval.

## Policy hypothesis

Start from the evaluated sector-intercept plus recapture controller, preserving
its body-frame gates, phase-selective traveling-wave carrier, and late
carrier-unloaded recapture. Add one compact control-allocation mechanism:
decompose each joint request into carrier and steering terms, and only while
the existing normalized closing-sector request is active, give bounded
steering first claim on the existing acceleration envelope before admitting
the remaining carrier. Outside that pulse the raw command remains exactly the
sampled policy command; the target-behind recapture remains unchanged.

The falsifiable expectation is earlier useful redirect inside the demonstrated
sector, a closest approach below `2.579L`, and reduced in-sector command loss
without destroying the coherent wake or changing the pre-sector path. Reject
the mechanism if it merely recreates the sampled upper hairpin, suppresses
propulsion after sector release, worsens closest approach, or raises rate/load
exposure materially. Formal closed-loop improvement is not claimed before the
post-worker CFD evaluation.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish turning
source_mechanism: large-error bounded curvature with response-gated release back into a propulsive rhythm
transferable_invariant: during a large observed route error, temporarily prioritize bounded reorientation authority over the cruise carrier and restore the carrier continuously when the observed redirect sector releases
nontransferable_details: species-specific C-start shapes, published gains, dimensional timing, exact vortex phases, gait envelopes, and task-specific routes
policy_translation: use the existing mirror-equivariant normalized body-frame closing-sector request as the allocation gate; reserve the two joints' existing acceleration envelope for curvature and steering terms before admitting carrier acceleration, with no clock or stored mode
falsification: reject if pre-sector commands change, the `2.579L` pass is not improved, in-sector clipping still erases steering, wake coherence or propulsion is lost, or the completed broad upper-loop failure remains

## Pre-evaluation checks

- All `73` direct `params.FIELD` references resolve among the `75` fields
  returned by `target_policy_params()`; only metadata fields `version` and
  `control_period` are not read directly by the candidate.
- A deterministic `27,648`-state comparison with the evaluated sector-
  intercept/recapture policy spans mirrored target geometry, closing speed,
  bearing and trend, yaw rate, and joint phase. All outputs are finite. Every
  one of the `20,736` zero-sector states has exactly identical two-joint raw
  output, while all `6,912` active-sector states exercise the allocator.
- A signed component grid confirms that full-priority allocation remains
  within the existing `1800deg/T^2` envelope and is antisymmetric under
  simultaneous reflection of carrier, steering, baseline, and sector sign.
  This is a fixed-state algebraic check, not a claim about the new closed-loop
  trajectory.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable for this account. Its three prescribed no-CFD checks
  were therefore run directly: reusable-guidance semantics, the lightweight
  Julia public contract, and the solver editable-boundary audit pass. Formal
  CFD remains deferred to EvE after this worker exits.
