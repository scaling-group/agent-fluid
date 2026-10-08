# Closure-qualified phase-compatible redirect candidate

## Visual and metric diagnosis before the policy edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite moving-window
  dynamics, and capture. Three are exact policy, trajectory, and keyframe
  repeats of the assigned lateral-response-residual parent. They capture at
  `16.604496T`, score `-0.113729`, final distance `0.743958L`, and scored
  distance integral `1.998146L`. The distinct raw-lateral response control
  captures at `16.609995T`, score `-0.115560`, final distance `0.745621L`, and
  integral `1.999656L`. The triplicate establishes nominal reproducibility,
  not held-out robustness.
- I inspected the combined top-down and oblique rows from release through
  capture for an exact best parent and the weaker control. Both top-down rows
  show self-propelled targetward translation under coherent alternating
  vorticity, followed by a shallow target-crossing arc. Both oblique rows show
  finite, compact, tail-connected three-dimensional Lambda2 structures.
  Neither rollout is passive advection, wake breakup, collision, boundary
  exit, or instability; the weaker captured ablation is the informative
  visual comparator because no sampled semantic failure is present.
- The traces support preserving the carrier. Relative to the control, lateral
  response residualization advances capture by one `0.0055T` step and lowers
  distance integral by `0.001510L`, but raises peak planar force/moment from
  `0.035828/0.017759` to `0.037165/0.018356` and slightly raises near-limit
  residence. The best parent's full carrier reaches maximum joint speeds of
  `4.537856 rad/T`, while its captured approach remains strongly closing.
  Phase-demodulated target--velocity alignment stays above `0.789` inside
  `6.5L`, including the final shallow crossing, so loss of normalized closure
  is an observable that can isolate a redirect from the demonstrated route.
- Inherited logs delimit what that redirect must not do. Approach-only
  line-of-sight-rate feedforward, approach-bearing phase subtraction, and a
  phase-demodulated yaw-moment residual all preserved finite capture and the
  connected wake but worsened score/integral to respectively about
  `-0.118996/2.002387L`, `-0.121357/2.006259L`, and
  `-0.115946/1.999941L`. Earlier closure-aware whole-wave relief and terminal
  mean-curvature bursts damaged approach or joint/load behavior. The new
  channel therefore uses neither target-rate prediction, geometric
  residualization, moment rejection, mean curvature, nor bilateral carrier
  shedding.

## Sole policy hypothesis

Preserve the assigned parent's oscillator, raw body-frame target geometry,
mean-preserving yaw and lateral response demodulation, bounded anterior course
center, posterior route half-cycle control, acceleration bound, and one-sided
speed guard. Add one approach-only redirect driven by the normalized dot
product of the body-frame target vector and phase-demodulated velocity. When
that target--velocity alignment enters the lower edge of the completed
parent's range, smoothly recruit a separate posterior half-cycle attenuation
whose sign comes from velocity-course error; reserve full authority for
alignment below `0.65`, which the parent never reached. The useful redirect
half-cycle and the entire anterior carrier remain unchanged.

This is a bounded, reflection-equivariant, clock-free state-feedback mechanism
under the two-joint contract. The expected test is preservation of nominal
capture and both wake views, with a more direct late crossing if alignment
briefly degrades and a recovery channel if a later pose or flow produces the
previously observed saturated course error. Falsify it if capture, distance
integral, arrival, the inherited far route, or wake connectivity regresses; if
it activates broadly during healthy closure; if it cannot improve a genuine
closure-loss episode; or if joint contact, saturation, force, or moment grows.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and response-gated fish redirect maneuvers
source_mechanism: preserve rhythmic propulsion while a sensor-qualified directional response recruits a bounded phase-compatible redirect
transferable_invariant: separate productive rhythmic locomotion from a redirect that activates only when normalized target-aligned translational response is inadequate
nontransferable_details: published gains, dimensional beat frequency, species or robot kinematics, exact vortex phase, maneuver timing, prescribed routes, and source-task thresholds
policy_translation: compute target--velocity alignment from normalized body-frame target and phase-demodulated velocity; on approach and only under closure deficit, attenuate the posterior half-cycle opposing the velocity-course correction while leaving anterior and useful posterior carrier motion intact
falsification: reject if nominal capture, distance cost, far-route isolation, connected wake, closure recovery, joint feasibility, effort, force, or moment fails the completed-parent boundary

## Evaluation boundary

No CFD result is claimed for this unevaluated candidate. Later evaluation must
require capture and the same top-down/oblique wake class first, then compare
arrival, scored and observed distance integrals, target--velocity alignment,
redirect duty, target-crossing geometry, joint contact, near-limit residence,
mean action, and peak force/moment against the exact repeated parent. The
completed fixed-pose evidence calibrates the activation boundary but does not
establish robustness to a changed pose, flow, carrier, or morphology.

An offline replay of the completed parent trace (not a closed-loop prediction)
localizes the new channel: its gate is nonzero for `1.62%` of all samples and
`8.72%` of samples inside `3L`; projected extra posterior attenuation peaks at
only `0.0050` near `1.269L`, where alignment reaches its sampled minimum
`0.7893`. This supports far-route isolation and a gentle nominal intervention,
while full redirect authority remains reserved for an unevaluated alignment
loss and must be judged by the later CFD rollout.
