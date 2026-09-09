# Wake-policy candidate diagnosis

## Evidence read before the edit

All four sampled episodes report direct uniform initialization with
`U_infinity=[0,0,0]`; none is a prewarm artifact. The assigned parent
`solver_2e1178a92e4c` is the alignment-gated bounded-curvature carrier. It is
finite and self-propelled but misses at `2.443L`, has mean/final distance
`8.443/9.193L`, and exits the lower boundary at `31.097T`.

The combined top-down/oblique sheets for the best sampled local approach
`solver_d9966baa11e1` and the informative response-gated failure
`solver_fe524b5f52e2` show the same long, coherent alternating 3D wake. The
fish translates under its own powered gait, approaches on a shallow diagonal,
then curls into a nearly vertical downward course without wake collapse or
numerical instability. Thus the lower exit is a steering-response failure,
not advection or weak propulsion.

Cross-checking the trajectories sharpens that diagnosis. The parent's closest
approach occurs at `17.869T` with acute bearing `1.421 rad`, bearing-window
rate `+2.36 rad/T`, head-distance closure only `0.009 L/T`, and yaw rate
`2.04 rad/T`. Its anterior/posterior acceleration clamps on `0.746/0.354` of
samples. Cross-track/closure-gated posterior-wave attenuation changes the
minimum only to `2.429L`, worsens mean distance to `8.454L`, preserves the same
lower exit, and leaves clamp residence at `0.748/0.358`. The approach-localized
opposite-sign posterior S-bend reaches only `2.536L` and likewise exits low.
Full-direction steering reaches `2.494L`. These completed variants reject more
posterior thrust scheduling or another posterior redirect gate as the next
clean test.

## Candidate hypothesis

Preserve the parent's traveling-bend carrier, posterior lag, alignment gate,
and far-field mean-curvature steering. Add one reflection-equivariant terminal
response mechanism: when head-distance closure collapses inside a soft
distance envelope, feed the signed recent bearing trend back against the
primary mean-curvature request. A rapidly worsening bearing therefore brakes
or briefly reverses the turn before the head sweeps past the target, while an
improving trend restores steering continuously. This acts on steering rather
than propulsion and becomes negligible outside the approach region.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal capture control
source_mechanism: sensor-feedback modulation of a rhythmic carrier with near-target yaw damping
transferable_invariant: preserve the propulsive rhythm while a bounded measured response term reduces steering authority during a fast terminal sweep
nontransferable_details: published gains, robot geometry, species kinematics, dimensional timing, exact vortex phase, and prescribed routes
policy_translation: multiply normalized signed `bearing_window_rate` by soft body-frame distance and measured head-closure-deficit envelopes, then subtract it from the primary mean-curvature error; leave the lagged posterior wave formula unchanged
falsification: reject if far-field progress or wake coherence degrades, command-limit residence increases materially, or the rollout retains the lower exit without beating the sampled `2.429L` minimum and its distance integral

The formal CFD result is not available to this worker. The candidate is a
single mechanism test, not a claim of improvement.
