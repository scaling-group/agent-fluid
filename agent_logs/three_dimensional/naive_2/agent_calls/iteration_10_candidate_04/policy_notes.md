# Candidate wake-policy diagnosis

## Evidence read before the edit

All four sampled evaluations satisfy the direct-uniform still-water contract:
`initialization_mode=uniform_direct`, background velocity `(0,0,0)`, finite
dynamics, and `left_domain` termination. The top-down row of each combined
sheet shows an alternating vortex street that persists to the last frame; the
oblique row shows tail-connected three-dimensional Lambda2 structures through
the late bend. The fish are therefore self-propelled rather than advected, and
none fails because its traveling-wave carrier or wake collapses.

The strongest sampled approach is the closure-conditioned posterior-wave
relief (`solver_37a652a3989e`): it reaches `4.162L` at `17.51T`, with speed
`0.824U`, bearing about `-0.969 rad`, target-versus-velocity course error about
`-1.257 rad`, and essentially zero closure, then recedes to `6.363L` and exits
above the target. The unrelieved three-degree redistribution prefill
(`solver_c0a67102cc0a`) reaches `4.419L` with course error already saturated at
`-pi/2`, `+0.447U` body-frame lateral velocity, and `0.834U` speed. Smooth
distance-only carrier relief (`solver_4482d3d05d9c`) reaches only `5.126L`.
Both visual rows agree with the trajectories: the organized wake continues,
but from approximately `12T` the path remains near `y=13--14L` while the target
is at `y=9.5L`.

The sampled response-gated half-cycle policy (`solver_963e74a3f179`) is the
most informative mechanism failure. It improves final distance to `5.918L`
and lowers near-soft-limit acceleration residence to `62.1%`, versus `6.383L`
and `72.7%` for the prefill, while retaining comparable peak force and moment
(`0.03276`, `0.01729`). But it worsens the minimum to `5.000L`, arrives there
with course error at `-pi/2`, and follows the same upper-exit topology. Thus
attenuating a posterior half-cycle from speed-qualified course error alone
trades approach for lower effort; it does not establish useful route authority.
The inherited sign-consensus variant partially repairs that trigger error
(`3.580L` minimum versus `5.000L`) but still exits high at `6.629L`, so another
scalar increase in attenuation is not supported.

## Single candidate hypothesis

Preserve the prefill's full anterior Van der Pol carrier, posterior state lag,
body-frame bearing, course, relative-crossflow and yaw feedback, bounded mean
tail curvature, and smooth acceleration envelope. Add one posterior
wave-shape mechanism instead of another drive-relief or attenuation gain:
form a turn request only when bounded bearing and speed-qualified course error
agree in sign, then apply a signed curvature pulse at the observed anterior
bend peaks. The pulse is zero at the carrier center crossing, releases with
course alignment or bearing/course disagreement, and is directionally capped
by the remaining posterior target-angle reserve. It can therefore increase
the useful-side bend or reduce the opposing-side bend without moving the
anterior oscillator equilibrium, imposing a clock, or pushing the inherited
baseline target farther past the soft posterior reserve reference.

The expected semantic change is earlier downward translation once bearing and
course agree from the mid-route onward, while preserving the sampled early
transit and coherent wake. Falsify the mechanism if minimum distance is not
better than the `4.162--4.419L` full-carrier comparisons, course error and
lateral slip remain large near closest approach, or the same upper exit
persists without a materially better final distance. Also reject it if the
traveling wake weakens, maximum joint speed exceeds the sampled `4.538 rad/T`,
near-limit acceleration residence exceeds the prefill's `72.7%`, or peak force
and moment materially exceed `0.0328` and `0.0173`.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and asymmetric-flapping turning
source_mechanism: preserve the propulsive oscillator while applying target-response-driven curvature asymmetry at observed bend phase
transferable_invariant: separate the slow body-frame route request from joint-state beat phase, apply extra posterior curvature only when route geometry and translational response agree, and release it continuously as alignment returns
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, clocked CPG phase, exact vortex phase, maneuver duration, and task-specific routes
policy_translation: combine bounded body-frame bearing with speed-gated target-versus-velocity course error; their sign consensus drives a q1-state-phased posterior curvature pulse whose signed magnitude is limited by available posterior target-angle reserve while the anterior carrier and baseline posterior mean remain intact
falsification: reject if early transit or the alternating 3D wake degrades, closest approach does not improve, downward course response remains delayed, upper-boundary exit persists without better recession, or joint speed, acceleration residence, force, or moment exceed the sampled boundaries

## Non-CFD algebra audit after the edit

Replaying only the new observation-to-pulse algebra on all four completed trace
histories gives mean absolute redirects of about `0.0060--0.0064 rad` above
`8L`, `0.0230--0.0324 rad` from `5--8L`, and about `0.038 rad` below `5L`
for the two full-carrier histories that materially entered that band. The
largest reconstructed redirect is `0.1002 rad`, below its `6 deg` bound. The
directional reserve prevents the new term from pushing an already exhausted
target farther outward; the inherited baseline target can itself exceed the
new `43 deg` reserve reference, and is intentionally left unchanged. This
replay checks sign, localization, and boundedness only. It cannot establish a
trajectory, wake, load, or score improvement before the later CFD evaluation.
