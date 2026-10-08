# Approach-gated course-authority candidate

## Pre-edit evidence diagnosis

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics, and capture
  at `0.745-0.748L` after `16.258-16.269T`. Both the top-down vorticity row and
  oblique Lambda2 row show self-propulsion, not advection: a coherent
  alternating wake is visible by `4T`, remains compact and three-dimensional
  through `12T`, and follows the body to capture. The informative inherited
  upper-exit failure also retained a coherent wake, so route response rather
  than wake production was the semantic defect repaired by the established
  target-versus-course redirect.
- The four current trajectories are visually almost identical until the final
  approach. The assigned zero-bend hold captures at `16.269T` with score
  `-0.066867` and low terminal loads, while retaining the posterior mean bend
  improves that hold to `-0.066497`. Selective anterior damping plus
  posterior-wave attenuation preserves the mean bend and is the strongest
  sampled result: capture at `16.258T`, score `-0.066121`, terminal speed
  `1.047U`, and the alternating wake intact. This is the scaffold to preserve.
- The inherited combined allocator-plus-approach rollout is a concrete
  non-additivity result. It captures earlier at `16.225T`, but regresses to
  `-0.067754` and crosses at `0.749L`, worse than the standalone mean-first
  allocator (`-0.066284`) and standalone selective approach relief
  (`-0.066121`). Its route already follows the allocator parent at the `5L`
  and `2L` landmarks, so another stacked far-field allocation change is not
  supported.
- The remaining useful discrepancy is approach-local inertial slip. In the
  strongest rollout at the `1.2L` landmark, body-frame target bearing is
  `-0.182 rad` while course angle is `-0.554 rad`. The cruise law's fixed
  `0.55` course weight gives only about `+0.123 rad` of course-corrected error,
  whereas full target-versus-course mismatch is about `+0.37 rad` (the
  reliability-weighted response error is `+0.335 rad`). This occurs after a
  robust capture route exists and inside the already evidenced approach
  neighborhood; it does not justify changing the carrier or far-field
  redirect.

## Policy hypothesis

Start from the strongest sampled selective-relief policy. Preserve its
state-feedback oscillator, posterior lag, response-gated redirect,
attenuation-only opposing-lobe relief, and proximity-plus-closing drive relief.
Add one bounded mechanism: as that same approach gate opens, continuously
raise the course term in the cruise steering residual from its evidenced
partial weight to full target-versus-course weight. This adds approach-local
slip correction without moving either joint's equilibrium, increasing the
redirect curvature limit, introducing beat-scale yaw feedback, or changing
the policy at distances at or above `1.75L`.

The expected result is the same coherent transit and wake through `1.75L`,
followed by better course alignment during the last crossing while selective
wave relief retains propulsion. Falsify the mechanism if capture is lost or
later than `16.258T`, score fails to beat `-0.066121`, the trajectory changes
before the approach gate, or near-target limiting/load increases materially
without an earlier or better-aligned crossing.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish path following and terminal capture control
source_mechanism: retain a traveling-bend carrier while increasing bounded body-frame slip correction only during reliable near-target closing
transferable_invariant: separate propulsion from route feedback and strengthen course alignment only when observed proximity and closing response establish the terminal regime
nontransferable_details: published gains, species-specific kinematics, prescribed phases, dimensional approach distances, exact vortex phases, and task-specific routes
policy_translation: normalized body-frame target distance and target-aligned velocity open the existing approach gate, which blends partial cruise course weight toward full target-versus-course feedback while leaving the two-joint carrier and bounded mean bend unchanged
falsification: reject if pre-approach motion changes, coherent wake or capture is lost, arrival or score regresses, or added course authority merely raises limiting and loads without improving the crossing
