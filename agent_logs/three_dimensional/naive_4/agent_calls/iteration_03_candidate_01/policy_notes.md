# Candidate visual diagnosis and policy hypothesis

All sampled rollouts and the assigned-parent evidence use direct uniform
still-water initialization with `U_infinity=0`, no cylinders, and no prewarm
snapshot. No same-worker CFD result is available or claimed here.

Both rows of the combined keyframe sheets were inspected for the best sampled
finite rollout (`solver_9391d49799dc`), the assigned parent
(`solver_539c8ffa51bf`), the half-cycle comparator
(`solver_e7d052036feb`), and the inherited shared-curvature failure
(`solver_835ca80b5e55`). The top-down and oblique views of the posterior-only
controllers show a coherent alternating vorticity/Lambda2 wake and clear
self-propelled leftward translation, but the path bends upward and every fish
leaves at `y≈15.20L`. By contrast, putting the mean bend into both joints in
the inherited failure leaves the top-down sheet almost wake-free through `8T`
and the oblique view with little Lambda2 structure before a late tight arc.

The metrics support that visual distinction. Shared curvature reduced the
anterior maximum from the seed's `0.459 rad` to `0.175 rad`, reduced mean force
magnitude from about `0.0077` to `0.0003`, produced only `-0.003L` x progress,
and ended at `13.4114L`; it quenched propulsion rather than steering usefully.
The direct posterior bearing/lookahead controller retained the carrier, moved
`(-1.919,+1.200)L`, and gave the best sampled minimum/final distance,
`11.4131/11.4209L`, but its bearing crossed from about `+0.138 rad` at `4T` to
`-0.255 rad` at `5T` and reached about `-1.245 rad` by `9T`. At that impending
crossing, body-lateral velocity is about `+0.224U` while measured body-frame
relative crossflow is `-0.227U`: the swimmer is already translating toward
and through the target side before geometry alone reverses the posterior bend.
The parent's additional short-history turn-rate loop did not fix this topology;
it worsened minimum/final distance to `11.8584/11.9846L` and retained the same
upper exit. Its `turn_rate_recent` window is only a few solver samples and is
therefore dominated by beat-scale yaw rather than a clean low-frequency turn
response. The half-cycle controller bounded its raw accelerations and retained
the wake, but reached only `11.7778L`, so replacing the best mean-curvature
mechanism is not supported.

## Policy hypothesis recorded before editing

Preserve the naive anterior state-feedback oscillator and posterior traveling-
wave lag. Start from the best sampled posterior bearing/lookahead mapping, but
add one bounded relative-crossflow term to its turn signal. In direct still
water, target-side lateral motion gives opposite-signed relative crossflow, so
this term should release the initial curvature before the bearing sign crosses
and reinforce the posterior reversal after overshoot. Smoothly saturate the
combined signal and keep steering posterior-only, leaving oscillator phase and
the useful alternating wake in joint state.

Falsification: reject the transfer if the alternating 3D wake or leftward
translation collapses, acceleration/rate limiting materially increases, the
bearing still diverges into the same upper-boundary exit, or minimum distance
does not improve on `11.4131L`. A later worker should then test a beat-synchronous
posterior bias with explicit low-pass response evidence, not restore shared
anterior curvature or retune the same short-window yaw-rate residual.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and target-vector/sideslip steering
source_mechanism: sensor feedback modulates bounded mean curvature around an existing propulsive rhythm while transverse relative motion damps directional overshoot
transferable_invariant: preserve the state-encoded traveling bend and let target-side error plus oppositely signed body-frame relative crossflow set a bounded slow turn request
nontransferable_details: published gains, clock-driven CPG phase, species-specific curvature envelopes, exact vortex phases, dimensional velocities, and task-specific routes
policy_translation: retain the anterior oscillator and posterior lag; add bounded normalized relative crossflow to predicted body-frame bearing before commanding posterior-only mean curvature
falsification: reject if wake/thrust collapses, limiting increases, the same upper exit and diverging bearing persist, or closest approach fails to beat the direct bearing controller
