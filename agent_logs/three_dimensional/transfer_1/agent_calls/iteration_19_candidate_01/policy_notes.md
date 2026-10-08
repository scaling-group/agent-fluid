# Geometry-released bearing-divergence candidate

## Rollout evidence and visual diagnosis before editing

- All four sampled evaluations satisfy the Phase-2 contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite dynamics, and `capture` termination.  I inspected both the
  top-down vorticity and oblique body/Lambda2 rows of the combined sheets for
  the strongest geometry-released controller and the assigned parent from
  release through capture.  Both are visibly self-propelled along the same
  smooth target-directed arc, forming compact startup structures and then a
  coherent alternating posterior wake.  Neither shows passive advection,
  wake collapse, collision, domain exit, or instability.  The current sample
  set contains no failed rollout; the inherited wrong-sign whole-wave
  route-rate projection remains the informative failure boundary because it
  preserved an organized wake but turned upward and exited at `8.4755 T`.
- Three behaviorally identical geometry-only bearing-divergence policies
  reproduce capture at `18.403006 T`, score `-0.140449`, total distance
  integral `2.027810 L`, and observed distance integral `1.418099 L`.  The
  prefilled parent adds a target-signed-yaw and positive-closing release to
  that same divergence correction and captures later at `18.414005 T`, score
  `-0.141536`, total integral `2.028719 L`, and observed integral `1.418269 L`.
  The parent is already `0.000798 L` farther away near `16 T`, so the result is
  not solely a deeper terminal sample.
- The response release supplies no compensating physical-envelope advantage:
  geometry-only versus parent mean/max speed is `0.69612/0.94760` versus
  `0.69538/0.94760 L/T`, any-joint acceleration-limit residence is
  `42.14%` versus `42.08%`, and both have identical sampled peak normalized
  force and yaw moment (`0.03068/0.01587`).  The visual sheets likewise show no
  wake-quality benefit.  This is a small but reproduced negative architectural
  result, not evidence for scalar gain tuning.
- The assigned-parent and inherited logs explain the mechanism boundary.  The
  positive bearing-divergence recovery already releases whenever de-gaited
  bearing stops diverging.  Multiplying it by a second response gate can remove
  still-useful route curvature merely because closure and target-signed yaw
  coexist; unlike the earlier large-error redirect, it does not need another
  completion signal.  The catastrophic whole-wave rate projection also warns
  against expanding correlated response rejection without closed-loop sign
  evidence.

## One-candidate policy hypothesis

Remove only the assigned parent's redundant yaw-and-closure release and
restore geometry-only bearing-divergence recovery.  Preserve the state-feedback
traveling wave, posterior lag, raw large-error redirect, mean-preserving
whole-wave pose projection, head-only route-rate correction, raw half-cycle
steering, closing-response cadence release, approach scheduling,
carrier-first head-to-tail rejected-steering allocation, and componentwise
physical bounds.  Outside the de-gaited centerline band, the recovered
curvature remains target-signed and bounded, is active only while
`bearing * bearing_trend > 0`, and fades with normalized approach distance.

The candidate should reproduce capture near `18.403 T`, preserve the coherent
two-view wake, retain the established `0.9476/42.14%/0.03068/0.01587`
speed/saturation/force/moment envelope, and avoid the parent's small late-route
regression.  Falsify the restoration if capture is lost or materially later
than `18.403 T`, observed distance integral exceeds `1.41810 L`, middle/late
closure worsens, the target-directed wake changes qualitatively, or the
physical envelope grows without compensating progress.  Formal CFD occurs
only after this worker exits, so no same-worker outcome is claimed.

```text
bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG control
source_mechanism: retain bounded redirect authority while target geometry worsens and release it when the observed geometric error contracts
transferable_invariant: keep rhythmic propulsion separate and release extra target steering from normalized error response, without stacking unrelated success signals
nontransferable_details: published gains, species-specific C-start kinematics, clocked CPG phase, dimensional cadence, full-body envelopes, exact vortex phase, and prescribed routes
policy_translation: use de-gaited body-frame bearing and bearing trend to activate bounded two-joint curvature only during outward bearing motion, with normalized approach attenuation and no yaw-or-closure multiplier
falsification: reject if capture or middle/late closure regresses, the alternating wake loses coherence, or speed, saturation, normalized force, or yaw moment materially exceeds the sampled envelope
```

## Evidence boundary

Numerical and visual outcome claims above come from completed sampled CFD, the
assigned parent, and inherited optimizer logs.  The candidate's new evaluation
will become evidence only for a later worker.

## No-CFD implementation audit

- Source comparison confirms the executable policy is identical to the
  reproduced geometry-only v34 controller; differences are limited to the
  version/provenance comments and version string.
- The lightweight Julia contract check returns two finite accelerations, and
  the deterministic schema audit finds all `59` directly referenced parameter
  names among the `61` fields returned by `target_policy_params()`.
- The solver boundary check passes with only
  `cases/dogfish_3d_shape_policy/candidate_target_policy.jl` changed relative
  to the frozen solver baseline.  No CFD was run.
