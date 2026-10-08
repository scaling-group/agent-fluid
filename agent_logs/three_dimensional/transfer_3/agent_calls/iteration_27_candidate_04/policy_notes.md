# Geometry-consistent course-supported response-exclusive allocation

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture. The
  assigned `v38` course-supported allocator is the best sample at score
  `-0.271582682` and mean/final distance `2.162124221 L`/`0.747272313 L`.
  The other three samples are byte-identical `v37` evaluations, each at
  `-0.282941223`, `2.172435105 L`, and `0.748660505 L`; they establish exact
  reproduction of the response-exclusive comparator rather than three
  independent mechanisms.
- I inspected the complete combined keyframe sheets for `v38` and the
  reproduced `v37`, including the top-down mid-plane-vorticity row and the
  oblique body/Lambda2 row from uniform release through capture. Both fish
  visibly self-propel along nearly the same compact target-directed arc, shed
  a coherent alternating posterior wake, and retain finite localized 3D wake
  structures. Neither shows passive advection, a loop, collision,
  boundary-exit precursor, wake collapse, or out-of-plane instability. There
  is no non-capture rollout in this sample, so the lower-scoring reproduced
  capture is the informative semantic failure contrast.
- The `v38` course selector produces a real objective gain without simply
  accelerating capture. It reaches `12/10/8/6/4 L` earlier at about
  `3.795/7.827/10.532/13.096/15.615 T`, versus
  `3.839/7.986/10.725/13.239/15.664 T` for `v37`, but then reaches
  `2/1/0.75 L` later at `18.199/19.618/19.998 T`, versus
  `18.089/19.316/19.613 T`. The retained outer course correction therefore
  improves the distance integral while handing off into a slower terminal
  phase; the better score is not evidence for more cadence or larger gains.
- The visual terminal difference agrees with diagnostics. `v38` enters the
  final frame with commands about `-1.63/3.96 rad/T^2`, joint rates
  `-1.41/0.66 rad/T`, yaw rate `0.649 rad/T`, and negligible lateral force,
  while `v37` captures with a posterior command at the acceleration cap,
  joint rates `-4.50/1.54 rad/T`, and yaw rate `2.858 rad/T`. Conversely,
  `v38` raises global lateral-force/yaw-moment maxima to about
  `0.02906/0.01678`, from `0.02717/0.01558` for `v37`. Preserve the evidenced
  course benefit and quiet terminal arrival, but do not interpret absolute
  course miss as permission for target-residual priority in every turn state.
- Reconstructing the parent's normalized body-frame course geometry on its
  stored trace shows that the magnitude-only course selector is active on
  `876` outer states. The composite target-turn request agrees in sign with
  its persistent body-frame geometric request on `716` of those states but is
  opposed by its faster turn-rate correction on `160`; their course-weighted
  support is about `321.41` versus `104.72`, respectively. The latter states
  ask the allocator to prioritize a dynamic brake as though it were persistent
  route correction. This exposes an independently active coordination question
  rather than a reason to retune selector thresholds or authority.

## Policy hypothesis

Start from the evaluated `v38` assigned parent and preserve its traveling-bend
oscillator, target guidance, course-miss and translation support, posterior
response allocator, terminal mean bend, intercept corridor, cadence, gains,
and actuator limits. Add one geometric-consistency gate to the outer-only
course selector. Allow the existing course-supported transfer from
posterior-response recovery to the already bounded target residual only when
the composite target-turn request agrees in sign with its persistent
body-frame geometric request. When fast turn-rate correction reverses that
request, retain the parent's base response allocation rather than granting the
dynamic brake extra priority. This changes neither total authority nor any
command at or below `4 L`, and it adds no route, clock, vortex phase, force
cancellation, or scalar gain change.

The expected benefit is to preserve the parent's earlier outer range crossings
and quiet finite capture while preventing fast rate correction from displacing
traveling-bend response under a persistent course miss, with no increase in
load or saturation. Falsify the candidate if the gate is dormant, suppresses
the geometry-consistent majority,
changes a same-state command at or below `4 L`, exceeds the declared
acceleration envelope, worsens score or mean distance, delays or loses
capture, changes the compact trajectory or coherent two-view wake, or
increases joint-stop dwell, force/moment loads, or instability. The new CFD
evaluation occurs only after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: sensor-modulated coupled-oscillator robotic-fish direction tracking and classical traveling-wave propulsion
source_mechanism: separate persistent route demand from faster response correction when both modulate a coordinated propulsive gait
transferable_invariant: low-frequency target geometry should displace rhythmic-response priority only while the composite residual still agrees with that persistent route demand
nontransferable_details: published gains, dimensional cadence, full-body waveforms, species-specific kinematics, exact phase or vortex timing, actuator models, target coordinates, capture geometry, and task-specific routes
policy_translation: outside the normalized terminal band, gate the existing bounded course-miss-supported residual transfer by sign agreement between the persistent body-frame geometric request and its rate-corrected target-turn request
falsification: reject on gate dormancy, loss of geometry-consistent allocations, terminal same-state interference, slower or lost capture, worse distance integral, changed useful topology, renewed stop dwell, material load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- Reconstructing body-frame observations on the evaluated parent trace shows
  that the consistency gate changes `120` stored outer commands, with maximum
  two-joint difference `1.19090 rad/T^2`; on the reproduced comparator it
  changes `125`, with maximum difference `1.18189 rad/T^2`. All stored states
  at or below `4 L` are exactly parent-identical, and every output is finite
  and within the declared acceleration limit. These are activity and
  noninterference checks, not evidence of coupled-flow improvement.
- A deterministic `170100`-state grid over range, body-frame target and course
  angles, translation speed, turn response, and both joint positions and
  velocities produces `3094` active cases. All outputs are finite and bounded;
  all grid states at or below `4 L` are exactly parent-identical.
- The lightweight Julia contract and deterministic parameter-schema audit
  pass: all `87` direct `params.FIELD` references resolve in the `88`-field
  object returned by `target_policy_params()`. The solver boundary check also
  passes. No formal CFD was run in this workspace.
- The prescribed `check-runner` was invoked after the final edits, but its
  pinned `gpt-5.4-mini` model is unsupported on this ChatGPT account and
  failed before executing a command. Its three configured non-CFD checks were
  run directly and separately; all pass. The guidance check initially exposed
  a duplicate assigned-parent marker in the rendered root `README.md`, and
  removing only that duplicate repaired parent resolution.
