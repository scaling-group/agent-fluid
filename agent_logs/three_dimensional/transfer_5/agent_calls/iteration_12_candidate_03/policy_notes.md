# Anterior reaction terminal-yaw damper candidate

## Visual and quantitative diagnosis before editing

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform `U_infinity=(0,0,0)`, no cylinders or prewarm, stable dynamics, and
  capture. In every combined sheet, the top-down row grows a coherent
  alternating wake behind a target-directed swimmer from release onward, and
  the oblique row shows compact three-dimensional Lambda2 structures through
  capture. Motion is self-propelled rather than advection; no collision,
  boundary exit, carrier collapse, or visually distinct terminal topology is
  present.
- The useful comparison is a terminal-control trade rather than a different
  termination class. The v29 posterior half-cycle counter-tangent
  (`solver_4fe7d0162431`) is fastest and has the lowest scoring mean distance
  at `23.7930T`/`2.433953L`, but versus the v24 continuous course brake
  (`solver_8ce1bc88a53c`, `23.8315T`/`2.434073L`) it raises peak yaw from
  `3.208` to `3.289 rad/T`; inside `3L`, mean absolute yaw, target-transverse
  speed, and normalized moment rise from `1.684 rad/T`, `0.239U`, and
  `0.006402` to `1.706 rad/T`, `0.249U`, and `0.006464`. Its final crossing is
  also farther out (`0.747204L` versus `0.746924L`), leaving scalar score
  slightly worse despite earlier arrival.
- Conversely, the v26 whole-bend half-cycle gate
  (`solver_a16245299a15`) lowers peak/inside-`3L` yaw to
  `2.991/1.616 rad/T`, target-transverse speed to `0.220U`, and moment to
  `0.006104`, but delays capture to `23.9085T` and worsens mean distance to
  `2.434609L`. V25 hard direction consensus
  (`solver_3b3fa6c1a86f`) leaves near-target yaw essentially unchanged at
  `1.683 rad/T` and is also later than v24. The visual wake remains coherent
  in all cases, so the sampled differences isolate terminal actuation coupling,
  not propulsion or cue availability.
- The assigned-parent logs provide two additional negative boundaries. V28
  joint-velocity modulation of posterior lag worsened mean/final distance to
  `2.435327L`/`0.748560L` for only a `0.006 rad/T` reduction in inside-`3L`
  yaw, and earlier moment-lead or command-pressure allocation did not jointly
  clean up yaw and progress. The now-evaluated v29 result falsifies its
  tail-tangent correlation as a sufficient actuator-direction model: the
  posterior residual sped the route but increased the yaw quantity it was
  intended to damp.
- A direct trace cross-check identifies a different control locus. Across all
  four sampled rollouts inside `3L`, current anterior acceleration has
  `-0.9098` to `-0.9188` correlation with next-step yaw acceleration, while
  posterior acceleration has only `-0.0370` to `-0.0874` correlation. The
  association is observational rather than causal, but it is consistent across
  the four mechanisms and supports testing the anterior joint without changing
  the evidenced posterior traveling-wave target. Recorded commands remain
  smoothly bounded near `31.4 rad/T^2`, so the new residual must enter before
  the existing projection and remain small relative to that envelope.

## Policy hypothesis

Use evaluated v24 as the sole base. Preserve its state-feedback oscillator,
posterior lag and amplitude, same-sign redirect, response release, continuous
target-course terminal bend, and component-wise smooth command projection.
Add one bounded anterior acceleration residual only inside the existing `3L`
terminal gate. Carrier-rejected body yaw in excess of target-requested yaw
sets its signed magnitude; the residual has the same sign as that excess
because the sampled anterior command is associated with opposite yaw
acceleration. It neither changes the posterior target nor gates away course
curvature, so it tests actuator role separation rather than another route-cue
arbitration or scalar-only carrier tune.

Expect capture and the coherent alternating wake to survive near the v24
arrival and distance integral while peak and inside-`3L` yaw, transverse speed,
and moment move toward the v26 values without its loss of closing progress.
Falsify the mechanism if capture or wake coherence is lost; if arrival exceeds
`23.9T` or mean distance exceeds `2.435L` without material terminal cleanup;
if yaw, cross-track motion, force/moment, joint-speed exposure, or command
exposure worsens; or if the anterior-command/yaw-response sign does not survive
the changed closed loop.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: Lighthill-style reactive swimming and carangiform or robotic-fish steering
source_mechanism: use the anterior joint to sustain and steer the body wave while leaving posterior lag and emphasis to generate propulsive thrust
transferable_invariant: preserve the proven posterior traveling-wave carrier and apply bounded route-scale yaw correction through a distinct anterior control channel
nontransferable_details: published gains, dimensional cadence, full-body envelopes, robot linkage geometry, species-specific kinematics, exact vortex phase, and prescribed routes
policy_translation: normalized body-frame target geometry defines desired yaw; carrier-rejected excess heading rate produces a small signed anterior acceleration residual inside the target-relative terminal gate, with sign calibrated from the sampled action-to-yaw-response association and output passed through the existing smooth projection
falsification: reject if capture or alternating-wake coherence regresses, or if arrival, distance integral, terminal yaw/course, loads, joint-speed exposure, and command exposure do not jointly improve on the v24 and v26 trade boundary
```

## Non-CFD contract checks

- The configured check-runner was invoked, but its pinned model is unavailable
  in this account. Running its commands directly gives PASS for the material
  guidance change and editable solver boundary. The configured `julia` binary
  is absent; the identical lightweight policy probe passes with the provided
  `julia-vanda` wrapper and returns finite two-joint output.
- All `68` direct `params.FIELD` references exist in
  `target_policy_params()`. A `164,025`-state grid spanning terminal/far
  distance, target side, translation, yaw, joint angle, and joint velocity
  produced finite commands no larger than `31.415523 rad/T^2`. Both damping
  signs activate, the maximum sampled change from v24 is
  `3.056011 rad/T^2` inside `3L`, and output is bit-exact to v24 at and outside
  `3L`. Non-finite observation probes also return finite bounded output. No CFD
  rollout was run.
