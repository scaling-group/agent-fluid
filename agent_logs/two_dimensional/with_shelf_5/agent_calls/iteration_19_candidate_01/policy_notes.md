# Wake-policy candidate notes

## Evidence diagnosis

The shared prewarm sheet shows the held fish above and downstream of four
fully developed, interacting vortex streets.  Released sheets for all four
sampled policies show the same useful topology: an immediate target-directed
redirect from the upper-right release pose, then a clean diagonal transit into
the `0.75L` target circle without collision, domain exit, or terminal
overshoot.  The sampled set contains no failure; the informative inherited
baseline is the target-blind seed's lower-boundary exit after `50.127` released
time.  Accordingly this candidate preserves the demonstrated bearing-directed
carrier rather than adding an unevidenced wake residual.

The prefilled controller reaches in `39.1104` with mean distance `1.91494L`,
RMS relative crossflow `0.21935`, RMS force/moment `57.21/783.64`, and command
energy `50060.66`; both joint rate and acceleration caps are reached.  Releasing
only auxiliary half-cycle steering after observed convergence retains exactly
the `39.1104` arrival and reduces force/moment to `54.19/754.87`, but does not
improve crossflow or score.  On that same response selector, additionally
releasing stale route history improves arrival to `39.0499`, mean distance to
`1.91369L`, relative crossflow to `0.21683`, and command energy to `49942.82`,
while returning force/moment to `57.05/783.02`.  The only missing factorial
condition is route-history release with the auxiliary half-cycle authority
left intact.

## Policy hypothesis

Compute the already-demonstrated convergence/alignment response from current
body-frame bearing and `bearing_window_delta`.  Use it only to fade the lagged
circular-history offset in anterior route curvature; keep current bearing,
oscillator amplitude/phase, and posterior half-cycle steering unchanged.  At
release, or whenever error is large, stationary, or diverging, the response is
zero and the evaluated parent is reproduced.  This isolates whether stale
route memory causes the small transit/crossflow penalty without conflating it
with the known load-reducing withdrawal of posterior authority.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and biological burst redirect
source_mechanism: release a strong redirect contribution after observed heading response while preserving the propulsive rhythm
transferable_invariant: persistent route error and observed response should have separate bounded roles; once current target alignment is improving, stale route memory need not keep biasing mean curvature
nontransferable_details: published gains, species-specific burst kinematics, clocked CPG phase, dimensional frequencies, exact vortex phase, and task-specific routes
policy_translation: form a continuous response gate from normalized body-frame bearing and its observation-window change, and apply it only to the circular-history curvature offset in the two-joint state-feedback policy
falsification: reject the mechanism if it loses direct capture, delays arrival beyond the parent class, raises force/moment above the parent class, leaves crossflow and route metrics unchanged, or changes the large-error redirect topology
