# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- Every sampled rollout and the relevant inherited target-behind rollout use
  direct uniform initialization in still water with `U_infinity=(0,0,0)` and
  no prewarm. The observed displacement and wake are self-generated.
- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  from release through termination for all four sampled policies, comparing
  the strongest sampled response-selected brake (`2.385L`) with the
  response-released S-bend failure (`2.536L`) and the inherited target-behind
  hold (`2.293L`). Every policy sustains an alternating planar wake and compact
  three-dimensional vortices, follows the same down-left approach below the
  target, turns nearly vertical, and remains powered to a lower-boundary exit.
  There is no advection, collision, wake collapse, tight curl, or instability;
  the unresolved defect is terminal trajectory topology.
- The sampled anterior duty-asymmetry candidate reaches only `2.433L`, the
  joint-phase posterior counterbend reaches `2.512L`, and the current prefill's
  response-released posterior S-bend reaches `2.536L`. Along with inherited
  shared and differential course bends (`2.398L` and `2.469L`) and anterior
  half-cycle relief (`2.478L`), this closes further inbound oscillator duty,
  equilibrium, posterior-reallocation, or scalar-brake tuning on the same
  carrier: all retain the powered lower exit.
- The inherited target-behind terminal hold is the clearest new negative
  result. It reaches `2.293L` on its sole first-pass minimum near `17.90T`, but
  its geometrically gated anterior damping never produces a return trajectory;
  the fish exits low earlier at `29.76T` (versus roughly `31.2T` for the best
  sampled brake) with a coherent wake. Its near-target behind condition begins
  near `18.66T` at `2.375L`, leaving substantial room before the boundary, so
  passive wave decay—not detection latency—is the failed mechanism.
- At the inherited hold's minimum the target is still mostly lateral in the
  body frame (full direction error `1.387 rad`), target-ray/course mismatch is
  `1.143 rad`, speed is `0.706U`, and measured yaw is `2.177 rad/T`. The carrier
  therefore has propulsion and a reliable geometric overshoot selector, but
  it needs active reorientation after the target moves behind rather than more
  coasting.

## Policy hypothesis

Start from the strongest sampled response-selected posterior brake and keep
its inbound oscillator, bounded bearing/yaw cruise curvature, posterior lag,
alignment envelope, wrong-way-yaw brake, and command reserve unchanged. Add
one post-overshoot burst-redirect mechanism. When normalized body-frame target
geometry says the target is behind and windowed head distance says the fish is
receding, replace the cruise equilibrium with a bounded target-side C-bend and
temporarily reduce the zero-mean traveling-wave component. Measured recovery
of closure or forward target geometry continuously releases the bend and
restores the unmodified posterior traveling wave; no clock, route, hidden
stage, or world coordinate is used.

This is an active geometry-released reorientation, not another passive hold or
an inbound course-curvature request. Support requires a target-return arc,
capture, a non-boundary termination, or at minimum a materially different
post-overshoot trajectory with retained inbound progress and wake coherence.
It is falsified by persistent command clipping or load growth, a short tight
curl, degraded inbound approach, release without re-approach, or the same
powered lower exit.

```text
bookshelf_consulted: true
source_domain: biological C-start or burst redirect and closed-loop robotic-fish CPG modulation
source_mechanism: large observed directional error invokes a strong bounded body bend while the propulsive rhythm is reduced, then measured geometric recovery releases the bend back into a traveling posterior wave
transferable_invariant: a powered overshoot requires active reorientation separated from cruise propulsion, with onset and release determined by observed target geometry and response
nontransferable_details: published gains, species-specific C-start kinematics, robot geometry, clocked CPG phase, dimensional frequencies, exact vortex phases, fixed burst durations, approach radii, and task-specific routes
policy_translation: normalized target_body_L selects the behind condition and turn side, window_closing_speed_L confirms recession and releases on recovered closure, and the two observed joint states track a bounded same-sign recovery curvature while smoothly attenuating and restoring the lagged traveling wave
falsification: reject if inbound progress or wake coherence degrades, the burst becomes a persistent clipped or tight-curled state, closure never recovers, or the rollout retains the powered lower-boundary exit without a target-return arc
```

## Evaluation boundary

Formal coupled CFD occurs only after this worker exits. Static checks can
establish parameter ownership, finite bounds, reflection symmetry, locality,
and the intended active/release behavior, but cannot establish hydrodynamic
improvement.

## Implemented candidate and non-CFD checks

The candidate implements only the stated geometry-released recovery C-bend
around the strongest sampled response-selected brake. The behind gate uses
normalized longitudinal target geometry, the recession gate uses windowed
closing speed, and normalized lateral geometry selects the bend sign. Recovery
blends the anterior and posterior equilibria toward a same-sign bounded bend,
adds state damping, and attenuates the zero-mean lagged wave; recovered closure
or forward geometry restores the original carrier continuously.

Direct probes give recovery weights `0.000324` on a state reconstructed near
the sampled inbound minimum, `0.980525` for a behind-and-receding target,
`0.000121` after closure recovers, and `0.000357` for a still-ahead but receding
target. The mirrored recovery probe negates both accelerations with zero
floating-point residual, and every action remains finite and within the
configured `28 rad/T^2` reserve.

A static replay on the completed passive-hold trajectory changes candidate
commands by only about `(6e-6,8e-6) rad/T^2` on average before its first-pass
minimum. On that unchanged failed path, the new selector crosses `0.5` at
`18.661T` and deliberately remains active because neither closure nor forward
geometry recovers; roughly `0.428/0.430` of those replayed anterior/posterior
commands reach the configured reserve. This is not a predicted coupled
trajectory: it confirms both that the mechanism is active enough to test and
that failure to release or increased limit/load residence is a sharp
falsification boundary rather than grounds for scalar retuning.

The mandated material-guidance check, exact lightweight Julia policy contract,
deterministic parameter-schema scan (`30` references, `30` declarations), and
solver-boundary audit pass. All `324` repository non-CFD assertions pass.
Formal CFD was not run.
