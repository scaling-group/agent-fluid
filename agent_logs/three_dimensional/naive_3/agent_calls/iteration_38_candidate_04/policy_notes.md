# One-sided target-ray confirmation candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform initialization with `U_infinity=(0,0,0)`, no cylinders, no prewarm,
  finite dynamics, and capture termination. Three samples exactly reproduce
  the prefilled target-signed adverse-yaw allocator at `16.93205T`, score
  `-0.20004481`, mean distance `2.08513085L`, and crossing distance
  `0.74389035L`. The fourth is the course-agreeing target-ray continuation and
  is the best sampled result at score `-0.19999072`, mean distance
  `2.08508726L`, and crossing distance `0.74383789L`; arrival differs by only
  `0.000008T`.
- I inspected both rows of the combined keyframe sheets for the best sampled
  continuation and the replicated prefill, and also the inherited terminal
  carrier-relief failure. From release through capture, every top-down row
  shows continuous target-directed motion and a coherent alternating red/blue
  wake. The oblique rows retain compact caudal Lambda2 structures through the
  capture sphere. There is no visible held-joint coast, passive advection,
  wake collapse, collision, domain exit, or instability. The metrics agree:
  the sampled fish reaches `1.39123U` while peak local flow is only
  `0.03270U`.
- The course-agreeing target-ray policy leaves the replicated whole-trace
  maxima unchanged (`258.93/259.20 deg/T` joint speeds, `0.59921 rad`
  posterior angle, and `0.03693/0.01835` force/moment), so its small distance
  improvement is a terminal allocation effect rather than stronger drive.
  Its inherited replay changed 86 samples below `2.25L`, never weakened or
  reversed the established course request, and remained inactive over the
  broad route.
- The inherited point-consistent slip carrier-relief sibling is the most
  informative failure. Although its sheet preserves the same visible wake
  and it arrives at `16.92657T`, its bounded symmetric carrier reduction
  regresses to score `-0.20618842`, mean distance `2.09007336L`, and crossing
  distance `0.74984097L`, only `0.000159L` inside capture. Together with the
  earlier symmetric target-ray residual's `-0.20442999/0.74813604L` outcome,
  this rejects treating terminal slip or sightline rate as permission to
  withdraw established rhythmic work.

## Single-candidate policy hypothesis

Materialize the evaluated best sampled continuation as the sole candidate.
Preserve the zero-centered anterior oscillator, lagged posterior carrier,
body-frame velocity-course loop, posterior acceleration reserve, C1 command
envelope, high-onset positive-power speed guards, target-signed adverse-yaw
work allocation, receiver taper, and posterior stopping-risk projection. Add
only its bounded target-ray confirmation: estimate inertial target-ray
rotation from the matched-window difference
`turn_rate_recent - bearing_window_rate`, disable that identity when the
target is no longer clearly forward, and admit a near-target correction only
when its sign agrees with the assembled velocity-course request. An opposing
rate correction is zero, not a reason to relax useful steering.

This is an evidence-backed selection rather than a claim about this worker's
unevaluated CFD. The expected result is reproduction of capture, the coherent
alternating three-dimensional wake, sublimit joint motion, and the small
distance advantage over the prefill. Treat that advantage as fragile because
it is much smaller than a semantic change. Falsify the policy if it cannot
reproduce capture and the broad route, if held-out target geometry activates
the folded-bearing identity, if the residual ever weakens the base course
request, or if score/distance, joint viability, posterior excursion, or the
`0.0370/0.0184` force/moment envelope regress without a new semantic benefit.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and biological terminal approach
source_mechanism: preserve a coupled propulsive rhythm while bounded target-relative feedback updates only compatible directional work
transferable_invariant: slower target-motion feedback may confirm an established rhythmic course request but should not cancel useful steering without separate evidence
nontransferable_details: published gains, dimensional rates, species-specific kinematics, full-body CPG networks, prescribed stages, exact vortex phases, capture radius, and task-specific routes
policy_translation: combine normalized matched-window body turn and body-frame bearing rates into target-ray rotation; apply a bounded distance-, speed-, and forward-target-gated residual only when it agrees with the existing velocity-course signal, leaving carrier and viability layers unchanged
falsification: reject if broad-route equivalence, capture, or alternating three-dimensional shedding is lost; if the residual weakens or reverses the base request; or if distance quality, joint limits, posterior angle, or force/moment loads regress without a new semantic benefit
```

No formal CFD is run in this worker. The resulting candidate is evaluated only
after the worker exits.
