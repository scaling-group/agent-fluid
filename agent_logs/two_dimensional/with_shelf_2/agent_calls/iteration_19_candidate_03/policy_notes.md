# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- The shared prewarm sheet is the common held-fish initial condition: four
  developed, interacting vortex streets fill the diagonal corridor between the
  upper-right release and the second-row target. It is evidence of the common
  wake and geometry, not candidate-specific phase information or a route.
- All four current solver samples are byte-identical finite captures. Their
  released sheet shows an immediate traveling body wave, active down-left
  swimming through the merged wakes, and target entry without a cylinder
  approach. Mean body-x velocity is `-0.2470`, versus `-0.1848` mean local
  flow, and head displacement is `-10.910/-4.263L`; the route is actively
  propelled rather than passive advection.
- The sampled fixed terminal course-mismatch damper is a completed positive
  result over its immediate time-to-go-only reference. It improves
  arrival/mean distance/score from `45.221/1.71458L/0.165860` to
  `44.121/1.70618L/0.173450`, while reducing force/moment RMS from about
  `439/4345` to `389/3909`. Mean command energy rises modestly from `1030.39`
  to `1036.49`. The visual topology is retained with a shallower terminal
  excursion, so the course residual, propulsion, and yaw gate should remain.
- The weakest retained distinct sheet is still a capture, not a failure. Its
  sine-shaped lateral-course residual follows the same broad diagonal route
  but reaches at `46.074`, has `1.73655L` mean distance and score `0.144279`,
  and carries `407/4002` force/moment RMS. Inherited completed variants also
  reject sharing the heading/course response clamp (`45.727/1.72692L`),
  strengthening the course damper with closure (`45.689/1.71923L`), and
  withdrawing an opposing heading forecast (`45.331/1.72584L`). The fixed raw
  angular mismatch with independent authority is the supported route form.
- No retained failure keyframe sheet is available. The inherited quantified
  failure boundary is broader optional posterior propulsion: it passed below
  capture and collided after a `1.872L` closest approach with `537/4995`
  force/moment RMS. This candidate therefore does not add propulsion, change
  posterior allocation, introduce signed wake rejection, or alter the terminal
  route residual.
- The strongest current rollout still reports both joint rates exactly at the
  `4.537856` hard cap, while accelerations approach `28.79/28.39` and the
  candidate soft limit is `29`. Once integration clips an outward rate update,
  continued same-direction acceleration cannot increase joint speed; it is an
  evidenced place to test constraint-aware state feedback rather than another
  gait or course gain.

## Policy hypothesis

Add exactly one mechanism after the existing acceleration soft limiter: a
joint-local rate-envelope governor. Normalize each observed joint rate by the
existing candidate-owned oscillator rate reference. As that envelope is
approached, smoothly attenuate only an acceleration with the same sign as the
joint rate; leave opposing acceleration fully available so braking and the
traveling-wave reversal are not delayed. Preserve the oscillator, posterior
lag and allocation, heading/course predictor, yaw-magnitude steering gate,
half-cycle law, and soft acceleration scale unchanged.

Expected later CFD evidence is the same diagonal first-crossing capture with
less time spent at the hard rate cap and lower command effort or hydrodynamic
load, without slower arrival or worse mean distance. Reject the mechanism if
it weakens upstream self-propulsion, changes wake-entry topology, delays or
loses capture, increases load/effort, or merely moves contact from the rate cap
to the angle cap. The fixed prewarm snapshot cannot establish robustness to a
changed wake phase, inflow, geometry, or target.

bookshelf_consulted: true
source_domain: constraint-aware closed-loop robotic-fish CPG control
source_mechanism: joint-state feedback bounds a rhythmic command near an actuation envelope while preserving the oscillatory reversal
transferable_invariant: preserve the traveling bend and full braking authority while smoothly withdrawing only acceleration that would drive an already fast joint farther outward
nontransferable_details: published CPG gains, robot or species rate limits, dimensional frequencies, actuator models, exact vortex phases, cylinder or target coordinates, and task-specific routes
policy_translation: normalize each joint rate by the candidate-owned oscillator rate reference and gate only same-direction post-limiter acceleration before returning the two-joint command
falsification: reject if capture or diagonal topology is lost, upstream propulsion or arrival regresses, cap contact is not reduced, or command effort and force/moment load fail to improve
