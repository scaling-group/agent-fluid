# Carrier-demodulated fluid-response replication candidate

## Evidence and visual diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  dynamics, and capture. The sampled set contains no termination failure, so
  the informative visual comparison is the best-score helpful-moment sample
  against the weakest-score phase-demodulated sample, supplemented by the
  identical-hash actuator-consistent repeat in the assigned-parent logs.
- In both combined sheets, the top-down row shows self-propelled progress and
  a coherent alternating reverse-vortex street forming behind the caudal
  region; the oblique row shows bounded three-dimensional Lambda2 loops that
  follow the swimmer. Both candidates turn smoothly onto the target and
  capture without collision, wake collapse, a route loop, or instability.
  Their wake and trajectory topology is indistinguishable at keyframe
  resolution, so arrival, actuator occupancy, and load histories decide the
  mechanism test.
- The exact actuator-consistent parent hash captures at `18.6725T` in the
  sampled set and `18.7385T` in the assigned-parent inherited log. Across
  those repeats, posterior action RMS is `28.781--28.847 rad/T^2`, posterior
  limit occupancy is `75.58--76.11%`, force RMS is
  `0.013270--0.013499`, moment RMS is `0.006908--0.007028`, and local-flow
  RMS is `0.018064--0.018088U`.
- The sampled phase-demodulated moment-residual policy captures at `18.7165T`,
  inside that repeat band, while reducing posterior action RMS to `28.558`,
  posterior limit occupancy to `74.14%`, force RMS to `0.013093`, and moment
  RMS to `0.006816`; local-flow RMS remains `0.018150U`. Its mean distance
  `2.02337L` also remains inside the exact-parent range
  `2.02129--2.02478L`. In contrast, raw helpful-moment amplitude relief and
  stress-gated raw-moment relief retain `75.74%` and `75.44%` posterior
  occupancy with higher load RMS. Carrier demodulation, rather than raw-moment
  selection, is therefore the only sampled moment path with a material load
  and clipping separation while preserving semantic success.

## Policy hypothesis recorded before editing

Replace the prefilled raw helpful-moment amplitude release with an exact
replication of the sampled phase-demodulated residual controller. Preserve
the normalized LOS route, recoil-conditioned yaw response,
response-reversing half-cycle authority, traveling-bend carrier, and
persistent same-side actuator gate. Estimate the carrier-correlated yaw
moment from observed two-joint phase, subtract it from normalized measured
moment, and use only the bounded reflection-equivariant residual to modulate
posterior phase recruitment. Repeating the exact controller is the clean test
of whether its lower load and occupancy survive rollout variability; no
second mechanism or scalar-only carrier tuning is added.

Support requires capture with coherent wake views, arrival inside the
inherited `18.67--19.01T` actuator-consistent band, posterior limit occupancy
near or below `74.5%`, and force/moment RMS near or below
`0.01320/0.00685`. Falsify the apparent load benefit if occupancy returns to
the parent `75.58--76.11%` band or loads return to
`0.01327--0.01350/0.00691--0.00703`; falsify the architecture more strongly
if capture is lost, arrival exceeds `19.052T`, or either wake view loses
coherence.

bookshelf_consulted: true
source_domain: Closed-loop robotic-fish rhythmic control and wake-adaptive swimming.
source_mechanism: Preserve a low-dimensional propulsive rhythm while sensor feedback supplies only a bounded residual modulation rather than replacing the carrier.
transferable_invariant: Separate carrier-correlated fluid response from the residual and let only the residual adjust authority according to whether it helps or opposes the body-frame route correction.
nontransferable_details: Published gains, dimensional frequencies, species and robot kinematics, recurrent-network memory, exact vortex phase, organized-cylinder-wake timing, and task-specific routes.
policy_translation: Subtract a reflection-odd two-joint phase estimate from normalized body-frame yaw moment, then use the bounded residual alignment only to modulate stress-confirmed posterior phase recruitment.
falsification: Reject the transfer if replicated load and occupancy return to the parent band, capture timing degrades beyond the replicated success band, or coherent top-down or oblique wake structure is lost.

The present candidate's CFD outcome is not claimed here; it becomes evidence
for a later worker after evaluation.
