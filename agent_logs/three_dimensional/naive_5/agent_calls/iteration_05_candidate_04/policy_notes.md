# Sign-corrected course-allocation candidate

## Visual and trace diagnosis before the edit

- All four sampled evaluations are contract-valid direct-uniform still-water
  rollouts (`U_infinity=(0,0,0)`, no cylinders, and no prewarm), so the motion
  and wakes in both visual rows are self-generated rather than advection or a
  moving-window artifact. The top-down sheets show alternating caudal
  vorticity, and the oblique sheets independently show coherent three-
  dimensional Lambda2 trails.
- The prefilled assigned solver parent, `solver_aaab22dcaa09`, is the strongest
  sampled carrier. It retains a coherent wake to `38.671T`, holds the center in
  `y=13.753--14.271L`, and improves the sampled best minimum distance from
  `5.156L` to `4.676L`. It is not target controlled: closest approach occurs
  near `(9.535,14.226)L`, the target marker passes below the almost horizontal
  wake, and the fish exits left at `(0.800,13.990)L` with distance `9.796L`.
- The assigned guidance parent and inherited optimizer logs identify raw
  within-beat yaw closure as part of the long-range carrier but not a reliable
  slow turn estimate. The new samples sharpen that diagnosis into a steering-
  side calibration. Over the large-miss portion of their traces, the
  anterior half-cycle selectors in `solver_0334e73ca6df` and
  `solver_65e67137c3f9` average positive while the trajectories stay above
  `y=14.7L`; the course-biased `solver_12fc3441a636` also drives a positive
  selector and terminates at the upper margin near `(12.027,15.200)L` after
  only `20.790T`. By contrast, the response-sign inversion in
  `solver_aaab22dcaa09` produces a mean selector near `-0.23` from `12--30T`
  and is the only sample to lower the high corridor materially.
- That negative authority is still diluted by the gait-phase-rejected yaw
  residual: while the target/course miss becomes persistent, the parent
  selector averages only about `-0.20` to `-0.24`. Replaying observations
  without evolving the flow shows that a speed-gated blend of same-sign
  body-frame bearing and opposite-signed normalized course error would remain
  bounded but average about `-0.82` over `12--20T` and `-0.94` over
  `20--30T`. This is only a signal/command check, not claimed CFD evidence.
  The parent also spends about `56%` of samples above `250 deg/T` at one or
  both joints, so added propulsion or a larger scalar drive is unsupported.

## Policy hypothesis

Preserve the assigned parent's explicit symmetric phase pump, anterior soft-
angle headroom, state-feedback oscillator, and lagged posterior follower: this
is the only sampled combination that both sustains the long three-dimensional
wake and improves cross-track position. Replace only its residual-yaw steering
selector with one slow route signal. At low translational speed, use bounded
body-frame bearing with the steering sign evidenced by the parent. As course
becomes observable, blend continuously to the opposite of the normalized
body-frame velocity/target cross product. This removes beat-scale yaw from the
route allocation while retaining the phase pump that the two earlier direct-
geometry descendants lacked.

The expected signature is continued leftward propulsion plus a sustained
downward bend before the `x=9L` station, with the target marker entering the
wake corridor. Falsify this mechanism if it returns to the early upper curl,
loses the coherent alternating wake, repeats a high-`y` left exit without
beating `4.676L`, applies the wrong course-correction side, or increases the
already material angle/speed/acceleration limit residence.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking with asymmetric flapping
source_mechanism: preserve a rhythmic traveling carrier while a persistent route error allocates bounded authority to the turn-useful half-cycle
transferable_invariant: separate the propulsive rhythm from slow target-versus-course error and use measured response to choose the half-cycle sign
nontransferable_details: published gains, clocked CPG phase, robot linkage geometry, species-specific kinematics, dimensional cadence, exact vortex phases, and task-specific routes
policy_translation: infer phase from normalized anterior joint state, retain the evidenced symmetric pump and posterior lag, then blend body-frame bearing into the sign-corrected normalized velocity/target cross product as translation becomes observable
falsification: reject if the early upper curl returns, the long coherent wake collapses, the target stays outside the high-y wake corridor without a closer approach than 4.676L, the correction side is wrong, or actuator-limit residence increases
