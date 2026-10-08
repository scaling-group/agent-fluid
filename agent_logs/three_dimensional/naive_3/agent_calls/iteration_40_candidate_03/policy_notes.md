# Multiplicative dual-response target-ray candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled solvers satisfy the frozen experiment contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and capture termination. The two
  moment-only response samples reproduce each other at score `-0.19997658`,
  mean distance `2.08507586L`, final distance `0.74382418L`, and
  `16.93206T`. The prefilled minimum-composed yaw/force response gate changes
  only terminal behavior and improves those distance measures by less than
  `0.000002L`.
- The strongest current sample is the multiplicative yaw/force consensus
  policy. It retains capture at `16.93205T` and improves score, mean distance,
  and crossing distance to `-0.19994654`, `2.08505160L`, and `0.74379522L`.
  This is a small terminal allocation advantage, not a new trajectory or
  termination class.
- I inspected both rows of its combined keyframe sheet and both view-specific
  sheets, then compared them with both views of the inherited symmetric
  target-ray-rate failure. From release through capture, both top-down sheets
  show continuous target-directed translation and a coherent alternating
  red/blue street. Both oblique sheets retain compact caudal three-dimensional
  Lambda2 structures through the capture sphere. There is no held-joint
  coast, passive advection, wake collapse, collision, boundary exit, or
  numerical instability.
- The diagnostics support that visual reading. The sampled multiplicative,
  minimum-composed, and moment-only policies all retain `1.39123U` peak fish
  speed against only `0.03270U` peak local flow; their maxima are identical at
  `0.46984/0.59921 rad` joint angle, `258.93/259.20 deg/T` joint speed,
  `31.1018/29.8451 rad/T^2` command, and `0.018355` normalized yaw moment.
  The multiplicative sample slightly lowers the largest body-force component
  to `0.030210` from the prefill's `0.030256`.
- The inherited symmetric target-ray-rate residual is the informative
  allocation failure. It has the same visible wake and the same joint, speed,
  action, and peak-flow extrema, but regresses to score `-0.204430`, mean
  distance `2.08866L`, and crossing distance `0.74814L`. Together with the
  inherited carrier-relief failure, it shows that sightline or response
  feedback must not withdraw the established velocity-course loop merely to
  change the terminal intercept.

## Single-candidate policy hypothesis

Materialize the completed best sampled policy as the sole candidate. Preserve
the zero-centered anterior oscillator, lagged posterior traveling carrier,
full body-frame velocity-course loop, one-sided point-consistent target-ray
correction, posterior positive-work phase gate, posterior acceleration
reserve, smooth acceleration envelope, high-onset speed guards, signed work
reallocation, receiver taper, and posterior stopping-risk projection. Change
only the prefilled response composition: use smooth multiplicative consensus
between adverse normalized yaw moment and adverse body-lateral force, with the
evaluated force scale owned by `target_policy_params`. The target-ray residual
therefore remains a bounded terminal confirmation that fades when either
response axis gives weak evidence for additional corrective work; it never
weakens the base course request or changes carrier phase.

The expected result is reproduction of the sampled broad route, capture,
coherent alternating three-dimensional wake, sublimit joints, and its small
distance advantage over the prefill. Because the improvement is much smaller
than a semantic change and has one completed sample, treat it as a checkpoint,
not a general claim that adding response axes always helps. Falsify the
candidate if it cannot reproduce capture and the sampled terminal ordering,
changes states outside `2.25L`, loses the alternating wake, touches a joint
limit, exceeds `0.5993 rad` posterior excursion or the sampled
`0.0303/0.0184` force-component/yaw-moment envelope, or regresses distance
quality without a compensating mechanical benefit.

```text
bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and asymmetric flapping
source_mechanism: preserve a coupled propulsive rhythm while sensor feedback schedules bounded target-compatible work on a useful joint-state half-cycle
transferable_invariant: retain the traveling carrier and admit a corrective residual only when target geometry, joint-state work phase, and normalized body response agree that more turning work is useful
nontransferable_details: published gains, dimensional beat rates, species-specific kinematics and envelopes, duty ratios, full-body oscillator networks, exact vortex phases, capture radius, and task-specific routes
policy_translation: retain the bounded body-frame target-ray increment and posterior positive-work gate; combine adverse normalized yaw moment and body-lateral force as a smooth multiplicative consensus before the existing two-joint allocation and viability layers
falsification: reject if broad-route equivalence, capture, sublimit joints, or alternating three-dimensional shedding is lost; or if the sampled score, distance quality, posterior angle, force, or yaw-moment envelope regresses without a new semantic benefit
```

No formal CFD is run in this worker. The candidate rollout becomes evidence
only after this worker exits.
