# Posterior turn-phase lag replication

## Evidence diagnosis before the policy edit

- All four sampled episodes satisfy the frozen contract: direct uniform
  still-water initialization at `U_infinity=(0,0,0)`, no cylinders or prewarm,
  stable moving-window dynamics, and `capture` termination. They capture in
  `19.635--19.817T` with mean distance `2.10246--2.10672L`; there is no
  semantic failure in the sampled batch, so the slower exact corridor-policy
  replication is the informative underperformer rather than a fabricated
  failure comparator.
- I inspected both rows of every combined keyframe sheet, with the batch-best
  posterior-lag sample (`solver_17ed583a64e1`) compared directly against the
  slower exact corridor replication (`solver_2adc39f18b21`). The top-down rows
  show self-propulsion from quiescent water, coherent alternating vorticity,
  and the same bounded late hook into the target. The oblique rows show compact
  three-dimensional Lambda2 structures following the fish without collision,
  wake collapse, or instability. The sheets do not establish a different
  trajectory class, so timing, integral, yaw, and actuator histories must
  discriminate the mechanisms.
- The inherited projected-miss/intercept-corridor hypothesis is falsified on
  this release: its byte-identical runs bracket the plain LOS-led controller at
  `19.701T/2.10438L/-0.21449` and `19.817T/2.10672L/-0.21655`, versus
  `19.706T/2.10594L/-0.21598`, while using more mean command. Inherited logs
  also show that adding approach-gated posterior relative-crossflow curvature
  retained capture but regressed to `19.894T/2.11284L/-0.22287`, increased
  sub-`2L` yaw, and worsened path efficiency. Neither observation warrants
  scalar tuning here.
- The sampled posterior turn-phase allocation is the batch-best candidate. It
  captures at `19.635T`, lowers mean distance to `2.10246L`, improves score to
  `-0.21272`, and reduces sub-`2L` mean absolute yaw from the plain controller's
  `0.4366` to `0.4175 rad/T`. It stays in the coherent physical class with
  maximum joint angle below `0.587 rad` and peak planar force/yaw moment about
  `0.0248/0.0131`. The cost is real: posterior mean absolute command rises
  from `17.02` to `17.44 rad/T^2`, posterior residence above 90% of the smooth
  command bound rises from `32.7%` to `33.9%`, and both policies reach the joint
  rate limit. Its `0.0715T` timing gain is smaller than the `0.116T` span of the
  identical corridor repeats, so this is promising multi-metric evidence, not
  proof of portability.

## One-candidate hypothesis

Replace the prefilled, unconfirmed corridor controller with an exact controlled
replication of the sampled posterior turn-phase policy. Preserve the plain
captured scaffold: state-feedback carrier, fore/aft-aware body-frame target
map, distance-and-positive-closing drive relief, velocity-course redirect,
line-of-sight-rate lead, route steering, anterior half-cycle asymmetry, and
soft command limit. The only added actuator mechanism modulates posterior lag
symmetrically around its unchanged mean using normalized anterior-joint
velocity times the current body-frame turn request. This reallocates traveling-
wave timing without adding static curvature, crossflow rejection, a clock,
route memory, or a world-frame cue.

Expected signature: reproduce capture and both coherent wake views, retain the
established joint-angle and approximately `0.025/0.013` force/moment class, and
confirm reduced terminal yaw plus improved timing and distance integral beyond
executable repeat variation. Falsify the mechanism if replication falls back
into the `19.70--19.82T` plain/corridor band, loses capture, increases terminal
hook or path inefficiency, materially raises command/rate-limit residence or
loads, or degrades either wake view. If falsified, restore the plain LOS-led
half-cycle scaffold and do not tune posterior-lag asymmetry without a held-out
pose or inflow that exposes a repeatable wave-shape deficit.

bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive thrust and robotic-fish CPG turning
source_mechanism: bounded phase-lag modulation of the posterior traveling bend during useful and return strokes
transferable_invariant: redistribute posterior wave delay from observed joint phase and body-frame turn demand while preserving the mean traveling rhythm
nontransferable_details: published gains, dimensional cadence, species kinematics, full-body waveforms, clock or vortex phase, and task-specific coordinates or routes
policy_translation: modulate the owned posterior lag symmetrically with bounded normalized anterior-joint velocity times the equivariant target-derived turn command under the existing two-joint soft action bound
falsification: reject if capture, timing, distance integral, terminal yaw, wake coherence, load class, joint margin, rate-limit residence, or command headroom fails to improve beyond executable repeat variation
