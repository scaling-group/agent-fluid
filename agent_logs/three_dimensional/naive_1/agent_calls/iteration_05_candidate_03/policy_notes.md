# Wake-policy candidate notes

## Evidence diagnosis before the edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform `U_infinity=[0,0,0]` initialization, no prewarm, no cylinders, finite
  dynamics, and moving-window transport. All four use the same differential-
  curvature policy and end in semantic capture between `19.228T` and `19.784T`.
  Their small score range (`-0.2433` to `-0.2299`) is therefore repeatability
  evidence for the mechanism rather than support for scalar steering retuning.
- In the best sampled sheet (`solver_9f4d1c41c5e1`), the top-down row shows a
  compact alternating street carried along a smooth target-directed path, and
  the oblique row shows paired caudal Lambda2 structures from release through
  capture. The lowest-score replicate (`solver_610ca5f49cc1`) has the same
  wake and trajectory topology. Metrics agree that this is self-propulsion,
  not advection: distance decreases from `12.328L` to the `0.75L` capture
  boundary while the initialized ambient velocity is zero; peak planar force
  and moment coefficients remain below about `0.029` and `0.017`.
- The inherited geometry-held failure (`solver_6f7220e1f457`) is the useful
  counterexample. Its top-down sheet retains an alternating wake but visibly
  curls below and away after reaching `1.093L`, then exits at `32.071T` with
  distance `9.555L`. Preserve the successful policy's bounded lateral
  direction cosine, opposite-sign `4/10 deg` bias allocation, and one-sided
  response release; changing those route semantics would confound this test.
- The surviving weakness is repeatable actuator mismatch. Across the four
  captures, raw anterior acceleration exceeds `1800 deg/T^2` on
  `61.7--62.2%` of trace rows and raw posterior acceleration on `71.7--72.3%`;
  peaks are about `63` and `101 rad/T^2` against a `31.4 rad/T^2` envelope.
  The downstream hard clamp therefore shapes most beats. A prior inherited
  `tanh`-limited candidate exited early, but it also changed steering
  allocation and response logic, so that bundled failure cannot distinguish
  command shaping from the rejected route controller.

## Policy hypothesis

Retain the capture-proven target geometry, response gate, differential mean
curvature, oscillator, and posterior lag exactly. Add one actuator-compatible
mechanism at the policy boundary: a symmetric high-order soft shoulder
`x/(1+|x|^p)^(1/p)` in units of the fixed acceleration envelope. With `p=8`,
small commands are effectively unchanged, the knee is rounded, and extreme
requests approach the same physical bound without sending two-to-three-times
over-limit raw actions to the adapter. This is a command-structure test, not a
carrier or steering gain tune.

Falsify the candidate if it loses capture, changes the broad monotone approach
or alternating 3D wake, materially lengthens arrival, retains over-limit raw
commands, or fails to reduce rate-limit contact. Even if capture survives, do
not credit the shoulder with load or efficiency improvement unless later CFD
shows smoother action/rate histories without larger force or moment peaks.

bookshelf_consulted: true
source_domain: low-dimensional robotic-fish CPG control and efficient undulatory swimming
source_mechanism: actuator-compatible shaping of rhythmic commands while preserving the traveling-wave and target-feedback layers
transferable_invariant: keep a productive posterior-lagged rhythm and slow body-frame route request intact while bounding the final joint command continuously at the physical interface
nontransferable_details: published gains, motor models, dimensional frequencies, species kinematics, Strouhal targets, exact vortex phases, and task-specific routes
policy_translation: apply one symmetric high-order soft acceleration shoulder to both outputs of the evidenced two-joint state-feedback controller, with its limit and sharpness owned by policy parameters
falsification: reject if capture or wake coherence is lost, arrival degrades materially, commands remain over-limit, rate contact does not fall, or force and moment peaks increase
