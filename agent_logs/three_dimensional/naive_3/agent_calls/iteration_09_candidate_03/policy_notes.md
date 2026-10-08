# Candidate diagnosis and hypothesis

The four sampled evaluations are valid direct-uniform still-water rollouts
(`U_infinity=0`) and all terminate by leaving the upper virtual boundary. The
top-down sheets show self-propelled motion with coherent alternating wakes;
the oblique Lambda2 sheets confirm that these are three-dimensional shed
structures rather than imposed-flow advection. The strongest sampled closest
approaches are the full-quadrant static and response-released redirects
(`2.999L` and `2.989L`). Both follow the useful carrier trajectory to about
`y=12.35L` at `16T`, but their wakes fade as the joints slow after the pass;
the static redirect has mean absolute joint rates near `0.001/0.001 rad/T`
after `18T`. The distance hold likewise coasts with rates near
`0.023/0.016 rad/T` and reaches only `3.592L`.

The prefilled anterior half-cycle controller provides the complementary
failure. Its alternating wake and `2.623/2.691 rad/T` post-`18T` joint rates
survive, but it is already about `1.36L` too high at `16T` compared with the
static/response redirects, reaches only `4.859L`, and sends roughly
`64.8%/69.4%` of post-`18T` raw acceleration commands beyond the envelope.
Thus continued cycling alone is not corrective authority, and anterior
stiffness asymmetry corrupts the useful broad descent. The inherited parent
log also reports another `left_domain` result with `2.976L` minimum and
`6.828L` final distance, supporting the repeated pass-and-hook topology but
not identifying a new successful mechanism.

The candidate preserves the zero-centered, undamped anterior Van der Pol
carrier and the demonstrated bearing-minus-slip posterior mean curvature. It
adds a late full-quadrant posterior phase-lag modulation only when target error
is large. Observed anterior joint velocity supplies beat phase; target-signed
lag asymmetry adds curvature during the fast portion of each stroke without
moving either oscillator center or attenuating the carrier. Recent measured
yaw scales this modulation up for wrong-way response and releases it for
corrective response. This is intended to leave the broad approach unchanged,
retain a coherent wake, and create a distinct post-pass recovery arc.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning
source_mechanism: closed-loop modulation of inter-joint phase for asymmetric turning
transferable_invariant: preserve the propulsive rhythm while target error modulates relative posterior timing, and release extra steering when the measured turn becomes corrective
nontransferable_details: published gains, clock-driven oscillator phase, robot geometry, species kinematics, exact vortex phase, and task-specific paths
policy_translation: map normalized full-quadrant body-frame target geometry and lateral slip to a bounded turn request; use observed anterior velocity as phase; modulate posterior lag only for large error, scaled by recent yaw response, while leaving the anterior carrier and mean tail channel intact
falsification: reject if broad descent or alternating wake is lost, raw limit occupancy materially worsens, closest approach does not beat the `2.960L` reference, or the upper exit repeats without a distinct recovery arc

