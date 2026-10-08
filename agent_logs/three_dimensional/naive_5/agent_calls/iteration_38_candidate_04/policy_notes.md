# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen experiment contract:
  direct-uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders or prewarm snapshot, and inertial moving-window transport. All
  terminate in capture with no angle, rate, or applied-acceleration contact.
  I inspected every combined keyframe sheet from release to capture in both
  the top-down mid-plane vorticity/body row and the oblique body/Lambda2 row.
  Each fish visibly self-propels from rest, maintains an organized alternating
  wake with compact three-dimensional structures, and reaches the target
  through a shallow late hook. There is no passive advection, boundary
  interaction, wake breakup, thrust collapse, numerical instability, or
  moving-window-induced rotation. The common coherent wake supports retaining
  the carrier; the differing route response is the useful discriminator.
- The assigned duty-ratio parent (`solver_b3cc38ade37a`) is the strongest
  finite rollout. It captures at `0.748598L` and `25.5090T`, lowers mean
  distance to `2.457773L`, and scores `-0.556475`, versus capture at
  `25.8115--25.9160T`, mean distance `2.496011--2.496891L`, and score
  `-0.594050--0.594758` for the three middle-response samples. Its upstream
  anterior duty skew is therefore a real progress mechanism at the fixed
  pose, not another milliscale terminal tie-break: at `8T` its distance and
  projected miss are `10.3083/6.6526L`, versus `10.4307/7.8534L` for all
  three comparisons, and at `12T` they remain better at
  `8.1725/6.0127L` versus `8.3600/6.2153L`.
- The same trace exposes a response-release deficit. By `16T`, the parent is
  still closer (`5.8980L` versus `6.1023L`) but its normalized course error
  and projected miss have reversed from the early gain to
  `0.6827/4.0267L`, versus `0.5427/3.3117L` for the comparisons. At `24T`
  that contrast is `0.7863/1.1596L` versus the best force-qualified sample's
  `0.5962/1.0099L`. The parent body-frame bearing moves from `+0.0086` at
  `8T` to `-0.1765` at `12T`, onto the side requested by its negative
  course-turn command, yet the distance-only duty schedule remains almost
  fully engaged until the middle corridor. Continuing the skew after this
  observed body response is the informative finite failure.
- The faster parent retains zero actuator contacts and a coherent wake, but
  its peak joint angle/rate/command (`0.77093 rad`, `4.51769 rad/T`, and
  `29.86795 rad/T^2`) and planar force/yaw moment (`0.02063/0.01065`) are
  all slightly above the comparison envelope (`0.76352`, `4.51496`,
  `29.65805`, and about `0.01896/0.01018`). This gives no evidence for
  increasing duty authority or propulsion. The inherited logs also close
  additive posterior, force, and moment residuals as semantic course fixes,
  so the clean test is response-conditioned release of the successful new
  primitive rather than another stacked correction.

## Policy hypothesis

Preserve the assigned state-feedback traveling bend, posterior lag,
course/miss-triggered redirect, target-line response residual, upstream
vectoring, middle force response, capture modulation, coordinated acceleration
projection, and angle/rate viability guards. Preserve the evidenced anterior
duty-ratio mechanism and add only a normalized response-release gate. While
body bearing and velocity-course geometry request opposite sides, the upstream
duty skew passes through. As body bearing moves smoothly onto the side already
requested by course geometry, withdraw only the duty skew before the fixed
middle-distance handoff. Reflection flips both signed observations, so their
agreement and release gate remain reflection equivariant. No clock phase,
world direction, route, or source-specific kinematics enters the policy.

The falsifiable expectation is to retain the parent's visible upstream route
separation and `8--12T` distance advantage while lowering its `16--24T`
normalized course error or projected miss, retaining capture and arrival no
later than the three `25.81--25.92T` comparisons, and not exceeding the
parent's load or actuator exposure. Reject the mechanism if response release
erases the early advantage, changes no commands before the parent's course
reversal, remains in the same high-miss late route, loses capture or coherent
wake structure, or increases joint/load peaks.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG steering and biological burst-turn response release
source_mechanism: retain asymmetric half-cycle propulsion only until observed body response has acquired the requested turn side, then release continuously into the traveling carrier
transferable_invariant: persistent body-frame route error may engage rhythmic asymmetry, but the asymmetry should withdraw when an independent normalized response observation shows that its immediate reorientation role is complete
nontransferable_details: published gains, dimensional frequencies, species envelopes, robot linkage geometry, prescribed clock phase, exact vortex phase, and task-specific trajectories
policy_translation: velocity-to-target course geometry owns the requested side; folded body-frame bearing supplies a reflection-equivariant response agreement; a smooth agreement gate releases only the far-field joint-angle-derived duty skew while all posterior, middle, terminal, and viability mechanisms pass through
falsification: reject on lost early route progress, unchanged or worse 16--24T course error/projected miss, slower-than-comparison capture, route-side reversal, incoherent wake, actuator contact, or load peaks above the assigned-parent regime

## Non-CFD audit after the policy edit

- Every direct `params.FIELD` reference is owned by the returned 67-field
  parameter object. The prescribed public-contract state returns two finite
  accelerations, and the candidate remained non-empty throughout the edit.
- A deterministic 1,458-state stress grid spanning lateral reflections,
  far/middle/near target vectors, zero and nonzero translation, positive and
  negative closing response, and beyond-limit joint states remains finite and
  within the `30 rad/T^2` envelope. Every paired reconstructed parent-trace
  reflection has exactly zero numerical command error.
- Re-evaluating the assigned parent and candidate on all 4,638 reconstructed
  parent-trace states changes 983 post-guard command pairs, including 675 by
  more than `0.05 rad/T^2`; maximum separation is about
  `4.4537 rad/T^2`. Activation spans `0.429--18.095T` and
  `12.340--4.718L`, while the candidate's frozen-state peak remains the
  parent's `29.86795 rad/T^2`. No reconstructed state inside the established
  middle or capture corridor changes. This demonstrates a material bounded
  response-release test, not CFD evidence of improvement.
- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this ChatGPT account. Its three prescribed checks were
  run directly: the material-guidance check, Julia public-contract check, and
  solver editable-boundary check all pass. No formal CFD was run.
