# Candidate diagnosis and hypothesis

The four sampled evaluations are valid direct-uniform still-water rollouts
(`U_infinity=(0,0,0)`) and all capture at `0.7492--0.7499L` after
`18.45--18.75T`.  In the strongest and weakest scalar-score combined sheets,
the top-down row shows a sustained alternating vortex street from release to
capture and the oblique row shows bilateral Lambda2 structures without loss of
propulsion, coasting, collision, domain exit, or visible three-dimensional
instability.  Trace cross-checks agree: terminal inertial speed is
`0.827--0.858L/T`, peak body-force coefficients remain about
`0.0149/0.0292`, and peak yaw-moment coefficient is about `0.0165`.  The sheets
therefore do not support changing the carrier, cadence, or far-field route.

The sampled exact speed-reserve runs capture twice, but the assigned parent
guidance records a new exact-byte `1.4107L` lower exit, moving the accumulated
baseline record to `4/7`.  All four current capture traces keep the eight-row
history-window closing speed positive below `4L` (derived minima
`0.138--0.340L/T`), while head/tail actions still clamp on roughly
`68.5--68.8%/70.6--71.0%` of rows.  Thus the current evidence supports using
negative history-window closure only to isolate an already-missed pass; it
does not support more first-approach steering, scalar gain tuning, or a claim
that clipping is the cause.

The inherited progress-loss redirect detected a miss but held a two-joint
mean-curvature replacement until closure returned.  It reached only `1.2402L`,
entrained the realized joints, stopped forming a substantial new alternating
wake, and coasted out.  The proposed candidate instead leaves the evaluated
carrier, steering allocation, and intercept response untouched during every
sampled closing approach.  Only inside the outer terminal region, after
history-window closure becomes clearly negative, it adds a bounded posterior
target shift in the established turn direction.  The anterior oscillator and
base posterior traveling-wave target remain active.  The shift is released on
measured correct-sign phase-compensated yaw response rather than held until
distance closure recovers.  This is one recovery-burst mechanism, not a route
gain or cadence adjustment.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish turning and biological nonsteady redirect
source_mechanism: strong bounded curvature is applied transiently and released into the propulsive rhythm when measured turn response appears
transferable_invariant: preserve the traveling carrier, gate a redirect from normalized task geometry, and release it on observed correct-sign body response rather than elapsed time
nontransferable_details: published gains, species-specific C-start kinematics, dimensional burst duration, exact vortex phase, and task-specific routes
policy_translation: when normalized history-window closure is negative inside the terminal region, add one bounded target-signed posterior wave-shape shift while retaining the anterior oscillator; continuously remove it as the existing phase-compensated yaw-response gate rises
falsification: reject if the gate changes any sampled positive-closing first approach, loses capture, repeats the lower exit without a propelled second approach, weakens either wake, entrains static curvature, or worsens the speed-reserve actuator and load envelope
