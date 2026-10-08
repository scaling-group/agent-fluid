# Wake-policy candidate notes

## Evidence read before editing

- The assigned parent and all four sampled evaluations use direct uniform
  still-water initialization (`U_infinity=(0,0,0)`), no cylinders, and no
  prewarm. Their translation is self-propulsion, not ambient advection.
- The top-down and oblique rows of every combined sheet show the useful common
  carrier: an alternating signed-vorticity street and persistent three-
  dimensional Lambda2 structures accompany leftward travel through roughly
  `12T`. This is a stable propulsive wake, so the candidate should not replace
  its zero-centered anterior oscillator or lagged posterior wave.
- The highest-score sample is the assigned-parent approach hold (`-7.749`),
  but it reaches only `3.592L`. Its joints decay toward `(0,-12) deg`, its wake
  weakens, and it coasts near `0.73U` into the upper boundary. The full-
  quadrant static redirect and response-released redirect preserve the same
  visible high hook and reach `2.999L` and `2.989L`, respectively, before the
  same `left_domain` termination. Thus neither carrier damping, freed reserve,
  nor a settling C-like posture creates corrective work.
- The response-released sample is the clearest post-pass failure. It reaches
  `2.989L` at `17.66T`, but full-quadrant bearing is about `-1.35 rad` by
  `18T` and `-2.13 rad` by `20T`; mean motion then continues upward to the
  boundary. Its raw heading rate oscillates near `+/-3 rad/T` with the beat,
  so the positive-only instantaneous-yaw gate alternately suppresses the
  redirect and becomes nearly inactive as the joints settle.
- Two later half-cycle mechanisms do not rescue this topology. The sampled
  anterior stiffness-asymmetry policy reaches only `4.859L`, still exits high,
  and raises any-joint raw acceleration exceedance to about `87%`. The
  inherited response-gated half-cycle candidate reaches `3.264L`, finishes at
  `6.550L`, and also remains `left_domain`. More turn-side half-cycle shaping
  is therefore not supported by the completed evidence.
- Joint-phase reaction is consistent enough to expose a slower yaw residual.
  Least-squares fits over `4--16T` in the four sampled traces give
  `heading_rate ~= -(0.72--0.79)phi_dot1 -(0.13--0.18)phi_dot2`; subtracting
  that carrier component leaves near-zero mean residual during `4--12T`, then
  a persistent wrong-way residual of about `-0.12` to `-0.23 rad/T` after
  `16T` in the non-half-cycle redirects. Unlike raw yaw sign, this residual
  distinguishes beat reaction from the unrecovered upper hook.

## Policy hypothesis

Keep the evidenced zero-centered Van der Pol carrier, posterior lag, and
full-quadrant bearing-minus-body-slip curvature. Add one phase-referenced
target-yaw servo: estimate slow body yaw by cancelling the repeatable
joint-rate component from measured heading rate, set a small desired yaw rate
with the opposite sign of the bounded body-frame turn request, and map the
bounded rate error to an additional posterior curvature channel. The
oscillator center and carrier amplitude remain unchanged, and stalled yaw
still produces correction because the servo compares against a nonzero target
rate rather than using a positive-only gate.

The next rollout should reproduce the early coherent wake and broad approach,
then change the post-pass residual from negative to positive for a negative
turn request and form a recovery arc instead of an upper hook. Falsify the
mechanism if phase cancellation amplifies beat noise, raw acceleration-limit
occupancy materially exceeds the response-redirect reference, early progress
or wake coherence degrades, or the run fails to beat the `2.960L` broad-
approach reference and repeats `left_domain` without a distinct recovery.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking
source_mechanism: separate the rhythmic carrier state from slower directional feedback and modulate steering from measured direction-response error
transferable_invariant: preserve the traveling propulsive rhythm while comparing a carrier-referenced body response with a target-relative desired turn rate
nontransferable_details: published controller gains, species-specific kinematics, dimensional beat frequencies, exact vortex phases, and task-specific routes
policy_translation: use normalized full-quadrant target_body_L and body-frame slip for turn request, observed joint rates to remove the evidenced carrier component from normalized heading_rate, and a bounded posterior curvature residual for target-yaw error
falsification: reject if the coherent early wake or progress is lost, phase cancellation increases beat-scale switching or actuator-limit occupancy, or post-pass bearing and termination topology do not improve
```

## Non-CFD command audit

Replaying the candidate algebra on the recorded states (without advancing the
fish or flow) gives any-joint raw acceleration exceedance of about `52--57%`
on the three non-half-cycle samples, versus their measured `54--59%` range.
The added posterior mean curvature stays within `[-18,+15] deg` on those
states, and the correction remains strongly available after `16T`, when the
inherited response redirect settles. This is only a source-level effort check;
it does not predict the unevaluated candidate's trajectory or CFD result.
