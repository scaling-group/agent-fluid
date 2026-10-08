# Course-sideslip feedback candidate

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the Phase-2 contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders or
  prewarm snapshot, complete top-down/oblique sheets, and capture. Three
  byte-identical rate-governor policies reproduce `-0.51274776` at
  `23.3640T`; the lower-scoring course-aligned policy captures at `23.3585T`
  with `-0.51527750`.
- In both sampled sheets, the fish self-propels along a continuously closing
  course. The top-down row shows an alternating caudal street forming by `4T`
  and remaining coherent through the late target turn; the oblique Lambda2
  row confirms compact three-dimensional posterior structures through
  capture. There is no passive advection, collision, wake collapse, or
  out-of-plane instability. The useful carrier, odd target-to-curvature map,
  and direction-selective rate governor should therefore remain intact.
- The inherited `c6641cd4a25c` sheet retains that wake but its shared
  rate-triggered carrier damping changes the course from the first `4T` frame,
  delays capture to `23.7215T`, and worsens mean score-distance from
  `2.409486L` to `2.427669L` (`-0.53004112`). Two other inherited upstream
  throttles agree: suppressing cadence boost gives `2.421103L` and
  `-0.52317589`, while positive-power phase-load gating gives `2.430448L` and
  `-0.53312008`. All still capture, but none is a semantic improvement; lower
  rate/acceleration residence did not compensate for slower target progress.
- The strongest rollout instead leaves a measured course-control residual.
  Inside `2.1L`, the absolute angle between velocity course and target course
  averages `0.2855 rad`, peaks at `0.6797 rad`, and is `0.5988 rad` at capture.
  At `20T`, velocity is already target-aligned to `0.0231 rad` even though the
  body bearing remains `-0.4387 rad`, so heading-only geometry can continue to
  steer after the useful course is established. The existing lateral-velocity
  term divides `velocity_body_U[2]` by `L` even though the evaluator already
  supplies that observation in U units; at capture its request contribution is
  only about `0.0009`, so it cannot materially close the observed residual.

## One policy hypothesis

Preserve propulsion, posterior lag, cadence, signed mean curvature,
half-cycle steering, approach scheduling, and the proven output rate governor.
Replace only the nearly inert linear lateral-velocity term with a bounded
course-sideslip correction: infer sideslip from normalized body-frame velocity
relative to the fish's `-x` forward axis, suppress it continuously at low
speed, and add it to the target-derived geometric request. This makes the
existing turn-rate loop track actual velocity course as well as body bearing
without changing carrier energy or adding a route/stage counter.

The expected result is the same coherent wake and capture with less early
course meander, lower near-target course residual, and no worse arrival,
distance integral, path, load, or rate residence. Falsify the mechanism if it
loses capture, changes the wake topology, reproduces an upper/lower exit,
increases terminal course error, or slows progress like the three inherited
carrier-throttling variants. A single fixed-case gain is not evidence of
held-out robustness; a later reflected pose/target should test the odd course
response.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking with a low-dimensional propulsive oscillator
source_mechanism: sensor-derived course error biases turning while the traveling propulsive rhythm and posterior lag remain intact
transferable_invariant: correct persistent target-course sideslip with bounded body-frame velocity feedback without throttling the productive carrier
nontransferable_details: published controller gains, robot or species kinematics, dimensional cadence, exact vortex phase, and task-specific routes
policy_translation: convert normalized body-frame velocity into a speed-gated course-sideslip angle and add one bounded correction to the existing target-to-curvature request under the two-joint state-feedback contract
falsification: reject if capture or wake coherence is lost, velocity-to-target course residual does not contract, or arrival, integrated distance, path, loads, and rate residence worsen materially
