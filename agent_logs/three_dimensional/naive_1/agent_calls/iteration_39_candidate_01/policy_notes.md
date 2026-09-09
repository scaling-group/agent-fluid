# Step 39 multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled episodes satisfy the frozen experiment contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window transport, and capture
  termination. The two executable-identical common-envelope redistribution
  policies capture at `18.8265--18.8815T` with score-defined mean distance
  `2.08855--2.08896L`. The clean-envelope sample captures sooner at
  `18.6010T` but has mean distance `2.09042L`; that one arrival difference is
  not a semantic improvement over the replicated redistribution band.
- I inspected both the top-down vorticity and oblique Lambda2 rows in the
  combined sheets for the best-score redistribution capture and the fastest
  clean capture. Both start in quiescent fluid, develop energetic alternating
  target-bending streets, and retain compact bilateral and caudal 3D
  structures through first crossing. With zero background flow, their finite
  translation is self-propelled. No sampled sheet shows wake collapse,
  collision, instability, or domain exit.
- I compared those captures with the inherited common-allocator failure in
  both visual rows. Its early top-down wake is weak and smeared, its oblique
  structures remain short and poorly organized, and it turns sharply off
  route before a `9.713T` left-domain exit. Metrics agree: mean speed falls
  from `0.6874U` in the best sampled capture to `0.2721U`, anterior amplitude
  falls from `0.527` to `0.342 rad`, and distance improves only from
  `12.3277L` to `11.5298L` before finishing at `11.7998L`. Its lower rate and
  acceleration contact is therefore propulsion loss, not useful relief.
- The sampled rearward-route multiplier captures at `18.9640T` and mean
  distance `2.09072L`, but its target remains forward throughout the rollout,
  so the new branch is not exercised. Its demand and loads overlap the plain
  carrier: `61.17%/73.00%` acceleration contact,
  `10.90%/14.73%` rate contact, and peak planar force/moment
  `0.03125/0.01640`. Non-interference by a dormant channel is neither recovery
  nor improvement.
- The assigned parent's replacement of yaw-response release with
  bearing-window-progress release also retains capture (`18.7660T`) but
  worsens mean distance to `2.09589L`, lowers mean speed to `0.6840U`, and
  raises peak moment to `0.01697`, outside all four current samples'
  `0.01603--0.01656` band. Thus target-bearing progress is useful as a
  diagnostic but is not supported as a wholesale release variable around this
  carrier. The new candidate does not stack another recovery, response,
  terminal, flow, velocity, or actuator-allocation channel.

## Structured bookshelf transfer

```text
bookshelf_consulted: true
source_domain: Taylor/Lighthill traveling-wave propulsion and closed-loop robotic-fish target-curvature control, used as a preservation check rather than a source of new gains
source_mechanism: retain a directed posterior-lagged traveling bend while bounded body-frame target geometry supplies non-inverting mean and half-cycle curvature
transferable_invariant: preserve the observed joint-state traveling-wave carrier and let persistent normalized target geometry own steering sign; do not retain an added feedback channel merely because it is bounded
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, world coordinates, task-specific routes, and behind-target maneuvers
policy_translation: adopt no new shelf primitive; remove the unexercised rearward multiplier and restore the sampled common-envelope redistribution policy with yaw-response release, differential curvature, posterior lag, and independent final acceleration projection unchanged
falsification: reject the carrier's preferred status if a new executable-equivalent rollout misses capture or loses either coherent wake row; do not call the simplification an improvement unless it retains capture and the `2.08855--2.09222L` route band without worse load or saturation semantics
```

## Exactly one candidate hypothesis

Materialize one simplified common-envelope redistribution candidate. Remove
only the prefilled rearward-target route multiplier and its parameter; retain
the evidenced lateral-direction-cosine route request, one-sided correcting-yaw
release, anterior-displacement half-cycle steering, common envelope
redistribution, differential curvature shares, posterior lag, and independent
final acceleration projection exactly.

Expected result: reproduce the self-propelled capture topology and coherent
two-view wake of the two executable-identical sampled carriers while avoiding
an unsupported dormant recovery channel. This is an evidence-backed
architecture simplification, not scalar gain tuning. It adds no explicit time,
step, world coordinate, memorized route, mutable state, or new actuator demand.
Formal CFD runs only after handoff, so no outcome is claimed for this
unevaluated materialization.
