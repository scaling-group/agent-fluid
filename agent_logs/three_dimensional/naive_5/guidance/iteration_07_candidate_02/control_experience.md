# Dogfish L64 3D Moving-Window Still-Water Policy Experience

## Persistence contract

This file is mutable optimizer state, not a static task description. Every
successful worker must leave it with at least one material, evidence-backed
lesson added or revised from its assigned parent. Distill sampled solver results
and available inherited logs into a reusable control implication plus an
applicability or falsification boundary. When prior evidence shows no
improvement, record the concrete negative result and what later workers should
avoid or test; do not use a generic no-progress sentence or a cosmetic or
identifier-only change. The current worker's new CFD evaluation occurs after
it exits and therefore becomes evidence for a later sampled worker.

- This is a fresh 10-iteration lineage with no solver or optimizer population
  import. Its logical Phase-2 population is always four workers even when the
  four CFD evaluations are mapped across different PBS/GPU allocations.
- The fixed task is WaterLily 3D at `L64`, `Re=1000`, target `(9,9.5)L`,
  first-crossing radius `0.75L`, still water `U_infinity=0`, direct uniform
  initialization without prewarm, released horizon `100T`, a `24L x 16L`
  inertial virtual field stored in a `4L x 3L x 1.5L` moving window, and the
  actuator envelope `45/260/1800` in degree-based units.
- The common naive seed has only a state-feedback oscillator and posterior
  phase lag. It reads joint state but not the task target, flow, force, moment,
  world position, learned route, or any external phase signal, and it is not
  intended to complete the task.
- In the direct-uniform still-water seed rollout, the `0.55T`, `28 deg`
  joint-only oscillator did self-propel and form a coherent curved wake, but
  joint speed reached the `260 deg/T` cap, raw acceleration requests exceeded
  the `1800 deg/T^2` envelope, yaw rate spanned about `-2.79` to `+2.24 rad/T`,
  and distance improved only `0.25L` before an upper-boundary exit at `8.55T`.
  Therefore visible wake strength alone does not validate a carrier: when this
  saturation-and-curl topology appears, first restore sub-limit traveling-bend
  motion and add bounded target-error-to-curvature feedback with measured turn
  response, rather than increasing drive gains. Falsify this implication if a
  target-aware sub-limit carrier loses propulsion despite remaining clear of
  the caps, or if an unsaturated carrier produces the same broad curl exit;
  also reject the diagnosis if both visual views show that the recorded yaw is
  a moving-window artifact rather than body rotation.
- Across three target-aware descendants of that seed, bounded static
  mean-curvature steering did not change the upper-boundary-exit topology.
  Two posterior-only variants removed all sampled speed and acceleration
  clipping, yet the `0.90T/18 deg` carrier reached only
  `12.226L` (final `13.084L`, exit `8.916T`) and the assigned
  `1.10T/10 deg` parent reached only `12.296L` (final
  `13.405L`, exit `9.080T`), versus the unbiased seed's
  `12.078L` minimum and `12.380L` final distance.  A shared
  anterior/posterior bias was worse (`12.235L` minimum,
  `13.829L` final) and restored joint-speed clipping.  Both visual rows
  confirm that every variant still self-propelled into the same tight upward
  curl, so actuation headroom alone is not steering authority and another
  scalar mean-bend retune is unsupported.  When bearing has already reversed
  by closest approach but a mean bend cannot reverse the turn, test a
  phase-selective mechanism such as target-error-driven half-cycle asymmetry,
  and calibrate its side against measured joint-phase/yaw response.  This
  negative result applies to static equilibrium offsets on these
  state-feedback carriers; reconsider mean curvature only if a later rollout
  demonstrates sustained correct-sign bearing recovery rather than merely a
  longer finite trajectory.
- The inherited parent log and sampled multimodal evidence now show that
  phase-selective steering is not interchangeable across joints. A
  posterior-target half-cycle variant remained sub-limit but repeated the
  near-`9T` upper curl (`12.263L` minimum), whereas anterior half-cycle
  forcing on the `0.90T/18 deg` traveling bend produced a coherent, sustained
  leftward wake, survived to `39.088T`, and reached `5.156L`. Preserve that
  anterior carrier/actuator placement as the first demonstrated escape from
  the curl topology, but do not mistake it for target steering: its y position
  stayed between `13.780L` and `14.961L`, bearing was about `-1.50 rad` at
  closest approach, and it overshot longitudinally to a left-boundary exit
  while spending roughly `53%` of samples at the joint-speed cap and `58%` at
  its acceleration clamp. Reconstructed feedback shows instantaneous yaw
  rate repeatedly cancels the fixed-sign geometric request within each beat,
  leaving mean turn-side authority near `0.1` under large bearing. However,
  removing that phase-correlated rate closure is now concretely falsified:
  direct bearing-dominant anterior half-cycle forcing returned to the upper
  exit at `9.295T` (`11.954L` minimum), and direct velocity-course forcing did
  likewise at `8.778T` (`12.186L` minimum). Both combined visual rows show a
  coherent wake folding into the old tight curl, rather than loss of thrust.
  Treat the parent's instantaneous loop as part of the evidenced carrier, not
  merely disposable yaw damping: test persistent body-frame route error as a
  bounded bias on its desired mean yaw, while avoiding another direct
  bearing/course half-cycle selector, posterior-only asymmetry, or raw
  rate-gain retune. Falsify this revised implication if a rate-closed route
  bias still returns to the near-`9T` curl or cannot add cross-track progress
  to the parent's high-y leftward trajectory without worse saturation.
- Once sign-corrected anterior steering preserves the long wake but remains in
  the high corridor, a body-frame large-error redirect is more promising than
  moving the same asymmetry posteriorly. The sampled same-sign, two-joint
  C-start-like redirect lowered the closest approach from `4.516L` to
  `1.165L` and moved the path from roughly `y=14L` to the target neighborhood,
  while posterior half-cycle wave allocation instead turned upward and exited
  at `(8.770,15.201)L` with a `5.386L` minimum. The redirect still missed the
  `0.75L` disk: near `27.055T` its joints had nearly stopped beating, cruise
  and redirect accelerations cancelled, and the fish coasted at about
  `0.68L/T` with a straight-line projected miss of `1.165L`. Thus preserve the
  observation-gated redirect as the first mechanism to supply enough
  cross-track authority, but treat its terminal release as a separate control
  problem: inside a normalized approach band, use closing motion and predicted
  miss to retain bend/drag only while the current course will miss capture.
  Avoid another posterior-asymmetry or carrier-gain retune. Falsify this lesson
  if a terminal guard cannot beat `1.165L`, destroys the coherent carrier,
  increases limit residence, or latches after the target stops closing; do not
  generalize it to a trajectory that has not first demonstrated broad
  target-directed motion.
- Inspect the seed rollout, diagnostics, available observations, and inherited
  evidence to determine what capability is missing. Preserve behavior that the
  evidence shows is useful.
- Prefer normalized body-frame feedback changes that are bounded and carry a
  falsifiable expectation. Let evidence choose the observation and mechanism;
  do not hard-code a global-direction command, coordinates, target identity,
  elapsed time, step count, iteration number, or a case-specific route.
- The `fish-control-primitives` shelf exists for mechanism-level transfer
  across biological swimming, robotic fish, CFD, and wake-control problems.
  Transfer qualitative invariants into this lane's observations and actuation;
  never copy numerical gains, species-specific kinematics, or a memorized
  route. The worker entrypoint defines the consultation protocol.
- Inspect both top-down and oblique 3D keyframe rows before policy edits, then
  cross-check visual claims against distance progress, local/relative flow,
  force, moment, joint state, previous action, and termination. A prewarm
  artifact is a contract failure in this direct-uniform experiment.
- Prefer normalized body-frame feedback. Inflow, target position, initial pose,
  and hydrodynamic conditions are intended held-out axes; coordinate
  memorization is not a valid solution.
- Treat every proposed observation as an empirical hypothesis: establish its
  scale, convention, and measurable effect from the current evidence before
  relying on it.
- Compare successful, near-miss, and failed trajectories without assuming a
  particular causal decomposition in advance.
- Do not rank successful policies by scalar score alone. Compare semantic
  success, arrival, distance integral, final/mean distance, clearance,
  saturation, switching, effort, and force/moment loads.
- The hard limits are an actuation envelope, not a muscle-power model. Reject
  persistent bang-bang action, implausible load spikes, and fragile success
  even when scalar score improves.
- Record candidate-specific hypotheses under `logs/optimize/`; every successful
  worker must update this file with a durable lesson that should survive across
  later iterations.
