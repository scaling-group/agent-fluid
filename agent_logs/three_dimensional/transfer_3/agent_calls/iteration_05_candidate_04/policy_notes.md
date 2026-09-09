# Candidate diagnosis and policy hypothesis

## Evidence diagnosis

- All four sampled rollouts report direct uniform initialization in still
  water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Translation
  and every visible wake structure are therefore self-generated rather than
  imposed advection.
- The strongest finite sample, `solver_adc862529891`, preserves the fast
  `28 deg`, `0.55T` carrier. Its top-down row shows a long alternating vortex
  street and its oblique row shows distinct three-dimensional Lambda2
  structures. It reduces distance from `12.328L` to `5.658L` at `15.64T`,
  materially better than the other target-aware samples, but it then exits
  the upper boundary at `16.769T` with `5.843L` final range. Beat-mean
  line-of-sight error has already crossed from about `+0.13 rad` at `2T` to
  `-0.05 rad` at `4T` and continues to about `-1.30 rad` by `16T`, while the
  body rises from about `13.9L` to `15.1L`. Its one-joint yaw residual retains
  propulsion but does not withdraw and reverse the turn soon enough.
- The assigned prefill, `solver_2bf5e06dbda4`, tests a two-joint recoil
  estimate but regresses to `11.764L` minimum distance and exits the same
  upper boundary at `9.213T`. Both visual rows show a short, tightly curled
  wake rather than the long translating street of the strongest sample. Its
  controller forms `compensated_yaw_rate - target_yaw_rate`; after the target
  crosses the body centerline this polarity sustains the turn instead of
  making the requested positive yaw rate catch up with the still-negative
  response. The rollout therefore rejects that feedback sign, not the general
  idea of separating gait recoil from slow rigid yaw.
- Retrospective, beat-windowed trajectory checks expose a second sensing
  issue. For `solver_adc862529891`, the line-of-sight phase residual standard
  deviation falls from `0.172` to `0.054 rad` when reconstructing the slow
  direction as `los + 0.55*phi1 + 0.10*phi2`; the analogous reduction for
  `solver_97bc3c03d55b` is `0.154` to `0.013 rad`. Likewise,
  `heading_rate + 0.62*phi_dot1 + 0.10*phi_dot2` reduces the strongest
  sample's within-beat yaw-rate residual from `1.79` to `0.20 rad/T` and uses
  coefficients consistent with the second rollout. These are retrospective
  kinematic checks, not CFD evidence for the new policy.
- `solver_19f251537923` remains the propulsion reference: it reaches `6.138L`
  with a long coherent wake before a wrong-side lower exit. Local-flow traces
  remain small in the inherited evidence and no rollout reaches the `0.75L`
  terminal regime, so neither wake rejection nor distance scheduling is the
  supported next mechanism.

## Policy hypothesis

Test one new sensing-and-feedback mechanism: joint-phase reconstruction of a
tail-beat-mean body direction. Preserve the strongest sample's state-feedback
traveling bend. Remove the repeatable joint-angle component from instantaneous
body-frame line of sight, and remove the matching joint-velocity component
from instantaneous rigid yaw rate. The reconstructed line of sight requests a
bounded slow yaw rate; the conventional signed error
`target_yaw_rate - reconstructed_yaw_rate` drives posterior equilibrium
curvature. This differs semantically from the assigned prefill by correcting
the closed-loop error polarity and by phase-conditioning both direction and
rate, rather than only the rate.

Expected result: retain the long alternating wake and leftward progress of
`solver_adc862529891`, but let the reconstructed target error cross zero only
once per route crossing and command positive counter-curvature as soon as the
slow yaw is more negative than requested. Falsify the mechanism if either
reconstructed signal remains beat-dominated, the initial target-side turn has
the wrong sign, posterior curvature stays one-signed after slow alignment,
the wake collapses into a tight curl, or the upper-boundary topology repeats
without improving the `5.658L` closest approach. The new CFD result is not
available to this worker.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and tail-beat averaging models
source_mechanism: close direction feedback around the slow body response reconstructed beneath a rhythmic gait
transferable_invariant: preserve the propulsive traveling wave, remove its joint-state-correlated direction and yaw recoil from feedback observations, and reverse bounded steering when the reconstructed response overtakes the body-frame request
nontransferable_details: published gains, dimensional beat rates, linkage geometry, species-specific kinematics, exact vortex phases, fitted coefficients from foreign platforms, and task-specific routes
policy_translation: reconstruct normalized body-frame line of sight with `phi` and slow yaw rate with `phi_dot`, then map their bounded signed rate error only to the posterior equilibrium of the two-joint state-feedback carrier
falsification: reject if phase reconstruction does not suppress within-beat variation, initial yaw polarity is wrong, counter-curvature does not appear after alignment, propulsion collapses, or the same upper exit recurs without a better closest approach
