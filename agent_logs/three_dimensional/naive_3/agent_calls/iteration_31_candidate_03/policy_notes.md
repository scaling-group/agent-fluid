# Target-behind wave-restart candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase 2 contract: direct
  uniform initialization with `U_infinity=(0,0,0)`, no cylinders or prewarm,
  finite dynamics, and `horizon` termination at `100T`. I inspected both the
  top-down mid-plane-vorticity and oblique body/Lambda2 rows of every combined
  keyframe sheet. Each fish self-propels from rest, retains a coherent curved
  alternating wake and compact three-dimensional structures, and completes
  repeated returns. Passive advection, wake collapse, domain exit, collision,
  and numerical instability do not explain the misses.
- The sampled terminal course hold remains the strongest trajectory at
  `1.241/4.158/2.082L` minimum/mean/final distance. It reaches the tightest
  visible return loop, enters `1.25L` for about `0.47T`, and at its late
  minimum retains an active anterior wave (`phi_dot_1=-0.260 rad/T`) with
  modest commands `(0.747,0.923) rad/T^2`. The sampled descendants all keep
  coherent wakes but lose this return: the anterior equilibrium burst reaches
  `2.125/3.901/3.601L`, the target-behind turn-rate phase residual reaches
  `2.137/3.873/3.530L`, and the assigned parent's rear-centerline direction
  blend reaches `2.366/3.875/3.502L`.
- The assigned parent's hypothesis is therefore falsified by its coupled CFD
  result. Blending instantaneous target side toward target-ray/course sign did
  not contract the terminal orbit; it worsened the minimum by `1.125L` and
  ended `1.420L` farther from the target than the course-hold scaffold while
  preserving the same stable powered-loop class. The turn-rate phase residual
  also closes another posterior-lag response branch. More rear-crossing
  selector logic, yaw-rate lag modulation, response-burst curvature, scalar
  radius adjustment, or authority tuning is not supported.
- A different signal separates the useful scaffold from all three failures.
  Using the course-hold equilibrium and contracted wave envelope to normalize
  the anterior phase-plane radius, median activity inside `3L` is `0.699` for
  the `1.241L` scaffold. The burst, turn-rate phase, and rear-crossing
  descendants have medians `0.011`, `0.004`, and `0.003` and spend about
  `90%`, `86%`, and `92%` of their inside-`3L` samples below `0.15`. At their
  minima both joints are almost stationary near a common negative C-bend;
  local-flow components remain only about `0.03--0.04U`, so a strong external
  crossflow event is not the cause. This supports testing recovery of the
  traveling bend rather than adding another steering equilibrium.

## Policy hypothesis

Return to the sampled terminal-course-hold scaffold and preserve its bearing
curvature, full-direction recovery C-turn, course-response reserve, terminal
course hold, posterior brake, joint-state lag modulation, wave envelope, all
curvature magnitudes, and command reserve. Add one response mechanism: measure
the normalized anterior phase-plane radius about the already commanded
equilibrium and, only when the target is fully behind and the existing
terminal hold is active, apply a bounded course-signed anterior acceleration
while that radius is abnormally small. The nudge releases continuously as the
traveling wave recovers; the posterior joint receives it only through the
unchanged lagged-wave target. This changes neither a static equilibrium nor
the far-field carrier.

Support requires preservation of the ahead-side first recovery plus capture,
a pass below `1.241L`, longer residence inside `1.25L`, or a smaller final
return with comparable command/load residence. Reject if the restart creates
a one-sided bend rather than a traveling wave, changes the first recovery,
raises clamp/load residence, degrades wake coherence, or retains the same
noncapturing orbit. The activity correlation is not causal evidence by itself;
failure to improve would close low-energy wave restart as a remedy on this
course-hold scaffold.

```text
bookshelf_consulted: true
source_domain: traveling-wave propulsion theory and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a posteriorly lagged traveling bend and use measured state to restore rhythmic activity when maneuver bias collapses it toward a static common bend
transferable_invariant: steering must retain a directionally propagating anterior-to-posterior wave; a large mean bend without phase-plane activity is not equivalent to propulsive maneuvering
nontransferable_details: published oscillator gains, dimensional beat frequency, species-specific amplitude envelopes, full-body joint count, exact vortex phase, clocked CPG phase, target coordinates, capture radius, and prescribed routes
policy_translation: normalized anterior angle and velocity about the existing body-frame terminal equilibrium define wave activity; full target-behind geometry and the existing terminal course selector gate one bounded course-signed anterior restart within the two-joint lagged-wave contract
falsification: reject if the ahead-side recovery changes, the nudge produces a static or one-sided bend, phase-plane activity and wake coherence do not recover, command/load margins worsen, or near-target and final-distance statistics do not improve
```

## Evaluation boundary

The candidate's coupled CFD result is unavailable until this worker exits.
Frozen-trace replay and dry checks can establish selector locality, boundedness,
parameter ownership, and reflection equivariance, but cannot establish a
hydrodynamic improvement.

## Implemented candidate and non-CFD probes

The candidate returns to the completed terminal-course-hold scaffold and adds
three owned parameters for one wave-restart mechanism. Its normalized activity
is the phase-plane radius of anterior angle and angular velocity about the
existing equilibrium and wave envelope. The bounded restart is multiplied by
the existing terminal-response weight and squared full target-behind weight;
it changes only anterior acceleration and leaves all equilibria, posterior lag,
wave amplitude, curvature authority, brake, and command bounds unchanged.

Frozen replay over all `18182` completed course-hold states is exactly
unchanged for every target-ahead state, including the `2.466L` first recovery.
Beyond `3L`, mean/maximum absolute action change is only
`0.000004/0.000613 rad/T^2`. Inside `1.5L` it is
`0.306/1.368 rad/T^2`; at the completed scaffold's `1.241L` minimum, the
anterior frozen action changes from `0.970` to `-0.177 rad/T^2` while the
posterior action remains `0.868 rad/T^2`. This establishes a localized and
modest low-activity test, not a coupled-flow prediction.

All direct parameter references are returned by `target_policy_params()`.
Full parent-trace replay is finite and remains inside the declared
`+/-28 rad/T^2` reserve; a mirrored terminal probe negates both actions with
zero observed residual. The required material-guidance comparison, lightweight
Julia contract, parameter-schema guard, and solver editable-boundary check all
pass. The duplicated rendered parent marker in the workspace `README.md` was
removed so the mandated checker could resolve the assigned parent uniquely.
No formal CFD was run.
