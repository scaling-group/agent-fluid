# Phase-demodulated yaw-moment response candidate

## Visual and metric diagnosis before the policy edit

- All four sampled solvers satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics, an active
  moving window, and capture. Three are byte-identical copies of the assigned
  lateral-response policy and capture at `16.604496T`, `0.743958L`, and score
  `-0.113729`. The distinct one-sided speed-guard parent captures one
  `0.0055T` step later at `16.609995T`, `0.745621L`, and score `-0.115560`.
  These repeats establish fixed-case determinism, not held-out robustness.
- I inspected both rows of the combined keyframe sheets for the strongest
  lateral-response capture and the controlled speed-guard parent. In both
  top-down rows, the fish self-propels along a shallow target-crossing arc and
  sheds a coherent alternating vorticity street from release through capture.
  In both oblique rows, compact three-dimensional Lambda2 structures remain
  finite and connected to the tail. Neither result is passive advection, wake
  breakup, collision, boundary exit, or numerical failure. No semantic
  failure sheet exists in this sample, so the weaker captured parent is the
  informative mechanism comparator.
- The metric benefit of lateral response residualization is narrow. It lowers
  scored distance integral from `1.999656L` to `1.998146L` and advances capture
  by one step, but raises peak planar force/moment from
  `0.035828/0.017759` to `0.037165/0.018356` and slightly raises near-limit
  residence. The inherited logs also supply two negative controls: adding
  phase-demodulated line-of-sight-rate feedforward worsened score and distance
  integral to `-0.118996/2.002387L`, while removing fitted carrier phase from
  target bearing delayed capture to `17.094002T` and worsened score to
  `-0.121357`. Raw target geometry must therefore stay intact, and a new test
  should act on response rather than route semantics or carrier amplitude.
- A response cue remains available in the completed traces. Within `6.5L`, a
  two-term regression of normalized yaw moment against `q1_carrier` and
  `q1_dot` explains `94.54%` of variance for the strongest capture and
  `94.44%` for its parent. The fitted coefficients are stable across that
  controlled pair (`0.02316/0.000948` and `0.02301/0.000950`), while the
  residual standard deviation is about `0.00226`, versus raw moment standard
  deviation `0.00961--0.00966`. Thus raw instantaneous moment is mostly beat
  phase, but a bounded phase-demodulated residual can test incipient physical
  yaw response without reinterpreting target bearing or shedding the wave.

## Sole policy hypothesis

Preserve the evaluated lateral-response policy, including its full anterior
oscillator, raw target bearing and raw-course anterior center, centered yaw and
lateral observers, posterior half-cycle steering, smooth acceleration bound,
and final-one-percent speed guard. Add one approach-gated response channel:
reconstruct the carrier-correlated normalized yaw moment from centered anterior
joint angle and velocity, subtract it from measured `moment_z_L2`, softly bound
the residual at its observed scale, and add a small same-sign correction to the
existing posterior turn state. Positive residual moment predicts positive
physical yaw; under the completed actuator calibration, the same-sign posterior
correction requests opposing physical yaw, matching the existing
actual-minus-requested yaw-response convention.

This is normalized, body-frame, reflection-equivariant, clock-free feedback.
The approach gate leaves the demonstrated far route unchanged, and the bounded
channel cannot replace the established target request or propulsive carrier.
Its falsifiable purpose is to react one dynamic level earlier than measured yaw
rate and recover the lateral observer's small progress gain without enlarging
its load/saturation tradeoff. Reject it if capture, arrival, distance integral,
target-crossing arc, or connected wake regresses; if raw target geometry is
effectively overridden; if residual moment remains strongly carrier-correlated;
or if joint contact, near-limit residence, force, or moment increases.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and wake-disturbance residual control
source_mechanism: preserve rhythmic propulsion while a separately bounded measured-response channel corrects directional disturbance
transferable_invariant: remove beat-synchronous carrier content from a normalized body-frame response before its residual contributes a small steering correction
nontransferable_details: published gains, species or robot kinematics, dimensional beat timing, exact vortex phase, prescribed route, maneuver duration, and source-task disturbance statistics
policy_translation: on approach reconstruct carrier yaw moment from centered anterior joint angle and velocity, then feed only the softly bounded moment residual into the existing posterior response state while preserving raw target geometry and the full two-joint carrier
falsification: reject if capture, distance cost, target arc, connected wake, phase separation, joint envelope, effort, force, or moment worsens against the three exact assigned-parent captures

## Evaluation boundary

The moment fit and all comparative outcomes above belong to completed sampled
rollouts; no CFD outcome is claimed for this child. Later evaluation should
require capture and the same top-down/oblique wake class first, then compare
arrival, scored and observed distance integrals, moment-residual phase
correlation, target-crossing geometry, joint contact, speed/acceleration
residence, mean action, and peak planar force/moment. A changed pose, flow,
carrier family, observation filter, or morphology may invalidate the fitted
observer and is a held-out test.
