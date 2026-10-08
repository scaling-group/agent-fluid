# Wake-policy candidate notes

## Inherited evidence and visual diagnosis

- All four sampled rollouts are valid direct-uniform still-water trials with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Their motion is therefore
  self-propulsion rather than ambient advection.
- The prefilled bearing-plus-trend parent preserves the naive traveling carrier.
  Its top-down row shows an alternating signed-vorticity street and its oblique
  row shows a corresponding three-dimensional Lambda2 trail, but the path and
  wake turn upward late. It improves monotonically only to `9.141L` and exits
  at the upper boundary after `13.129T`; coherent thrust is useful, while
  target containment is not.
- The strongest sampled controller replaces bearing trend with body-frame
  lateral-slip feedback on the same posterior mean-curvature actuator. Both
  visual rows retain a coherent wake through a much longer `26.637T` rollout.
  It moves the head from `(20.575,13.741)L` to a closest point
  `(9.737,12.367)L` at `17.699T`, reducing distance from `12.328L` to
  `2.960L`. This is a material useful-trajectory improvement over the parent,
  although it remains about `2.87L` above the target, then passes the target in
  x, turns upward, and exits with final distance `7.786L`. The visible late
  hook agrees with the metric rise after the minimum; this is approach
  overshoot, not loss of propulsion.
- The phase-referenced yaw-residual sample is a genuinely different but
  negative result. It contains y to `13.816--14.293L` and retains alternating
  vorticity/Lambda2 shedding, yet reaches only `4.361L`, passes far beyond the
  target, and exits the left boundary at `26.329T` with final distance
  `9.921L`. Removing a fitted beat-synchronous yaw proxy therefore changes the
  trajectory but does not supply the missing downward approach. The sampled
  opposing-half-cycle relief also repeats the parent's upper exit and only
  reaches `9.855L`; neither mechanism should be repeated as a gain edit here.

## Policy hypothesis

Use the sampled lateral-slip controller as the demonstrated far-field carrier,
then add one new mechanism: a continuous distance-conditioned carrier envelope.
Outside `4L`, the anterior oscillator and posterior traveling target are exactly
the useful slip-feedback policy. Inside that region, a bounded nonlinear scale
reduces the anterior limit-cycle amplitude and the posterior oscillatory carrier
together, but leaves the bounded bearing/slip mean-curvature term available.
This should reduce the excess forward and lateral momentum that carried the best
sample past the target while increasing steering authority relative to the beat.
It uses only normalized body-frame state and target distance; it has no clock,
route, target identity, or mutable mode.

The next rollout should preserve the coherent far-field wake and reach the
sampled controller's approach region, then show reduced speed and a tighter
downward turn instead of crossing x near `3L` above the target. Falsify the
mechanism if drive relief begins before useful leftward progress is established,
collapses the wake and stalls outside capture, increases joint-limit occupancy,
or still passes the target and exits without beating `2.960L` or improving the
termination class.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG path following and terminal target approach
source_mechanism: preserve a rhythmic traveling carrier far from the target, then continuously reduce carrier drive as observed target distance closes while geometric feedback retains steering authority
transferable_invariant: a near-target approach regime should shed excess locomotor drive without disabling target-directed steering, and the regime must be scheduled from observed normalized geometry rather than time or a memorized route
nontransferable_details: published gains, dimensional approach distances, species-specific envelopes, clock phase, exact vortex phases, and task-specific routes
policy_translation: apply a bounded nonlinear scale from `state.distance_L` to both the anterior oscillator amplitude and posterior carrier component, while retaining the sampled body-frame bearing-minus-lateral-slip mean curvature
falsification: reject if far-field propulsion changes, the coherent wake collapses before approach, the fish stalls outside capture, actuator occupancy worsens, or the same pass-and-exit topology remains without a closer approach or better termination
