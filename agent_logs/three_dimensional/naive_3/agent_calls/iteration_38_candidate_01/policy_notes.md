# Point-consistent head-course confirmation candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled evaluations satisfy the frozen contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite traces, and capture termination. Three samples exactly
  reproduce the assigned-parent policy and trajectory. That reference captures
  at `16.93205T`, scores `-0.20004481`, has mean distance `2.08513085L`, and
  crosses at `0.74389035L` while keeping joint-speed peaks sublimit at about
  `258.93/259.20 deg/T`.
- I inspected both the top-down and oblique sheets from release through capture
  for the replicated parent and the strongest sampled continuation
  (`solver_7b4db56d77c2`), then compared both visual rows with the inherited
  point-consistent carrier-relief failure. All show continuous target-directed
  translation, a coherent alternating red/blue mid-plane street, and compact
  caudal Lambda2 structures through the capture neighborhood. There is no
  passive drift, held-joint coast, boundary exit, collision, instability, or
  visible wake collapse. The parent trace supports that reading: peak fish
  speed is `1.39123U` while peak sampled local flow is only `0.03270U`.
- The sampled course-agreeing target-ray residual is the strongest finite
  policy, but its gain is deliberately interpreted narrowly. It preserves the
  parent's whole-trace joint and load extrema and captures at the same resolved
  time, while improving score/mean/crossing distance only to
  `-0.19999072/2.08508726L/0.74383789L`. Its inherited replay changed 86 of 222
  terminal samples and never withdrew the base course request. This supports
  one-sided target-relative confirmation, not a general increase in steering.
- The completed contrasts reject two broader terminal interventions. The
  symmetric target-ray residual strengthened the course loop in 86 samples but
  relaxed it in 136 and regressed to
  `-0.20442999/2.08866L/0.74813604L`. Reducing posterior carrier work during
  reconstructed slip regressed further to
  `-0.20618842/2.09007L/0.74984097L`. Their visually indistinguishable wakes
  and unchanged whole-trace mechanical extrema make these terminal work-
  allocation failures rather than propulsion or safety failures.
- The adapter exposes a more point-consistent observation that those tests did
  not use for steering: the one-step body-frame target-vector rate. Combining
  it with the simultaneous body yaw reconstructs instantaneous head velocity,
  so the head position used for target bearing and the translation used for
  course error refer to the same point. A parent-trace replay shows that an
  agreement-projected, `0.03 rad`-bounded residual would change 60 terminal
  samples from `16.031T/1.909L` through `16.905T/0.777L`, with zero broad-route
  changes and a `0.02299 rad` peak. It releases before capture when head-course
  error changes sign instead of continuing to amplify steering from a mixed-
  window sightline-rate estimate. This is a non-CFD overlap check, not an
  outcome claim.

## Single-candidate policy hypothesis

Preserve the replicated parent's zero-centered anterior oscillator, lagged
posterior carrier, full body-frame velocity-course loop, posterior acceleration
reserve, C1 acceleration envelope, phase-local speed guards, one-sided signed-
yaw work allocation, receiver-speed taper, and posterior stopping projection.
Add one bounded terminal feedback mechanism before forming `turn_request`.
Reconstruct head velocity from normalized `target_body_rate_L`, current
`target_body_L`, and `heading_rate`; form a head-course error against the same
head-relative target ray; and admit its correction only when it agrees with the
assembled center-course request. Cap it by both a small owned bound and the base
request. Distance, swimming-speed, and target-ahead gates leave the broad route
and folded-bearing region unchanged.

The mechanism should keep the demonstrated propulsive wake and active yaw
braking while stopping the extra terminal correction once measured head motion
has crossed alignment. Expect capture with better distance quality than the
replicated parent's `-0.20004481/2.08513085L/0.74389035L`, without exceeding
its `0.5993 rad` posterior excursion, `0.0370/0.0184` force/moment envelope, or
sublimit joint speeds. Falsify it if capture or alternating three-dimensional
shedding is lost, any broad-route state changes before the terminal gate, the
residual ever weakens/reverses the base request, score or mean distance
regresses without a new semantic or mechanical benefit, or joint/load bounds
worsen.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and biological terminal approach
source_mechanism: retain the coupled propulsive rhythm while target-relative sensor feedback admits only compatible terminal directional work
transferable_invariant: preserve active propulsion and established course braking, but allocate additional corrective work only while motion measured at the target-referenced head point confirms the same turn direction
nontransferable_details: published gains, dimensional rates, species-specific kinematics, full-body oscillator networks, prescribed approach stages, exact vortex phases, capture radius, and task-specific routes
policy_translation: reconstruct normalized body-frame head velocity from `target_body_rate_L`, `target_body_L`, and `heading_rate`; add a bounded distance-, speed-, and target-ahead-gated head-course residual only when its sign agrees with the inherited velocity-course signal, leaving carrier and safety layers unchanged
falsification: reject if broad-route equivalence, capture, or coherent alternating 3D shedding is lost; if the correction withdraws inherited steering; or if distance quality, joint viability, posterior excursion, force, or yaw moment regress relative to the replicated parent
```

No formal CFD is run in this worker. The candidate's rollout becomes evidence
only after this worker exits.
