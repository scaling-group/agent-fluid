# Closing-response plus bidirectional-allocation candidate

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the frozen contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite dynamics, and semantic `capture`.  The assigned-parent v31
  carrier-centered half-cycle controller captures at `19.03549 T`, score
  `-0.20185`, and distance integral `2.08993 L`.  Its phase-centering edit is
  a completed negative result relative to v30 (`18.99699 T`, `-0.18597`,
  `2.07455 L`), so this candidate restores the raw observed tail tangent for
  half-cycle classification.
- I inspected the combined top-down vorticity and oblique body/Lambda2 rows
  for the strongest v32 closing-response rollout, the assigned parent, the
  v32 reverse-allocation rollout, and the inherited whole-wave-rate failure.
  Each successful sheet shows self-propulsion from quiescent water along one
  smooth target-signed arc: compact startup structures become a coherent
  alternating posterior wake in both views, with no collision, passive
  advection, or instability precursor.  The closing-response fish is visibly
  farther along the same arc at the middle and late frames and captures at
  `18.754995 T`.
- The whole-wave-rate failure is the semantic boundary.  Its top-down row
  turns upward and then almost vertically away from the target, while its
  oblique row still shows organized three-dimensional propulsion.  It exits
  the upper boundary at `8.47550 T`, reaches only `12.21067 L`, ends at
  `12.72963 L`, and raises peak normalized planar force/yaw moment to
  `0.30254/0.13474`.  A frozen-trajectory rate correlation is therefore not
  causal evidence for route projection; this candidate preserves the proven
  head-only rate correction.
- Outcome-gated carrier release is the strongest current mechanism.  Relative
  to v30, it improves capture by `0.2420 T`, score by `0.01482`, integral by
  `0.01569 L`, and distance at `8/12/16 T` by `0.0260/0.1378/0.2394 L`.
  It also lowers any-joint acceleration-limit residence from `43.43%` to
  `41.97%`.  Mean/max speed rise from `0.676/0.927` to `0.686/0.949 L/T`,
  with peak normalized force unchanged at `0.03068` and moment slightly
  higher at `0.01565`; those are falsification bounds, not evidence for more
  cadence or amplitude.
- Reverse recovery of posterior-rejected target steering independently
  improves v30 without changing its posterior output: capture becomes
  `18.87049 T`, score `-0.18102`, and integral `2.06891 L`.  Its any-joint
  limit residence is `43.17%`, and its `0.948 L/T`, `0.03068`, and `0.01541`
  speed/force/moment peaks remain near the sampled envelope.  The two positive
  mechanisms act at different interfaces—one schedules carrier cadence from
  observed closure, while the other reallocates only steering discarded by a
  componentwise bound—so their combination is a small mechanism-level test,
  not scalar-only gain tuning.

## One-candidate policy hypothesis

Use the strongest evaluated v32 closing-response controller as the base,
including its state-feedback traveling wave, posterior lag, raw-geometry
completion-gated redirect, whole-wave pose projection, raw half-cycle phase,
approach scheduling, head-to-tail rejected-steering spillover, and hard
componentwise acceleration bounds.  Add the independently positive reverse
allocation path: after composing the posterior carrier with target steering
and anterior spillover, measure only the signed target residual rejected by
the posterior projection and return half of that residual to available
anterior headroom.  Never transfer carrier demand and never enlarge either
joint bound.

The expected result is to retain the closing-response policy's coherent wake
and route lead while recovering posterior-clipped steering during its slightly
faster productive arc, improving or preserving middle/late closure and capture
without the derivative failure's wrong-sign turn.  Falsify the combination if
capture is lost or later than `18.754995 T`, distance integral exceeds
`2.05886 L`, the `8-16 T` lead regresses materially, the target-signed arc or
alternating wake changes qualitatively, or maximum speed, any-joint limit
residence, peak normalized force, or yaw moment materially exceed
`0.9492/41.97%/0.03068/0.01565` without compensating progress.

```text
bookshelf_consulted: true
source_domain: biological burst redirection and sensor-modulated robotic-fish CPG control with asymmetric two-joint turning
source_mechanism: renew posterior propulsion only after observed target response confirms productive motion, while distributing bounded target steering across available joint authority without moving the rhythmic carrier
transferable_invariant: keep the traveling-wave carrier separate from target steering; gate withheld propulsion by normalized closure and reallocate only signed steering that a joint bound would otherwise discard
nontransferable_details: published gains, burst timing, duty ratios, clocked CPG phase, robot linkage geometry, species-specific kinematics, dimensional cadence, exact vortex phase, and prescribed routes
policy_translation: retain positive windowed closing speed as the gate that releases turn-induced cadence relief, then recover only posterior-rejected target residual into anterior headroom under the existing normalized body-frame two-joint state-feedback contract
falsification: reject if the combined paths lose or delay capture, regress middle or late closure, reverse the target-signed arc, disrupt the coherent wake, or materially increase saturation, speed, normalized force, or yaw moment without compensating progress
```

## Evidence boundary

All outcome claims above come from completed sampled CFD, the assigned parent,
and inherited optimizer logs.  This combined candidate receives formal CFD
only after worker exit; no same-worker improvement is claimed.

## No-CFD implementation audit

- A deterministic `121500`-state grid spanning target angles and distances,
  bearing trends, positive and negative closure, and joint phase found finite
  commands within the physical acceleration envelope throughout.  Setting
  the new reverse-allocation gain to zero makes every command identical to the
  evaluated closing-response baseline.
- With reverse allocation active, `29503` synthetic states change the anterior
  command by at most `3.50533 rad/T^2`; the posterior output remains identical
  to the baseline in every state, and every anterior change occurs only when
  the baseline posterior command is at its acceleration bound.  This verifies
  mechanism placement and isolation, not closed-loop performance.
