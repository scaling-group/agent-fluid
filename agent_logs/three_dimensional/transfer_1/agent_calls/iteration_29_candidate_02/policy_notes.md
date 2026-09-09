# Candidate diagnosis and hypothesis

## Evidence read before policy edit

- All four sampled evaluations satisfy the experiment contract: direct uniform
  initialization at `U_infinity=(0,0,0)`, no prewarm, no cylinders, stable
  dynamics, and `capture` termination. Their combined sheets show self-propelled
  motion rather than advection: the fish advances while laying down a coherent
  alternating top-down vorticity street and bilateral oblique Lambda2 structures
  from release through the capture frame. There is no visible terminal carrier
  collapse or collision in the samples.
- The repeat-backed intercept-guarded speed-reserve scaffold captures in both
  current samples: `solver_6b0e320e2f55` reaches `0.74939L` at `18.6010T`
  (best sampled score `-0.15140`, mean distance `2.03873L`) and
  `solver_6f904f98394f` reaches `0.74846L` at `18.2875T`. Peak speed is
  `0.922--0.923L/T`; head/tail action clamps on about `68.5%/70.6%` of rows,
  and both joints touch the speed limit. The two final sheets approach the
  target from different beat phases/sides while retaining the same wake class,
  so terminal phase variability remains important even when both runs capture.
- The posterior wave-shape sample (`solver_591f46d260e7`) also preserves both
  wake views and captures at `0.74797L` and `18.1995T`, but its score, distance,
  clamp, speed-limit, force, and moment measures remain within rather than
  improve the baseline envelope. Inherited guidance records its later exact
  miss, so it is not a repeat-robust repair.
- The prefilled fixed anterior-transfer policy (`solver_55f3a103ab95`) captures
  at `0.74923L`, but arrives later at `18.7495T`; its `68.76%/70.75%` clamp
  fractions and `10.74%/11.62%` speed-limit residence do not improve the two
  sampled baseline captures. Its top-down and oblique wakes remain coherent,
  which supports narrowing the allocation change rather than changing the
  carrier. The assigned-parent logs also contain recent `left_domain` outcomes
  with `1.37249L` and `1.93852L` closest passes. Together with inherited
  full-band veto, half-cycle allocation, observer, and yaw-brake failures,
  these results reject another route/release scalar adjustment.
- A recorded-trace proxy gives the fixed unsafe-intercept transfer meaningful
  authority on about `12.3%` of the prefilled capture rows. Conditioning it on
  normalized tail-over-head actuator burden and anterior margin makes it
  meaningfully narrower: the proposed gate exceeds `0.01` on about `3.8%` of
  that trace and `2.0--3.3%` of the other sampled traces. This is only a
  mechanism-activation check, not a same-worker CFD claim.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: Lighthill elongated-body propulsion and robotic-fish bounded mean-curvature turning
source_mechanism: preserve thrust-critical posterior traveling-wave kinematics while allocating target-directed curvature to an actuator with usable reserve
transferable_invariant: move steering authority upstream only when normalized state shows that the posterior joint is more burdened and the anterior joint has margin; preserve total steering share and the traveling carrier
nontransferable_details: published gains, dimensional cadence, species envelopes, clock-driven CPG phase, exact vortex phase, and task-specific routes
policy_translation: retain the achieved-course, intercept-release, carrier, and reserve modules; replace the fixed unsafe-terminal share transfer with a smooth gate built from each joint's speed ratio and previous-action ratio, posterior-minus-anterior burden, and anterior margin
falsification: reject if exact repeats miss or keep the lower-pass topology, if the conditional gate is behaviorally inert, or if capture time, wake coherence, terminal speed, clipping, speed-limit residence, force, or yaw moment leaves the sampled speed-reserve envelope

## Candidate hypothesis

Test one mechanism: burden-conditioned spatial steering allocation. Inside the
existing unsafe terminal-intercept region, blend normalized joint-speed and
previous-action ratios into per-joint burdens. Transfer at most the parent's
`0.55` steering-share amount from tail to head only when tail burden exceeds
head burden and head margin is available. Outside that conjunction the policy
returns continuously to the evaluated share allocation. The head-plus-tail
steering share remains invariant, carrier accelerations are unchanged, and no
new route, clock, fixed coordinate, flow phase, or scalar-only gain change is
introduced.
