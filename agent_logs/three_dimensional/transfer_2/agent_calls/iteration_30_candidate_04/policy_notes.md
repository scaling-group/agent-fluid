# Candidate wake-policy notes

## Evidence diagnosis

- The four sampled solver artifacts are byte-identical policy and keyframe
  replications.  All use direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, capture at `24.640015T` and `0.748356L`, and report
  mean distance `2.347937L` and score `-0.448328283`.  They therefore establish
  deterministic nominal repeatability, not four independent trajectory tests.
- In both the top-down mid-plane row and the oblique Lambda2 row the fish is
  self-propelled, lays down a coherent alternating three-dimensional wake, and
  keeps that wake through the broad terminal hook.  There is no visible
  advection, prewarm artifact, collision, or instability.  The top-down route
  and the oblique center trace agree through the final crossing.
- The trace cross-check supports that visual reading: peak absolute planar
  body-force/yaw-moment coefficients are about `0.0254/0.0319/0.0156`, sampled
  posterior hard-stop occupancy is zero, and total exact-rate exposure is
  `13.839%`.  Raw acceleration-envelope exposure is still `73.594%`, but the
  inherited dual-joint velocity barriers show that suppressing that statistic
  globally changes the long approach and turns capture into a coherent
  `0.848--0.933L` pass-and-left-exit failure.  No failed keyframe sheet is
  present in the sampled solver set, so that failure comparison is numerical
  and inherited rather than a new visual claim.
- The v41 change is localized: a fixed-trace audit finds nonzero terminal
  phase allocation on 245 of 4480 rows, from about `21.98T` through `24.60T`,
  with integrated absolute allocated residual about `0.137` in turn-request
  units.  Its linear phase gate spends small pulses close to the uncertain
  half-cycle crossing and never reaches an alignment above about `0.75` on the
  parent trace.  The two completed allocation descendants show that moving
  this residual wholly posterior or reclaiming rejected tail share through the
  anterior anchor worsens final/mean distance and score.  The coupled split and
  posterior reserve must therefore remain unchanged.

## Policy hypothesis

Keep the evaluated carrier, all geometric/rate guidance, the `2.10L` terminal
locality, the predicted-miss corridor, the posterior stroke/rate guards, and
the coupled `0.70/1.00` two-joint steering split.  Change only the mapping from
positive lagged-wave alignment to the already-bounded terminal residual: use a
cubic smoothstep of normalized alignment instead of the current linear gate.
This leaves the selected half-cycle, zero and full endpoints, residual sign,
maximum authority, and all far-route commands invariant, while withdrawing
weak near-crossing pulses and concentrating the same mechanism in states with
clear phase alignment.  On the frozen parent trace it changes integrated
phase-selected authority only modestly (`0.137` to about `0.143`) rather than
adding a residual or rerouting it between joints.

Falsify the hypothesis if CFD loses capture, changes the route before `2.10L`,
worsens final or mean distance relative to the four v41 replications, increases
raw-envelope or exact-rate exposure beyond the same class, creates posterior
hard-stop occupancy, or raises the low force/moment class.  Even a nominal
improvement would not establish reflected or perturbed-pose robustness.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG and asymmetric-flapping control
source_mechanism: state-dependent duty shaping applies target-turn asymmetry on a selected propulsive half-cycle while retaining the rhythmic carrier
transferable_invariant: allocate a bounded target-derived asymmetry by observed oscillator phase rather than by time or continuous mean curvature
nontransferable_details: published gains, clock phase, robot geometry, species kinematics, exact vortex phase, and task-specific routes
policy_translation: apply a mirror-equivariant smoothstep to the positive alignment between the body-frame terminal-course residual sign and the lagged anterior-to-posterior wave state; preserve the residual bound and coupled two-joint shares
falsification: reject if capture, pre-terminal route identity, distance metrics, rate/stroke class, or force/moment class regress; require held-out reflection or pose evidence before claiming generality
