# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts satisfy the released contract: direct uniform
  still water with `U_infinity=(0,0,0)`, no cylinders or prewarm snapshot,
  capture termination, and no reported instability. The assigned-parent
  `solver_43e27134a723` and informative broad-relief
  `solver_392ed1eddf30` combined sheets both show continuous target approach
  behind an alternating red/blue mid-plane street. Their oblique rows retain
  discrete three-dimensional Lambda2 structures from the developed gait to
  capture. Neither sheet shows passive advection, wake decay, or a terminal
  coast, and their small performance difference is not visually separable at
  the keyframe cadence.
- The assigned parent's response-plus-stroke relief is the strongest sampled
  finite result: it captures at `24.310009T` and `0.749162L`, has mean distance
  `2.223959L`, and scores `-0.325172`. Broad response relief is three control
  steps later at `24.326511T`, `0.749329L`, and `2.224097L`; the smoother
  translation-alignment replacement is later still at `24.343010T`, although
  its `2.224020L` mean distance remains slightly better than broad relief.
  The duplicate broad-relief samples reproduce exactly, so their weaker
  result is not rollout noise in this deterministic fixed pose.
- Peak normalized planar force and yaw moment are the same to reported
  precision across these samples (`0.031649/0.016385`), and the assigned
  parent retains finite anterior/posterior rate-cap occupancy near
  `14.05/6.92%`. Its mean action norm inside `1.5L` is about `43.00`, slightly
  above broad relief's `42.93`, while its terminal target-signed yaw rate is
  larger. The improvement therefore does not support a generic damping or
  reduced-effort interpretation. Together with the inherited broad `+20%`
  closing-deficit boost, which delayed capture to `24.414513T`, the evidence
  isolates *where within the stroke* posterior steering is allocated as the
  useful variable: relieve the target-side stroke while retaining return-
  stroke authority, without changing the traveling carrier.

## One candidate hypothesis

Preserve the full-angle body-frame target geometry, slip-aware anterior
center, anterior redirect, phase-selective posterior carrier, reactive-rudder
sign and recruitment, and the closing-response gate. Replace only the current
one-sided terminal relief with a bounded paired half-cycle redistribution.
Under a closing deficit, retain the evidenced `0.8` rudder authority on the
target-side anterior stroke and smoothly raise it toward `1.2` on the return
stroke; at the smooth phase transition and outside the deficit the authority
is one. This approximately preserves cycle-mean steering while moving the
posterior load away from the stroke on which relief already improved capture.
It is a duty-allocation mechanism, not another carrier or rudder gain change.

The candidate is falsified if it loses capture, arrives after the assigned
parent's `24.310009T`, raises mean distance above `2.223959L`, or materially
increases near-target effort, rate-cap occupancy, peak normalized force or
moment, terminal target error, or wake disorder. Because the inherited broad
rudder boost was harmful, a later arrival or higher loads would specifically
show that the parent's benefit came from lower cycle-mean steering rather than
from relocating steering impulse between half-cycles. One fixed-pose result
cannot establish held-out robustness.

bookshelf_consulted: true
source_domain: robotic-fish CPG duty-ratio control and half-cycle steering asymmetry
source_mechanism: preserve the rhythmic traveling carrier while redistributing a bounded steering load between joint-observed power and return strokes
transferable_invariant: move steering effort between observed half-cycles instead of uniformly scaling the propulsive carrier or adding a persistent bend
nontransferable_details: published gains, robot linkage geometry, species-specific kinematics, dimensional frequency, prescribed duty ratio, exact vortex phase, maneuver timing, and task-specific route
policy_translation: normalized body-frame target side multiplied by anterior joint velocity defines a smooth reflection-equivariant stroke coordinate; the existing normalized closing deficit gates a paired 0.8-to-1.2 posterior-rudder authority while carrier phase and amplitude remain unchanged
falsification: reject on later or failed capture, worse mean distance or terminal alignment, higher effort, saturation, force, or moment, or loss of the coherent top-down and oblique wake
