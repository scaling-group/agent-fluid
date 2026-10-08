# Wake-policy candidate diagnosis

## Evidence read before the candidate decision

- The four sampled solvers have the same policy SHA-256
  `452903db94b971aed60f8a7830a0f2e19faebb59e44d73d0e428556cc7dc9781`,
  trajectory SHA-256
  `84ec5c93bc1296951b7cff2a3b54b435a8ac3e07c0f7078ebe1d4caba2d46bd5`,
  and combined-keyframe SHA-256
  `6d2c1aa216c46c66498dd106af6501aae546780acc43531ed40694a0ecb3c41e`.
  They are one deterministic result, not four independent controls.
- Each rollout is a direct, uniform, quiescent initialization with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and the same capture at
  `16.604496T`: score `-0.1137286345`, crossing distance `0.743958L`, and
  distance integral `1.998146L`.
- In the top-down row, the fish is self-propelled rather than advected. A
  strong alternating wake grows from the tail, remains coherent as the target
  distance falls from `12.8L` to capture, and accompanies a smooth useful
  target-crossing arc; there is no collision, domain exit, or visible loss of
  thrust. In the oblique Lambda2 row, the alternating structures remain
  tail-connected and three-dimensional through the final frame, without wake
  breakup or an instability precursor.
- There is no informative sampled failure image to compare with the finite
  result: all four visual artifacts are byte-identical. The inherited
  completed descendants are therefore the valid negative controls. Qualified
  terminal yaw release regressed to
  `0.744276L/1.998380L/-0.114037`; carrier-correlated local-flow subtraction
  regressed to `0.745252L/1.999280L/-0.115121`; inherited target-rate,
  terminal half-cycle, projected-corridor, bearing, and moment variants also
  failed to improve capture. Parent and sampled optimizer logs additionally
  record repeated exact `-0.1137286345` captures through three consecutive
  completed iterations.

## Hypothesis and candidate decision

The evidence contains no remaining nominal response deficit that localizes a
new controller mechanism. The required shelf review maps phase-lag, rhythmic
asymmetry, response feedback, approach scheduling, and actuator-aware control
either to mechanisms already in the assigned policy or to completed negative
controls. The candidate hypothesis is therefore conservative and falsifiable:
the byte-identical response-demodulated carrier should retain the demonstrated
capture, route cost, connected wake, and actuator/load envelope, whereas an
unevidenced new channel has a larger measured risk of making the shallow
crossing or route cost worse. `candidate_target_policy.jl` is intentionally
preserved as the one candidate; no scalar gain tune or dormant speculative
mechanism is introduced.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming, robotic-fish CPG modulation, and wake-interaction control
source_mechanism: posterior-lag traveling bend with sensor-gated phase, asymmetry, or disturbance modulation
transferable_invariant: preserve a directional posterior-emphasized wave and add only bounded body-frame feedback that addresses an observed persistent response error
nontransferable_details: published gains, dimensional beat frequencies, species-specific envelopes, exact vortex phase, world-frame routes, and cylinder-specific commands
policy_translation: null translation for this candidate because the carrier already implements the invariant and the direct-still-water evidence exposes no distinct error for another feedback channel
falsification: reopen exactly one bounded primitive after a completed held-out pose, target, or flow, or a meaningfully different failed trajectory, reveals a repeatable response deficit; reject it if capture, route cost, crossing depth, wake connectivity, joint feasibility, effort, force, or moment worsens
