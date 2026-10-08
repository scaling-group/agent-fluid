# Wake-policy candidate diagnosis

## Evidence read before editing

All four sampled rollouts report direct uniform still-water initialization
with `U_infinity=[0,0,0]`; none is a prewarm artifact. I inspected both rows of
each combined keyframe sheet. The top-down rows show self-propelled motion and
a persistent alternating vorticity street after release, while the oblique
rows show compact paired three-dimensional Lambda2 structures shed behind the
body. The failure is therefore route control, not advection or failure to form
a propulsive wake.

The assigned parent is the prefilled `solver_4482d3d05d9c`. Its coherent wake
survives through the `20.861T` upper-boundary exit, but the trajectory reaches
only `5.126L` before receding to `5.885L`; at `16T` the head is already at
`y=14.025L`, and by `20T` it is at `y=15.067L`. The matched undamped
course-redirect branch `solver_c0a67102cc0a` retains essentially the same wake,
reaches `4.419L`, and survives to `23.260T`. Thus the parent's distance-only
carrier-amplitude relief degraded both closest approach and survival without
changing the upper-escape topology. The informative `solver_27482c381d38`
failure shows that an approach-relaxed anterior lever capped at four degrees
can instead reach `3.135L` and survive to `30.113T`, but it still passes the
target and leaves upper-left. Across these stable rollouts, peak joint speed
remains about `4.54 rad/T`, peak soft-limited acceleration about `31.4
rad/T^2`, and peak normalized lateral force/moment remain near `0.028/0.018`;
the candidate must not buy a redirect by destroying the carrier or increasing
those load scales.

## Candidate hypothesis

Restore the full evidenced traveling-wave amplitude. Add one new controller
mechanism: a bounded, response-gated anterior redirect. A large forward-target
body-frame bearing may shift the anterior oscillator center only while measured
recent yaw has the wrong sign for reducing that bearing; correct-sign yaw or a
passed target continuously releases the burst. Combine it with the existing
course redirect under one four-degree cap, and keep the posterior endpoint
target referenced to actual anterior angle so the maneuver redistributes
curvature rather than adding a static bend. This should intervene during the
late wrong-way yaw visible before the common upper exit while leaving correctly
responding beats and the far-field propulsive wave alone.

Falsify the mechanism if the rollout repeats an upper exit without improving
the parent's `5.126L` minimum, if it cannot at least retain the undamped
branch's `4.419L` approach, if survival falls below `20.861T`, or if joint speed,
soft-limit occupancy, force/moment peaks, or the alternating 3D wake show a
material deterioration. A useful result should reverse the post-approach upper
drift and ideally challenge the prior `3.135L` closest approach.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG steering
source_mechanism: response-gated burst redirect that releases back into a posterior traveling beat
transferable_invariant: transient steering authority should be bounded by target error and withdrawn when the measured body response has the correct sign, preserving the propulsive rhythm
nontransferable_details: published gains, species-specific C-start shapes, actuator layouts, clock phase, exact vortex phase, and task-specific routes
policy_translation: use normalized forward body-frame target direction, bearing, and recent yaw to gate at most four degrees of anterior oscillator recentering, preserve the full state-feedback carrier, and compensate through the actual anterior angle in the posterior target
falsification: reject if the upper-exit topology persists without closer approach, if correct-sign yaw does not release the redirect, or if propulsion, loads, saturation, or wake coherence worsen

## Pre-evaluation checks

Replaying the assigned parent's recorded body pose and velocity through the new
gate (without advancing CFD) predicts `-2.20 deg` anterior redirect at `16T`,
when bearing and recent yaw have the same, wrong-way sign; it releases to
`-0.06 deg` at `18T`, when yaw has the correcting sign. The largest replayed
redirect is `2.89 deg`, below the shared four-degree cap. This validates the
intended gate semantics, not its hydrodynamic outcome.

The guidance semantic check and editable-boundary check pass, and every direct
`params.FIELD` reference is declared by `target_policy_params()`. The pinned
check-runner agent could not start because its model is unavailable on this
account, and the declared Julia return-shape command could not run because this
workspace has no Julia executable. No formal CFD was run, as required.
