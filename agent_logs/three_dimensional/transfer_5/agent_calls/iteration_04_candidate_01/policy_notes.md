# Joint-velocity-reserve candidate

## Evidence diagnosis

- All four sampled solver examples are deterministic repeats of one semantic
  policy (their policy differences are comments/version strings only). Each
  used valid `uniform_direct` initialization with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, and captured at `0.748994L` after `23.8755T`; the
  identical combined-sheet SHA-256 and `4341`-step traces make this one
  physical result replicated four times, not four independent mechanisms.
- In the current top-down row, the fish self-propels along a smooth
  target-directed arc while maintaining a coherent alternating red/blue wake
  through capture. The oblique row agrees: compact staggered Lambda2 packets
  remain attached to the swimming trajectory and no inherited/advection-only
  motion or three-dimensional breakup precedes contact with the target sphere.
  This supports preserving the traveling-wave carrier, response-released
  same-sign C-bend, and acceleration envelope.
- The slower inherited C-bend sheet has the same qualitative coherent-wake,
  target-directed capture topology, but reaches the target at `25.3880T` with
  mean distance `2.5572L`. Response release improves that to `25.1515T` and
  `2.5218L`; composing it with the smooth acceleration projection improves
  again to `23.8755T`, `2.4357L`, and score `-0.537763`.
- The inherited static-curl failure remains the useful negative comparator:
  replacing the carrier with sustained posture produced a weak/nonalternating
  wake, only `0.155L` closest-approach gain, upper-boundary exit at `7.99T`,
  and `78%` posterior angle-limit contact. Therefore the next candidate must
  modulate, not replace, the proven carrier.
- Smooth acceleration projection solved raw-command feasibility (`max |a|`
  about `31.25/31.38 rad/T^2`) but not joint-speed clipping: the current trace
  remains at the `260 deg/T` cap for about `14.3%/5.6%` of anterior/posterior
  samples and reaches `2.95 rad/T` peak yaw. This is a kinematic-reserve
  problem, not evidence for another scalar cadence or curvature-gain edit.

## Policy hypothesis

Add one direction-selective joint-velocity-reserve projection after the proven
smooth acceleration envelope. Normalize each observed joint speed by the owned
`260 deg/T` limit. Above `90%` of that limit, a cubic gate continuously tapers
only commands whose sign would increase speed magnitude; commands that oppose
the velocity remain available for braking. This is symmetric between turn
directions, uses no clock or route, and leaves all body-frame geometry, C-bend,
posterior lag, and acceleration projection unchanged.

On the frozen current trace, the proposed gate would touch about `16.0%/8.7%`
of anterior/posterior samples and lower mean absolute command by only
`9.1%/4.6%`, while eliminating outward command at recorded speed-cap samples.
That is a counterfactual interface check, not new CFD evidence. The evaluation
should reject this mechanism if capture is lost, arrival is materially later
than `23.8755T`, mean distance exceeds `2.4357L`, wake coherence degrades, or
speed-cap/yaw exposure does not improve enough to justify any progress cost.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control and bounded rhythmic-actuation guardrails
source_mechanism: sensed joint state modulates a rhythmic carrier so actuator constraints do not turn the intended traveling wave into clipped motion
transferable_invariant: preserve the target-directed carrier while continuously reducing only state commands that consume the remaining kinematic reserve
nontransferable_details: published CPG gains, dimensional frequencies, species-specific envelopes, exact tail-beat or vortex phase, and prescribed routes
policy_translation: retain normalized body-frame target feedback and the two-joint oscillator, then use each observed joint velocity normalized by the owned speed limit to taper only same-direction acceleration near that limit
falsification: reject if capture or coherent propulsion regresses, or if joint-speed saturation and peak yaw fail to fall enough to offset any arrival or mean-distance cost
```

## Validation

- The required guidance-semantic check passes against the assigned parent.
- The non-CFD Julia policy-contract check passes, including finite two-joint
  output and the frozen `L=64` observation adapter.
- Every direct `params.FIELD` reference is returned by
  `target_policy_params()`; the editable-file boundary check also passes.
- Focused projector checks pass at the reserve threshold, midpoint, and hard
  speed limit for both signs; opposite-sign braking remains unattenuated and
  non-finite inputs still produce finite output.
- No formal CFD was run in this worker; the rollout hypothesis remains for EvE
  evaluation after exit.
