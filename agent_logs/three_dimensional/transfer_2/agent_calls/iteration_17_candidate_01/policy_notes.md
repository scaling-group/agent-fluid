# Response-gated posterior-amplitude candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no prewarm or cylinders, finite
  moving-window transport, stable dynamics, and `capture` termination in
  `19.360--19.552T`.
- I inspected both rows of the combined sheets for the strongest finite sample
  (`solver_1af6c62469a7`), the slowest posterior-lag replication
  (`solver_1fb0a88ab950`), and the posterior-amplitude sample
  (`solver_31e8ebbf5bdb`). The top-down rows show self-propulsion from rest and
  coherent alternating vortex streets; the oblique rows show compact 3D tail
  structures without passive advection, collision, wake collapse, or
  instability. The lag replication is therefore an informative within-class
  mechanism failure, not a semantic failure. The amplitude run keeps a
  coherent wake but follows a more strongly hooked terminal path.
- The prefilled response-gated posterior-curvature parent is best at
  `19.360T`, mean distance `2.08911L`, and score `-0.19989`. Its lead over the
  clean posterior-lag samples at `19.409--19.508T` and
  `2.09210--2.09701L` is smaller than the inherited `0.226T` exact-policy
  repeat span, so the scalar result alone is not a proved gain. Its state
  signature is nevertheless different: yaw rate at `1L`/capture is
  `0.142/0.073 rad/T`, versus `0.287/0.142` and `0.334/0.169 rad/T` for the
  two clean lag samples, while final course error falls to `0.278 rad` from
  `0.350--0.404 rad`. This supports preserving the response-disagreement bend
  as a semantic yaw-residual improvement.
- That parent pays for the residual reduction: anterior mean absolute command
  is `19.25 rad/T^2` with `37.07%` residence above 90% of the smooth bound,
  versus `18.70--19.03` and `36.54--36.92%` for the clean lag samples. The
  amplitude sample offers a complementary signature: anterior mean command
  `18.09`, near-bound residence `35.13%`, and final course error `0.137 rad`,
  but capture is slower at `19.552T`, final yaw remains `0.513 rad/T`, and
  peak planar force/yaw moment rise to `0.02535/0.01343`. It is unsupported as
  a standalone replacement, but its phase-conditioned posterior allocation is
  a bounded actuator mechanism to test under the parent's response gate.
- Inherited logs rule out another unsigned lag compression, raw slip-curvature
  residual, redirect release, course-distance window, or previous-command
  feasibility gate: each preserved the same hook without a repeat-resolved
  arrival, integral, or headroom improvement. The next test therefore changes
  posterior wave-shape allocation rather than another scalar threshold or
  range schedule.

## One-candidate hypothesis

Preserve the complete fore/aft-aware LOS/range/closing/half-cycle scaffold and
the evaluated response-gated posterior mean bend. Make one actuator-mechanism
change: replace the posterior lag asymmetry with the sampled phase-conditioned
posterior carrier-amplitude allocation, leaving base lag, anterior steering,
drive relief, redirect, and soft action bounds unchanged. Joint velocity
supplies phase and the body-frame turn request supplies reflection-equivariant
direction, so the edit adds no clock, route memory, or world-frame cue.

The hypothesis is that amplitude allocation will retain its observed command
headroom while the response gate suppresses the wrong-sign yaw that made the
standalone amplitude path hook strongly. Accept only if capture and the
coherent two-view wake remain, sub-`1L` yaw/course residual is no worse than
the response-gated parent, and command residence improves toward the amplitude
sample without exceeding the established force/moment or joint/rate envelope.
Falsify if capture, arrival/integral, terminal topology, yaw/course residual,
command headroom, loads, joint margin, or wake coherence regress. If
falsified, restore the response-gated phase-lag parent rather than tune the
amplitude scalar.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and two-joint traveling-wave swimming
source_mechanism: bounded half-cycle posterior-amplitude allocation combined with response-gated mean-curvature turning
transferable_invariant: preserve rhythmic propulsion while reallocating posterior bend amplitude from observed joint phase and body-frame turn demand, and retain direct bend authority only while measured yaw opposes that demand
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, exact gait or vortex phase, full-body waveforms, and task-specific coordinates or routes
policy_translation: replace lag asymmetry with a bounded multiplier on the posterior joint carrier derived from normalized anterior joint velocity times target-derived turn request, while preserving the evaluated normalized wrong-sign-yaw curvature gate
falsification: reject if terminal yaw or course residual exceeds the response-gated parent, command headroom fails to approach the amplitude sample, or capture, arrival, distance integral, joint margin, loads, or either wake view regresses
