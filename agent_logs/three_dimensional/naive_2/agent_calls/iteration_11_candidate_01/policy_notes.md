# Bearing-response release candidate

## Evidence diagnosis before the edit

All four sampled solver evaluations and the inherited completed rollouts use
direct uniform still-water initialization with `U_infinity=[0,0,0]`, no
cylinders, and no prewarm. The combined sheets show self-propulsion rather than
advection: their top-down rows develop alternating vortex streets and their
oblique rows retain tail-connected three-dimensional Lambda2 structures. The
missing capability is therefore route response, not carrier formation.

The best-score sample (`solver_4482d3d05d9c`) reaches only `5.126L` and exits
high at `5.885L` while spending about `70.3%` of its samples near the
acceleration soft limit. The assigned prefill (`solver_37a652a3989e`) retains a
similarly coherent wake and improves closest approach to `4.162L` at
`17.506T`, but then recedes to `6.363L` and leaves through the upper boundary;
near-limit residence is still about `66.0%`. Its approach-only benefit does not
validate closure-conditioned posterior-wave relief, because the inherited
full-wave approach-redistribution parent reached `3.135L`.

The inherited mechanism sequence also falsifies another early half-cycle gate
as the next edit. Proximity-gated posterior asymmetry nearly preserved the
`3.135L` full-carrier approach (`3.259L`) and lowered limit residence, but
receded to `7.016L`. Moving that asymmetry earlier with body-bearing/course
agreement reached `3.580L` and receded to `6.629L`; the next signed-agreement
variant degraded further to `4.743L`. A separate velocity-to-target/yaw-servo
branch exited at `15.681T` with minimum and final distance both `6.850L`.
Although its algebraic angle sign looked corrective and its near-limit
residence fell to about `52.4%`, the rollout shows that geometric sign alone
does not establish the hydrodynamic polarity of posterior steering.

Reconstruction of the available histories supports a response-release test.
Once forward translation is established, absolute short-window bearing rates
have medians near `1.75--2.00 rad/T` and 90th percentiles near
`2.94--3.18 rad/T`. In the assigned prefill, negative bearing is moving toward
center at both `8T` (`bearing=-0.468`, rate `+1.960 rad/T`) and `12T`
(`bearing=-0.136`, rate `+3.093 rad/T`), but the same signed route bias remains
active. By `16T` the bearing is moving away from center and the release should
be inactive. These are state-history diagnostics only; they do not claim a
counterfactual CFD improvement.

## Single policy hypothesis

Restore the complete posterior traveling wave and preserve the evidenced
anterior oscillator, four-degree transient course redistribution, original
course-brake polarity, bounded posterior mean, crossflow residual, yaw
rejection, and smooth acceleration envelope. Add one response modulation to
the slow posterior route component: after speed qualification, reduce that
component only while the signed short-window bearing trend shows that the
target is already moving toward the body centerline. A worsening or stationary
bearing receives no release, and the fast crossflow/yaw terms remain outside
the gate.

This is a closed-loop scheduling change, not scalar drive tuning. It uses the
body-relative response itself to stop carrying a redirect through a target-line
crossing, while avoiding the empirically harmful course-sign flip and avoiding
another attenuation of a propulsive half-cycle. The expected semantic change
is less bearing overshoot during the useful `8--12T` transit, followed by an
earlier downward course correction and less post-minimum upper recession.
Falsify it if the far carrier or alternating 3D wake degrades, closest approach
is worse than the `3.135--3.259L` full-wave/late-asymmetry references, the same
upper exit persists without reduced recession, or near-limit residence, peak
planar force, or peak moment materially exceed the sampled ranges of roughly
`62--70%`, `0.028`, and `0.018`.

bookshelf_consulted: true
source_domain: biological burst redirect and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: retain a propulsive rhythm, apply bounded target-directed curvature, and release the redirect when measured directional response appears
transferable_invariant: separate the slow route request from the fast traveling wave and reduce the route bias when a body-frame response observable already moves target bearing toward center
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, clocked CPG phase, maneuver duration, exact vortex phase, and task-specific routes
policy_translation: keep the full two-joint state-feedback wave; use speed-qualified signed bearing-window rate to release only the posterior mean route component while leaving crossflow and yaw rejection outside the gate
falsification: reject if response release weakens transit or wake organization, worsens the best inherited approach, fails to reduce bearing overshoot and upper recession, or increases saturation, force, or moment

## Non-CFD gate audit after the edit

Replaying only the new response-release algebra on five completed histories
gives mean route-component scales of `0.939--0.955` at distances of at least
`8L`, `0.880--0.900` from `5L` to `8L`, and `0.885--0.906` inside `5L` for
the histories that entered that band. The reconstructed scale is bounded below
by `0.579` (the analytic lower bound is `0.55`), and it returns to exactly
`1.0` for the assigned prefill at both `4T` and `16T` when bearing is not
converging. It is `0.688` at `8T` and `0.778` at `12T`, localizing the material
change to the observed centerward sweeps. This checks scale, continuity, and
timing only; the post-worker CFD evaluation must determine whether the release
actually improves the trajectory.
