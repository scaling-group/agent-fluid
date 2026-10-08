# Smooth posterior phase-work projection candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics,
  and capture termination at about `16.932T`. The two copies of the
  course-agreeing target-ray parent score `-0.19999072`, with mean distance
  `2.08508726L` and crossing distance `0.74383789L`; the older signed-yaw
  allocator is the sampled regression at
  `-0.20004481/2.08513085L/0.74389035L`.
- I inspected both the top-down vorticity and oblique body/Lambda2 rows for
  the best sampled response-gated policy and the lower-scoring signed-yaw
  reference. Their sheets are visually indistinguishable from release through
  capture: both translate continuously toward the target, retain an
  alternating red/blue street, and shed compact caudal three-dimensional
  structures through the terminal turn. Neither shows passive drift, held
  joints, wake collapse, collision, boundary exit, or instability. The traces
  support self-propulsion: peak fish speed is `1.39123U` while peak sampled
  local flow is only `0.03270U`.
- The assigned prefill is the completed response-gated continuation. Relative
  to the one-sided target-ray parent, it preserves the `16.93206T` arrival and
  whole-trace extrema (`258.93/259.20 deg/T` joint speeds, `0.59921 rad`
  posterior angle, and `0.03693/0.01835` force/moment), while improving score,
  mean distance, and crossing depth narrowly to `-0.19997658`,
  `2.08507586L`, and `0.74382418L`. The inherited replay found 83 active
  target-ray increments, all on posterior positive-work/adverse-moment
  samples; compared with the one-sided parent, the evaluated action trace
  changes only 69 rows below about `1.24L`, with a maximum posterior action
  difference of `0.00701 rad/T^2`.
- This is evidence for phase-compatible work placement, but only a marginal
  distance-quality result. It does not establish broader target-ray authority
  or justify changing the carrier. The current Boolean positive-work selector
  also admits correction at arbitrarily small signed posterior speed. A replay
  of its observation formula over the completed trace finds that two of the
  83 active increments occur below `0.05` of the posterior speed limit, near
  `16.460T/1.380L` and `16.756T/0.970L`. Such near-reversal commands perform
  little instantaneous work and make the phase boundary discontinuous even
  though all mechanical and wake extrema remain healthy.

## Single-candidate policy hypothesis

Preserve the evaluated best policy's zero-centered anterior oscillator,
lagged posterior carrier, full body-frame velocity-course loop, one-sided
target-ray geometry, adverse normalized-yaw response gate, acceleration
reserve, C1 command envelope, high-onset speed guards, signed work transfer,
receiver taper, and stopping-risk projection. Replace only the Boolean
posterior positive-work admission with a C1 joint-state phase/work projection:
the target-ray increment is zero on the wrong half-cycle, rises smoothly from
zero after the posterior reversal, and reaches the inherited full response at
a small parameter-owned fraction of the speed limit. The controller continues
to use no clock or prescribed phase; `phi_dot[2]` and the target-signed
increment define phase and useful-work direction.

This tests whether the completed response-gated benefit survives removal of
near-zero-power switching. Expect an unchanged broad route, capture, coherent
alternating three-dimensional shedding, and unchanged mechanical extrema,
with equal or better distance quality than
`-0.19997658/2.08507586L/0.74382418L`. Falsify the mechanism if it loses
capture, changes any state at
or beyond `2.25L`, materially suppresses the established 83-sample corrective
half-cycle, worsens distance quality without lower effort or safer motion, or
changes the `0.59922/0.03694/0.01836` posterior-angle/force/moment envelope.

```text
bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and asymmetric flapping
source_mechanism: sensor feedback assigns directional work to the compatible half-cycle while retaining a coupled propulsive rhythm
transferable_invariant: corrective work should enter continuously through observed joint phase, vanish on the opposing or zero-power part of the stroke, and leave the established carrier intact
nontransferable_details: published gains, dimensional beat rates, species-specific kinematic envelopes, duty ratios, full-body oscillator networks, prescribed phase clocks, exact vortex phases, capture radius, and task-specific routes
policy_translation: multiply only the bounded target-ray turn increment by a C1 gate formed from posterior velocity projected onto the target-signed work direction and normalized by the policy-owned joint-speed limit; retain the normalized adverse-yaw response gate and all two-joint carrier and viability layers
falsification: reject if broad-route equivalence, capture, sublimit joints, or alternating three-dimensional shedding is lost; if useful inherited corrections are broadly attenuated; or if score, mean/crossing distance, posterior angle, effort, or force/moment loads regress without a compensating semantic or safety gain
```

No formal CFD is run in this worker. The candidate rollout becomes evidence
only after this worker exits.

## Non-CFD gate-overlap check after the edit

Replaying the candidate's observation and phase projection over the completed
response-gated trace leaves 81 of 83 target-ray increments at full phase
authority. It smoothly weights the two low-speed increments by `0.9731` and
`0.7330`, retaining `99.516%` of the parent's total absolute target-ray turn
increment. The interventions remain confined below `2.25L`, and carrier and
safety expressions are unchanged. This confirms a narrow but non-inert
phase-semantic test; it does not evolve the fish or fluid and is not evidence
for the unevaluated candidate's CFD outcome.
