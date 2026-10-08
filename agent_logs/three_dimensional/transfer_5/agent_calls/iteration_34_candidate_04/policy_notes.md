# Multiscale progress-consensus candidate

## Evidence-led visual diagnosis

The assigned-parent rollout and two independently sampled variants
(`solver_e7cd0978d380`, `solver_a1a04070bc41`, and
`solver_056854f41a5a`) are bit-identical captures at `23.3750T`, score
`-0.505158`, and mean/final distance `2.402131/0.748882L`. Their top-down
mid-plane sheets show self-propelled translation with an alternating coherent
wake, a largely straight middle approach, and a deliberate turn into the
capture circle after about `18T`. The oblique Lambda2 sheets confirm a compact
three-dimensional alternating vortex train rather than passive advection;
direct uniform still-water initialization is recorded for every sample.

The informative weaker sample, `solver_15bdb9793bce`, preserves the same
visible wake and terminal topology but fades the new cadence reserve between
`4L` and `3L`. It captures 15 steps later at `23.4575T`, with worse score and
mean distance (`-0.505540`, `2.402686L`). Its lower inside-`3L` mean/peak yaw
(`1.676/3.226 rad/T` versus `1.713/3.292`) and peak moment (`0.01353` versus
`0.01451`) show a real speed/load trade: the un-faded reserve increases mean
near-target speed from `0.736U` to `0.749U`, but both policies still reach the
`260 deg/T` joint-speed cap. The sheets do not support replacing the carrier
or repeating a distance-only cadence fade.

## Policy hypothesis

Keep the assigned parent's coherent C-bend carrier, full near-target cadence
authority, role-separated terminal steering, posterior traveling wave, and
smooth command projection. Replace the instantaneous-only qualification of the
small progress cadence reserve with a bounded geometric consensus between (1)
instantaneous body-frame velocity projected onto the target vector and (2)
the normalized short-history closing speed already supplied by the observation
contract. The geometric mean stays near the successful instantaneous gate when
both cues agree, but suppresses reserve authority when a fast carrier phase
looks target-directed without producing geometric closing. It introduces no
clock, route state, or fixed coordinate.

Expected result: retain capture and most of the `23.3750T` progress gain while
reducing terminal yaw/load or joint-speed-cap exposure. Falsify the mechanism
if it reverts toward the distance-fade arrival/score, changes the coherent wake
topology, or fails to improve at least one load/kinematic measure without
worsening progress.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish CPGs
source_mechanism: separate persistent route progress from fast alternating carrier or crossflow motion before modulating a rhythmic drive
transferable_invariant: grant a small propulsion residual only when fast body-frame translation and short-history target geometry agree on useful closing
nontransferable_details: published gains, animal gait envelopes, clock phase, exact vortex phase, cylinder layouts, and task-specific routes
policy_translation: geometrically combine normalized instantaneous radial progress with normalized windowed closing, then use only that bounded consensus to qualify the inherited cadence reserve
falsification: reject if capture/progress regresses toward the sampled distance-fade result, wake coherence changes, or yaw, moment, and joint-speed exposure do not improve jointly enough to justify the extra observation
