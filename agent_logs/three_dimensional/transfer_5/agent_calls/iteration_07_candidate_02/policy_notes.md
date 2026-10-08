# Wake-policy diagnosis and hypothesis

## Evidence read before editing

- All four sampled evaluations are valid direct-uniform still-water rollouts
  with `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and capture.
  There is no semantic failure in the current sample. The strongest score is
  the phase-demodulated course brake at `-0.535794` (`23.8315T`, mean distance
  `2.434073L`); the weakest relative result is the approach allocator at
  `-0.536784` (`23.9250T`, `2.435081L`). The assigned prefill course-residual
  parent is close to the strongest result at `-0.535986`, `23.8810T`, and
  `2.434313L`, while retaining lower peak yaw and heave load than the strongest
  result (`2.975` versus `3.208 rad/T`, `4.349` versus `5.277`).
- In both required visual rows, the strongest and weakest sheets show
  self-propelled motion along the same broad target-directed arc. A compact
  alternating top-down vortex street appears by `4T` and remains coherent to
  capture; the oblique Lambda2 views show corresponding three-dimensional
  paired structures attached to the posterior body. No sampled sheet shows
  advection, wake breakup, or a boundary encounter. The inherited upper/lower
  exits from carrier replacement therefore remain the failure-topology
  boundary, not a reason to replace the current traveling wave.
- The unresolved limitation is actuator-state interaction. In the assigned
  parent, anterior/posterior joint speed is at least 95% of the `260 deg/T`
  limit for `19.71%/9.19%` of all samples, while command magnitude is at least
  95% of the acceleration scale for `55.20%/38.90%`. Even above 85% joint
  speed, outward acceleration is still requested for `17.80%/10.64%` of the
  rollout. Inside `2.1L`, posterior acceleration exposure remains `44.17%` and
  outward requests above 85% speed remain `12.22%`. The other sampled
  mechanisms preserve the same qualitative pattern; the approach allocator
  reduces command exposure but delays capture and leaves speed exposure.
- Inherited logs sharpen two negative boundaries. Whole-oscillator raw-yaw
  relief alone did not reduce peak yaw or posterior speed exposure and raised
  peak heave load, while isolating course residual from that relief regressed
  score to `-0.537330` and mean distance to `2.435365L`. Conversely, the
  phase-compensated counter-bend improved arrival but raised yaw, lateral load,
  and speed exposure. These results argue for preserving the assigned parent
  composition and addressing velocity headroom directly rather than adding
  another terminal course/yaw estimator or scalar cadence edit.

## Policy hypothesis

Retain the assigned parent's body-frame target-course residual, response-
released same-sign C-bend, joint-state traveling-wave lag, terminal amplitude
relief, half-cycle steering, and smooth acceleration projection. Add one
continuous actuator-state mechanism after carrier and steering composition:
normalize each observed joint speed by a policy-owned speed scale, smoothly
activate near the physical envelope, remove only acceleration that would push
farther outward, and add a bounded inward braking residual. Below the onset,
the evaluated policy is algebraically unchanged; near the envelope, target and
carrier commands retain their sign and allocation whenever they decelerate the
joint. This should reduce persistent speed clipping and command/load peaks
without globally weakening the coherent propulsive rhythm.

Falsification: reject the mechanism if capture is lost, arrival or mean
distance materially regresses from `23.8810T`/`2.434313L`, either visual row
loses its coherent alternating wake, joint-speed exposure does not fall, or
yaw, command effort, lateral/yaw-moment load, or heave load worsens without a
compensating semantic improvement. The speed scale is the controller's
normalized actuator-state reference, not a new episode limit.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and bounded two-joint actuator control
source_mechanism: sensory state feedback preserves a rhythmic carrier while yielding positive work near the actuator velocity envelope
transferable_invariant: preserve the target-steered traveling wave and reduce only carrier-plus-steering effort that drives an already fast joint farther outward
nontransferable_details: published CPG gains, robot motor constants, species-specific envelopes, dimensional cadence, exact vortex phases, and task-specific routes
policy_translation: keep normalized body-frame target feedback intact; use each joint's observed speed divided by a policy-owned speed scale to smoothly suppress outward acceleration and add bounded inward damping before the existing command projection
falsification: loss or delay of capture, unchanged speed exposure, degraded alternating wake, or worse yaw, effort, and load histories invalidates the transfer
```

## Worker-side verification boundary

- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable for this account. Its guidance-semantic and editable-
  boundary commands were therefore run directly and pass. No CFD was run.
- The direct schema audit finds `73` returned parameter fields, `71` distinct
  direct `params.FIELD` references, no missing fields, exactly one
  `target_policy_params` definition, and exactly one `target_policy`
  definition. The Julia include check cannot run because this workspace has no
  Julia executable or Python Julia bridge.
- Static replay of the new final-command algebra on the assigned parent's
  recorded state/action trace is exactly unchanged below `0.90` normalized
  joint speed. The headroom gate is nonzero on `24.67%/13.86%` of anterior/
  posterior samples and above half load on `19.71%/9.19%`; mean absolute
  projected command changes from `25.804/23.385` to `24.152/22.624 rad/T^2`
  on those fixed states. Synthetic probes confirm continuous onset, finite
  bounded projection, and sign reversal under mirrored command/velocity.
  These checks establish scale, symmetry, and contract structure only; they do
  not predict the pending coupled fluid rollout.
