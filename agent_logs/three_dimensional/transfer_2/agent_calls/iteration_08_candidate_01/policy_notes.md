# Steering-priority terminal-approach candidate

## Evidence diagnosis before the policy edit

- All sampled and inherited rollouts report direct uniform still-water
  initialization with `U_infinity=[0,0,0]`, no cylinders, and finite dynamics.
  Both the top-down vorticity and oblique Lambda2 rows were inspected. They
  show a translating fish laying down an alternating, coherent three-dimensional
  wake, so motion is self-propelled and the established traveling-bend carrier
  should be preserved outside the missing control regime.
- The sampled posterior-recapture family is an informative failure: its three
  variants retain coherent wakes but converge to nearly the same broad upper
  loop, with `2.996--3.031L` minima and upper exits near `49.4T`. The prefilled
  sector-pivot sample is better but still misses at `2.579L` and runs out left.
  Those results reject another posterior latch, recapture gain, or route-phase
  persistence edit.
- The completed assigned-parent steering-priority rollout is the strongest
  mechanism evidence. Reserving finite acceleration headroom for steering in
  the existing closing/abeam sector improves the prior sector-pulse minimum
  from `2.606L` to `0.878L`, only `0.128L` outside the `0.75L` capture radius.
  Its top-down row visibly bends toward the target by about `22T`, and the
  oblique row retains compact shed structures through the maneuver. Thus the
  remaining failure is terminal crossing, not insufficient route-scale turn.
- The assigned parent reaches the near miss with excessive residual drive:
  over samples inside `2.1L`, mean planar speed is `0.727U`; at the `25.465T`
  minimum it still travels about `0.80U` with world velocity
  `(-0.629,0.494)U`. It also contacts the `45 deg` posterior-angle and
  `260 deg/T` joint-rate limits, and the strongest load event occurs while the
  posterior joint is pinned at `-45 deg`. The allocation primitive is useful,
  but carrying full rhythmic authority through the terminal funnel is not.

## Policy hypothesis

Start from the completed steering-priority parent, preserving its sector gate,
mean-curvature steering, phase-selective carrier, and finite acceleration
allocation. Add one continuous approach-hold mechanism: inside the existing
`2.1L` approach region, smoothly reduce only the anterior and posterior carrier
components toward a nonzero floor as distance approaches the physical capture
radius. Steering and curvature keep first claim on the unchanged acceleration
envelope. The gate is normalized by body length, has no clock or stored mode,
and releases continuously if distance grows, so it cannot become a posterior
route latch.

Expected result: retain the parent's common far trajectory and coherent wake,
enter the same terminal neighborhood, then reduce cross-target overshoot enough
for the head to cross `0.75L`. Falsify the mechanism if it changes states at or
beyond `2.1L`, loses the parent's sub-`1L` approach, coasts before capture,
increases joint/load saturation, or still exits left without a semantically
better terminal trajectory.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and reduced-order terminal capture control
source_mechanism: separate the propulsive rhythm from bounded feedback authority and continuously reduce excess drive in the terminal capture regime
transferable_invariant: preserve a coherent carrier while far, but near the target reallocate authority from propulsion to steering without coasting or using a timed mode
nontransferable_details: published CPG gains, dimensional cadence and amplitudes, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: use normalized distance to attenuate only the two-joint carrier accelerations toward a nonzero floor while retaining body-frame sector steering and its fixed acceleration priority
falsification: reject if the far trajectory changes, the sub-1L approach is lost, propulsion collapses before capture, saturation or loads worsen, or the head again fails to cross the capture radius

## Pre-evaluation checks

- A deterministic state grid confirms the candidate is exactly equal to the
  completed steering-priority parent for distances at or beyond `2.1L`.
  Inside that boundary, the terminal gate is finite, bounded, invariant to
  lateral reflection, equals full carrier at `2.1L`, and reaches only its
  nonzero `0.55` floor at the `0.75L` capture boundary. All tested actions stay
  inside the unchanged `1800 deg/T^2` command envelope.
- Every direct `params.FIELD` reference resolves to a field returned by
  `target_policy_params()`. The lightweight Julia public-contract check,
  reusable-guidance semantic check, and editable-boundary audit pass. Formal
  CFD remains deferred to EvE after this worker exits.
- The required check-runner was invoked, but its pinned model is unavailable
  for this account. The three commands prescribed by its configuration were
  therefore run directly and separately; all pass.
