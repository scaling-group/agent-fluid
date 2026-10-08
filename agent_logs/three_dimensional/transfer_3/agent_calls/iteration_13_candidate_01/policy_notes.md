# Course-supported terminal response-release candidate

## Evidence and visual diagnosis before the policy edit

- All four sampled solvers satisfy the physical contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no prewarm or
  cylinders, finite moving-window dynamics, and capture from `12.32772 L`.
  Three are byte-identical evaluations of the assigned parent's v26
  crossflow-supported allocation relief. They reproduce capture at
  `25.118522644 T`, score `-0.5281078349`, mean distance `2.4291113720 L`,
  and final distance `0.7461675406 L`. The distinct sampled v23 coordinated
  release has the same capture time but is weaker at score `-0.5283387731`,
  mean distance `2.4292937801 L`, and final distance `0.7464101911 L`.
- I inspected the complete combined keyframe sheets for the v26 parent and
  the distinct sampled v23 result, plus the inherited step-12 mean-bend
  regression. No sampled termination failure exists, so the latter is the
  most informative completed negative. In every top-down row the fish
  self-propels along the same compact target-directed arc and sheds a coherent
  alternating wake through `20 T`; it is not advected. The oblique rows show
  finite three-dimensional Lambda2 structures at `8 T` and `16 T`, followed
  by a quiet mean-bend handoff near `24 T` and a smooth crossing at `25.12 T`.
  There is no visible collision, exit topology, unstable motion, or wake
  collapse. The mechanisms differ only in the final held-bend trajectory, so
  the diagnostics, not vortex prominence, determine their ranking.
- The v26 cue is a small but reproducible positive mechanism: below `1.6 L`
  it raises mean seven-sample closure from `0.687386` to `0.687572 L/T`,
  reduces peak lateral load from `0.0021775` to `0.0020376`, and improves both
  mean and final distance without joint-stop dwell or commands above
  `0.097/0.244 rad/T^2`. This supports preserving useful target-side
  translation by relieving both joints' terminal equilibrium allocation.
  The inherited step-12 attempt to move that cue to the shared mean bend
  instead regressed to score `-0.5295582789`, mean distance `2.4302567953 L`,
  final distance `0.7476926446 L`, and mean closure `0.686421 L/T`. A helpful
  crossflow cue therefore does not license unloading the redirect geometry.
- On the v26 trajectory, body-frame velocity-to-target angular mismatch
  decreases monotonically in the late band from about `0.443` to `0.310 rad`
  while speed stays `0.647--0.654 L/T`, all 226 samples keep positive
  seven-sample closure (`0.674--0.712 L/T`), and the existing crossflow gate
  remains supported. This is measured response evidence for a convergent
  crab, not a request for extra yaw correction. It permits testing a small
  additional release only after the velocity course itself enters a declared
  target-alignment band.

## Policy hypothesis

Preserve v26's complete outer state-feedback oscillator, traveling posterior
lag, target-angle redirect, closure preview, shared mean-curvature target,
coupled terminal equilibrium, and proven crossflow-supported allocation
relief. Add one response mechanism: compute the unsigned angle between the
normalized body-frame target vector and body velocity. When this course error
falls smoothly below `0.46 rad`, and only while the inherited late proximity,
target-helpful crossflow, positive closure, and settled-joint gates all agree,
release at most an additional `0.035` of the same paired terminal allocation.
The added release is nearly absent at late-band entry and grows only as the
observed course converges; it neither changes the redirect mean, chooses a
beat phase, splits joint roles, nor adds steering authority.

Expected result: exact inherited commands outside `1.6 L`, the same compact
outer trajectory and coherent two-view wake, and a slightly freer but still
quiet terminal crab that improves mean/final distance or capture time. Reject
the mechanism if its logged-state gate is dormant, outer commands change,
capture is delayed or lost, closure/course alignment worsens, the path loops,
or carrier oscillation, saturation, joint-stop dwell, terminal load growth,
instability, or wake degradation returns. This worker's CFD result is not yet
available and is not claimed as evidence.

bookshelf_consulted: true
source_domain: biological C-start response release and sensor-modulated robotic-fish rhythmic control
source_mechanism: release strong curvature continuously after observed body response is target-directed rather than after elapsed time
transferable_invariant: preserve a useful propulsive rhythm and reduce corrective allocation only when target-relative kinematics demonstrate the intended response
nontransferable_details: species escape kinematics, published gains, dimensional cadence, full-body waveforms, exact vortex phase, cylinder geometry, and task-specific routes
policy_translation: a smooth body-frame velocity-to-target course-error gate adds a small bounded paired release to the existing proximity, helpful-crossflow, closure, and two-joint settled-response support
falsification: reject if the gate is inactive, affects the outer path, unloads the shared redirect mean, slows or loses capture, degrades course/closure, or restores oscillation, saturation, joint stops, load spikes, instability, or wake loss

## Non-CFD implementation audit after editing

The candidate and v26 parent were replayed algebraically on all 4,567 stored
parent states (not a coupled-flow rollout). Both candidate commands are finite
at every state, and the maximum command difference is exactly zero for
`distance >= 1.6 L`. All 226 states inside that band have nonzero course
support; its mean is `0.4005` and maximum is `0.9250`. The additional paired
release averages `0.01085` and peaks at `0.02545`, below its declared `0.035`
bound. The largest per-joint command change from v26 is
`0.01472 rad/T^2`, and candidate commands inside the band remain below
`0.105/0.262 rad/T^2`, far inside the actuator envelope. This establishes
schema-level activity, boundedness, and outer noninterference only; it does
not predict the pending CFD outcome.
