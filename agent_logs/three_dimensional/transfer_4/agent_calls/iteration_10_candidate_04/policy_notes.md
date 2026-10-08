# Course-qualified line-of-sight route residual

## Visual and quantitative diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen-flow contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no prewarm snapshot,
  no cylinders, and capture termination. There is no semantic failure in this
  sample, so I used the weakest captured mechanism as the informative negative
  control rather than inventing a failure class.
- I inspected both rows of the combined keyframe sheets for the strongest
  error-qualified line-of-sight policy and the weakest mean-curvature-only
  line-of-sight policy. The top-down rows show self-propulsion from rest and a
  coherent alternating wake along target-directed trajectories. The oblique
  Lambda2 rows retain compact three-dimensional posterior structures through
  capture. Neither shows passive advection, wake collapse, collision, or
  out-of-plane instability, so route geometry and control allocation—not wake
  existence—explain the useful differences.
- Qualifying the inherited line-of-sight residual by current body-frame target
  error and fading it to zero before `2.1L` is a positive result. Relative to
  the unqualified residual, score improves from `-0.08710319` to `-0.08139542`,
  arrival from `17.8750T` to `17.7265T`, mean distance from `1.973290L` to
  `1.967391L`, center path from `12.9663L` to `12.8468L`, and maximum
  cross-track from `0.5454L` to `0.5120L`. Approach mean/final course alignment
  improve from `0.8137/0.1134` to `0.8993/0.6010`, final yaw magnitude falls
  from `3.153` to `0.901 rad/T`, and near posterior acceleration-ceiling
  residence falls from `72.67%` to `68.69%`. Both wakes remain coherent.
- Two sibling allocations bound the next edit. Sending the route residual only
  to posterior mean curvature delays capture to `18.6175T`, lengthens path to
  `13.6033L`, worsens score to `-0.09127794`, and ends with negative course
  alignment (`-0.530`). Adding a terminal course-angle correction to the
  unqualified observer is nearly neutral-to-negative (`-0.08868138`, final
  alignment `0.109`). Therefore preserve the successful residual through the
  full existing mean-curvature plus half-cycle steering path, and do not add
  another terminal correction.
- The remaining measured opportunity is far/middle rather than terminal. At
  the error-qualified policy's maximum `0.5120L` cross-track near `6.73L`
  distance, its measured course alignment is already `0.9818`; at `4L` it is
  `0.9427`. A target-error gate alone can therefore retain route-observer
  authority while the actual velocity is already on an intercept, spending
  steering authority on body recoil rather than a useful course change.

## One policy hypothesis

Preserve the strongest sampled posterior-priority traveling carrier, bounded
odd curvature mapping, error- and distance-qualified line-of-sight observer,
full mean-curvature plus half-cycle steering allocation, approach controller,
and reversal-preserving rate governor. Add one finite-speed course-validity
gate only to the line-of-sight residual: form the normalized signed cross angle
between body-frame target and body-frame velocity; retain full observer
authority at low speed, for a reversed course, or while course error is large;
and smoothly release that residual when velocity is already target-aligned.
Ordinary body-frame geometry and yaw-rate feedback remain active, so this is
not coasting and does not weaken the propulsive carrier.

Expected evidence is preservation of the parent's early distance and capture
gain with less unnecessary midcourse steering: retain capture near the
`17.73T` scale, mean distance near or below `1.9674L`, parent-like two-view wake
coherence and approach alignment, while reducing path/cross-track or control
load. Falsify the gate if it erases the early line-of-sight benefit, delays
capture materially, increases maximum cross-track, remains suppressed on a
reversed or visibly misaligned course, degrades terminal alignment, or changes
the posterior traveling wake.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and target-relative pursuit control
source_mechanism: preserve a rhythmic propulsive carrier while granting a slow route residual authority only when measured motion still needs course correction
transferable_invariant: body-frame target error alone does not prove that steering is needed; at finite speed, release the residual continuously when normalized velocity already lies on the target line while retaining ordinary geometry feedback
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, target coordinates, fixed routes, and source-specific switching thresholds
policy_translation: multiply only the existing error- and distance-qualified line-of-sight correction by a smooth body-frame target-to-velocity course-error gate that defaults to full authority at low speed or on a reversed course
falsification: reject if capture, early distance integral, path, cross-track, load, reflection behavior, terminal alignment, or either top-down or oblique traveling-wake coherence worsens materially
