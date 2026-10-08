# Terminal bearing-rate damping candidate

## Evidence-led diagnosis recorded before the policy edit

- All sampled and inherited evaluations use direct uniform initialization in
  still water with `U_infinity=(0,0,0)` and no prewarm. Three sampled policies
  are byte-identical copies of the assigned prefill and reproduce the same
  capture at `16.93205T`, score `-0.20004481`, mean distance `2.08513L`, and
  final distance `0.74389L`. This replication is evidence to preserve the
  complete carrier, velocity-course steering, soft acceleration envelope,
  phase-local speed guards, directional work allocation, and stopping-risk
  projection.
- I inspected the combined keyframe sheets for that replicated parent, the
  weaker bidirectionally arbitrated sample, and the inherited capture-corridor
  rollout from release through capture. In every top-down row the fish advances
  continuously behind a coherent alternating red/blue street. Every oblique
  row shows compact three-dimensional Lambda2 structures shed from the caudal
  region through the target crossing. There is no visual sign of passive
  advection, held-joint coasting, wake collapse, collision, or boundary exit;
  the parent trace agrees with `1.391U` peak body speed versus only `0.0327U`
  peak local flow.
- The sampled symmetric adverse-yaw allocator preserves capture and arrives
  `0.00587T` earlier, but regresses to score `-0.20096611`, mean distance
  `2.08585L`, and final distance `0.74483L`, without reducing the
  `0.59922 rad` posterior excursion. The evidence therefore supports the
  inherited actuator-specific signed allocation rather than another mirrored
  load selector.
- The assigned parent's later capture-corridor steering release is the most
  informative failure. It activates only inside `1.979L` on a measured closing
  intercept, yet score worsens to `-0.20433673`, mean distance to `2.08858L`,
  and crossing distance to `0.74805L`. Arrival changes only from `16.93205T`
  to `16.92585T`, while the terminal yaw-rate peak slightly increases from
  `4.4430` to `4.4452 rad/T`; the whole-trace wake, speed, joint, and load peaks
  remain effectively unchanged. A predicted capture corridor is thus not
  evidence that established steering can be withdrawn.
- The replicated parent still has a separable terminal defect. Below `2L`,
  instantaneous yaw ranges from `-4.443` to `+3.643 rad/T`, and the body-frame
  target bearing moves opposite the saturated velocity-course request during
  about 85% of recorded samples. A seven-state windowed bearing-rate residual
  can distinguish an observed angular response from a merely predicted
  intercept. Projected over the recorded states, a bounded 20% residual would
  oppose rather than amplify the base request in 155 of the final 183 samples,
  starting at `15.932T`; it has zero overlap with the broad route.

## Single-candidate policy hypothesis

Preserve the demonstrated controller verbatim outside the terminal steering
observation. Inside a smooth `2L` approach gate, add a bounded derivative
residual from normalized body-frame `bearing_window_rate` only when that
residual opposes the current target-course request. Apply it to posterior mean
steering before the existing acceleration allocator, while leaving the
zero-centered anterior oscillator, lagged posterior carrier, target-intent
signal used by signed work allocation, and every mechanical guard unchanged.
This is response-conditioned yaw/slip damping: it cannot activate from a zero
target-course request or reinforce that request's direction, though it may
reverse a small nonzero request into bounded braking; it cannot suppress
propulsion.

Expect the broad trajectory and both coherent wake views to remain unchanged,
with capture retained and terminal yaw reduced relative to `4.443 rad/T`.
Seek score/mean-distance improvement over `-0.200045/2.08513L` without arrival
later than `16.932T`, posterior excursion above `0.5993 rad`, speed contact, or
force/yaw-moment peaks above `0.0370/0.0184`. Falsify the mechanism if it loses
capture, repeats the corridor release's worse crossing, changes the broad
route, removes alternating shedding, increases load or limit use, or does not
reduce the terminal angular oscillation.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and biological terminal approach control
source_mechanism: preserve the propulsive rhythm while a bounded measured-response residual damps near-target yaw and slip
transferable_invariant: corrective authority should oppose an observed angular approach response without withdrawing the base target command or the traveling propulsive wave
nontransferable_details: published gains, dimensional rates and beat frequencies, species-specific kinematics, prescribed approach stages, exact vortex phases, capture radius, and task-specific routes
policy_translation: inside a normalized body-frame distance gate, use bounded windowed target-bearing rate only when it opposes the current course request; apply the residual to posterior mean steering and retain both joint-state carrier dynamics and all safety projections
falsification: reject if capture or broad-route equivalence is lost, if alternating 3D shedding degrades, if terminal yaw is not reduced, or if arrival, mean/final distance, joint use, force, or yaw moment regress beyond the replicated parent
```

No formal CFD is run in this worker. The candidate's rollout becomes evidence
only after this worker exits.

## Non-CFD gate-overlap check after the edit

Reconstructing the moving-window adapter's seven-state bearing window over the
3,079 recorded parent states gives 155 nonzero residuals, all between
`15.932T` and capture and all below `1.998L`. Every residual opposes the base
course request by construction. Two states cross zero; only one turns a
near-zero `0.0056` request into a larger opposite braking request, bounded at
`0.0857`. The mean absolute turn-request change is `0.1303` and its maximum is
`0.1928`, below the declared `0.20` authority bound. This confirms that the
candidate is neither inert nor a broad-route edit. The projection does not
evolve the body or fluid and is not evidence that yaw, capture, loads, or
score will improve.
