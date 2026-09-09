# Redirect-reserve carrier-allocation candidate

## Visual and diagnostic evidence before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no prewarm or cylinders, finite
  moving-window transport, stable dynamics, and `capture` termination. The
  current problem is refinement within a coherent capture class, not recovery
  of propulsion, stability, or semantic success.
- Both rows of the combined keyframe sheets for the strongest response-aware
  repeat and the informative weaker course-response variant were inspected
  from release through termination. The top-down rows show self-propulsion
  from a clean quiescent field, an organized alternating vorticity street, and
  a continuous late target-side hook. The oblique rows show compact 3D
  Lambda2 structures following the caudal region without passive advection,
  wake breakup, collision, or instability. Propulsion visibly eases during
  the final arc in both. The weaker variant therefore does not expose a new
  wake failure; it changes course/effort within the same useful topology.
- The response-aware handoff now has two byte-identical evaluations. They
  capture at `19.162/19.338T`, with distance integrals
  `2.06924/2.07622L`, head paths `12.309/12.304L`, peak planar force/yaw
  moment coefficients `0.02537/0.01357` and `0.02535/0.01335`, and zero
  99%-angle-limit residence. This confirms capture and the shorter-path
  trajectory, while the timing/integral spread remains a repeat boundary.
  The anterior/posterior commands nevertheless spend `35.7--36.0%` and
  `33.8--34.0%` of the rollout above 90% of the smooth command bound, and
  joint-rate samples spend about `6.35%` above 99% of the rate envelope.
- Replacing turn-request/yaw agreement with velocity-course-error/yaw
  agreement is a concrete negative result. That variant still captures and
  keeps the coherent wake, but reaches the target at `19.398T` with integral
  `2.08187L`, path `12.341L`, and peak planar force `0.02587`; all are worse
  than both response-aware repeats. It is also slower and has a worse integral
  than the simpler distance-only handoff (`19.354T/2.07892L`). Do not tune
  that response scalar or compose its signal with another gait gate on this
  release.

## One-candidate hypothesis

Preserve the complete response-aware capture scaffold and introduce one
actuator-allocation mechanism rather than another steering or handoff gain.
Decompose each joint's raw acceleration into traveling-wave carrier and
steering/approach components. Only while the existing velocity-course redirect
is active and measured yaw has not yet aligned with the route request, compute
how much carrier can fit inside a parameter-owned 90%-of-output smooth-limit
budget and attenuate the common carrier accordingly. Preserve steering,
approach damping, mean curvature, the posterior allocation endpoints, and the
soft limiter. Once yaw responds or redirect demand falls, the exact parent
traveling bend returns continuously.

Expected signature: retain capture, the response-aware early progress and
`12.30--12.31L` path class, and the coherent two-view wake while reducing
greater-than-90%-bound command residence and ideally rate-limit residence,
without increasing the sampled `~0.0254/~0.0136` force/moment class. Falsify
the mechanism if carrier relief weakens the wake or early milestones, lengthens
arrival/integral beyond the response-aware repeat spread, restores the wider
hook, loses capture, or fails to buy actuator headroom. If falsified, restore
the exact response-aware handoff rather than changing the reserve fraction.

bookshelf_consulted: true
source_domain: robotic-fish sensor-modulated CPG control and biological burst-redirect turning
source_mechanism: temporarily prioritize observed redirect curvature over the rhythmic carrier, then release continuously back into the established traveling gait when directional response appears
transferable_invariant: allocate bounded actuator authority between propulsion and steering from observed redirect demand and measured yaw response while preserving the underlying state-feedback wave
nontransferable_details: published gains, dimensional cadence, species-specific burst shapes, robot actuator models, full-body waveforms, clock phase, exact vortex phase, world coordinates, and task-specific routes
policy_translation: under the two-joint acceleration contract, split each raw command into carrier and steering components and reduce only the common carrier enough to reserve parameter-owned smooth-limit headroom during an unresolved body-frame redirect
falsification: reject if command or rate headroom does not improve together with capture, early progress, short path, stable loads, joint margin, and coherent top-down and oblique wakes
