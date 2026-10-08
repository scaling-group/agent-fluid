# Posterior phase-energy envelope candidate

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, all four sampled policies,
  scores, observations, metrics, diagnostics, and trajectories, and the
  assigned-parent and inherited optimizer notes. Every sampled rollout is a
  finite capture from direct uniform still water with `U_infinity=(0,0,0)`,
  no prewarm, no cylinders, and no boundary or numerical termination.
- I inspected every combined keyframe sheet, including the top-down mid-plane
  vorticity and oblique Lambda2 rows from release through capture. The sampled
  v31 scalar leader and the informative v26 mechanism regression both visibly
  self-propel from rest, follow the same gently curved target-directed route,
  shed a coherent alternating reverse wake, and retain compact three-
  dimensional posterior structures. The v20 and v25 sheets show the same wake
  class. There is no passive advection, standing reciprocal wiggle, wake
  breakup, boundary interaction, or out-of-plane instability.
- V31 has the best sampled score at `-0.0640004` and captures at `18.0125T`,
  but it still spends `66.08%` of the rollout and `75.89%` of the approach at
  the posterior acceleration ceiling. It reaches capture with only `0.1297`
  course alignment, `0.8077 rad/T` absolute yaw, and `0.8732U` target-normal
  speed. Its coherent wake therefore coexists with a tail controller that is
  command-limited for most of the terminal interval.
- The one-sided slip-synchronous v26 mechanism improves final alignment/yaw to
  `0.1728/0.6545 rad/T`, center path/head cross-track to
  `13.2064L/0.7265L`, and near posterior ceiling residence to `74.11%`, but
  regresses score to `-0.0641495`. The inherited centered slip-duty, corrected
  course-consensus, sensory phase-reset, and response-triggered allocation
  variants all retain capture but score only `-0.064212` to `-0.064654` (the
  separately logged balanced-duty realization scores `-0.064451`). Together
  these results reject another terminal slip selector, duty-factor sign or
  gain sweep, phase-reset placement, or mean-bend reallocation as the next
  isolated test.
- On the evaluated v31 trace, posterior phase-plane energy centered on the
  reconstructed commanded mean and normalized by the nominal lagged-wave
  amplitude and actual carrier rate has median/75th/90th percentiles
  `0.315/0.352/0.381`. Only `3.51%` of rows combine energy above `0.36` with
  an acceleration that increases signed posterior rate, and `86.09%` of that
  subset is already at the acceleration ceiling. This separates a sparse,
  high-energy actuator-pressure condition from the chronic shared-cadence gate
  previously shown to delay capture.

## Single policy hypothesis

Start from evaluated v31 and preserve its odd body-frame route controller,
state-feedback anterior oscillator, posterior lag and emphasis, course-duty
surface, v20 approach envelope, conserved anterior mean-bend allocation,
half-cycle steering, and reversal-preserving rate governor. Add one posterior-
only phase-energy envelope after steering is assembled. Normalize posterior
angle about the commanded mean tangent and posterior rate by the nominal
lagged-wave amplitude and observed carrier frequency. Above the trace-
calibrated phase-energy onset, smoothly withdraw only acceleration whose sign
would increase the current posterior joint speed; retain full braking,
reversal, mean bend, carrier cadence, and anterior authority.

The mechanism is state feedback rather than a lower carrier gain: it is
inactive at ordinary posterior phase energy and cannot oppose a reversal.
Expected evidence is v31-class capture, distance closure, route, and coherent
two-view wake with materially lower posterior acceleration-ceiling residence
and no migration to the anterior rate or acceleration limits. Falsify if it
delays capture or worsens the distance integral materially, changes the wake
class, reduces useful posterior propulsion, fails to lower posterior ceiling
residence, transfers pressure anteriorly, or does not preserve reflected joint
commands under a reflected pose and target.

```text
bookshelf_consulted: true
source_domain: coupled-oscillator robotic-fish control and elongated-body reactive propulsion
source_mechanism: regulate rhythmic state energy locally while preserving a posterior-emphasized traveling bend and its reversal
transferable_invariant: preserve cadence and posterior lag, but prevent one joint from receiving additional energy when its observed phase-plane state is already above the useful envelope
nontransferable_details: published oscillator gains, dimensional frequencies, species-specific amplitude envelopes, full-body kinematics, exact vortex phases, world coordinates, capture geometry, and task-specific routes
policy_translation: compute normalized posterior angle about the current mean tangent and normalized posterior rate, then smoothly withdraw only speed-increasing posterior acceleration above a trace-supported energy onset while retaining full braking and all anterior commands
falsification: reject if capture or distance closure regresses materially, coherent wake or posterior propulsion weakens, posterior ceiling residence does not fall, pressure migrates anteriorly, reversal is clipped, or reflected observations do not produce reflected commands
```

## Lightweight validation after editing

- The mandated check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account. Running its immutable checks directly gives
  `PASS` for guidance materiality and `PASS` for the solver editable boundary.
  Julia is not installed, so the executable include/action smoke check could
  not run. No CFD was run.
- Static checks find one definition of each public function, cover all `69`
  direct `params.FIELD` references with the `71` fields returned by
  `target_policy_params`, confirm balanced delimiters and a nonempty candidate,
  and find no explicit elapsed time, step count, randomness, file I/O, cylinder
  coordinate, wake-position, target-coordinate, or memorized-route input.
- Ten thousand algebraic probes of the new envelope preserve command sign and
  magnitude whenever acceleration brakes or reverses posterior rate, never
  amplify a command, and return the exact negated command under simultaneous
  reflection of posterior angle, mean tangent, rate, and acceleration. These
  are contract checks only; the CFD outcome remains evidence for a later
  worker.
