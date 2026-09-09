# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled evaluations report direct uniform still-water initialization
  with `U_infinity=(0,0,0)` and no prewarm snapshot.
- In both the top-down vorticity and oblique Lambda2 rows, the aligned-curvature
  parent forms a coherent alternating wake but passes above the target: its
  closest approach is `2.579L` at about `19.88T`, after which it continues left
  and exits at `8.736L` by `29.47T`. The opposing-joint-sign sample turns toward
  the upper boundary much earlier and reaches only `5.357L`, so the aligned
  two-joint mean-bend map remains the better steering scaffold.
- The distance/closing-scheduled sample is the strongest useful finite
  trajectory. Its top-down row shows a target-directed approach followed by a
  broad curling pass, while the oblique row shows a coherent early 3D wake that
  becomes weak during the near-target coast and reforms late in the return arc.
  It improves closest approach to `1.733L` at about `22.81T`, but never enters
  the `0.75L` capture disk and exits the upper boundary at `6.793L` by `52.48T`.
- Quantitative traces explain the miss. From `20T` through `32T` the scheduled
  policy settles near a static bend (`phi1+phi2` about `0.24 rad`) with nearly
  zero joint speed and command for much of the interval, yet inertia keeps the
  fish near `0.73--0.77U`. Yaw is only about `0.16--0.28 rad/T` across the pass,
  while the body-frame target-to-velocity-course error grows from about
  `-1.21 rad` at `20T` to `-2.24 rad` at `26T`. Local flow, force, and moment are
  small during this coast, so drive relief does not provide useful braking.

## Policy hypothesis

Retain the sampled controller's joint-state traveling wave, full body-frame
target angle, aligned two-joint curvature sign, and distance/closing drive
relief. Add one terminal course-redirect mechanism: derive actual course from
normalized body-frame velocity, compare it with the body-frame target angle,
and use large near-target course error to smoothly raise the static head bias
and total mean curvature. This should turn the coasting velocity vector before
the closest approach instead of asking the already-saturated pure-pursuit term
for more of the same response. Release the extra bend continuously when course
error shrinks; do not use time, coordinates, a route, or an external phase.

Expected evidence: relative to the `1.733L` parent, the path should show a
tighter near-target arc, smaller target-course error before the miss, and
capture or a meaningfully smaller/repeated closest approach without destroying
the coherent far-field wake. Reject the mechanism if it produces an early
boundary turn, persistent joint-limit residence, bang-bang action, a wider
miss, or the same broad `~6L` orbit.

bookshelf_consulted: true
source_domain: biological C-start redirection and robotic-fish mean-curvature turning
source_mechanism: large observed course error requests a strong bounded bend, followed by continuous release into cruise as directional response appears
transferable_invariant: allocate near-target actuation to bounded mean curvature while actual velocity course is misaligned, and release that allocation as course alignment improves
nontransferable_details: species-specific body envelopes, published gains and frequencies, dimensional burst duration, exact vortex phase, and task-specific routes
policy_translation: compute target and velocity-course angles from normalized body-frame `target_body_L` and `velocity_body_U`; distance-gate a smooth error-dependent head bias and total two-joint curvature while preserving joint-state phase
falsification: reject if the sampled broad pass is not tightened, capture or closest approach does not improve, the far-field wake loses coherence, or action and joint-limit residence increase materially
