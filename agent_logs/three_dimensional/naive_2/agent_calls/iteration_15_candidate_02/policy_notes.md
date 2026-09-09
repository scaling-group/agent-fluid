# Phase-separated terminal-response candidate

## Evidence and visual diagnosis before editing

- The assigned prefill, four sampled solvers, and inherited parent evaluation
  all report direct uniform still water with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm. Their top-down vorticity and oblique Lambda2
  sheets therefore show self-generated motion rather than advection.
- The assigned phase-compensated approach-hold prefill has a coherent
  alternating wake at `8--16T`, but its top-down row makes a broad turn outside
  the capture corridor and its later oblique views show the body curling away.
  It reaches only `2.7033L` before exiting left at `24.52T`; the related
  full-circle sample reaches `4.6500L`. Broad carrier relief and full-circle
  pursuit are weaker than the sampled course-predictive architecture.
- The course-predictive terminal-curvature sample is the only semantic
  success. Its compact, body-connected alternating wake persists on both
  visual rows along a direct approach through capture at `16.0105T` and
  `0.7477L`. Peak normalized planar force and moment are only
  `0.03465/0.01721`, and neither joint dwells beyond `40 deg`.
- The assigned parent's inherited evaluation is a byte-identical repeat of
  that successful policy, but it passes below the capture disk at `0.9387L`
  and then self-propels along a coherent downward-left escape until boundary
  exit at `28.4240T` and `10.5578L`. Thus the capture is physically useful but
  has inadequate repeat margin. At each rollout's closest approach, the
  inherited joint-rate carrier model predicts yaw accurately for the capture
  (`heading_rate - carrier_yaw = 0.0045 rad/T`) but leaves a `0.4200 rad/T`
  wrong-side response residual in the near miss; peak load remains nearly
  unchanged (`0.03466/0.01734`).

## Single candidate hypothesis

Start from the evidenced predicted-miss/course-residual controller and add one
response mechanism: subtract the joint-phase-correlated carrier model from
measured heading rate, then use the bounded residual only inside the existing
terminal mean-curvature handoff. The traveling-bend carrier, course predictor,
and all of their gains remain unchanged. Correct-sign terminal response is
released; an excess response residual recruits more target-signed mean bend.
This should leave the captured trajectory nearly unchanged because its
closest-approach residual is near zero, while correcting the repeat failure's
large residual before it crosses below the capture disk.

Support is repeat capture or a closer pass with the same compact wake, low
loads, and joint reserve. Falsify the mechanism if the new residual fights
beat-scale carrier yaw, increases switching or loads, weakens pre-approach
translation, or preserves the lower-left escape topology. Under real
multi-wake crossflow, reject it if alternating environmental yaw is mistaken
for persistent target response; a history-based residual would then be the
next test.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and response-gated biological redirect
source_mechanism: preserve a rhythmic propulsive carrier while measured directional response releases or reinforces a bounded target-directed turn
transferable_invariant: separate beat-correlated yaw from directional response and feed back only the bounded residual during terminal interception
nontransferable_details: published gains, clock phase, robot linkage geometry, species kinematics, dimensional frequencies, exact vortex phases, and task-specific routes
policy_translation: predict carrier yaw from normalized two-joint rates, subtract it from body heading rate, and add the bounded residual only to the body-frame terminal mean-bend request
falsification: reject if repeat capture, closest approach, wake coherence, joint reserve, and low normalized loads do not improve jointly, or if actual wake crossflow causes wrong-side residual steering

## Dry validation only

The mandated guidance-materiality/schema, Julia policy-contract, and editable-
boundary checks pass. A `218,700`-state grid spanning joint state, body-frame
target geometry, velocity, heading rate, and distance produced finite commands
strictly inside the smooth `30 rad/T^2` envelope with exact left/right
reflection (maximum error `0.0`). These checks establish executable semantics,
not physical improvement. No CFD was run; downstream evaluation must test the
capture-margin and wake-response falsifiers above.
