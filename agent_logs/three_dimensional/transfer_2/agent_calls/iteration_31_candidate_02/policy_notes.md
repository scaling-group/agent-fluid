# Redirect-priority carrier restoration candidate

## Evidence and visual diagnosis written before editing

- All four sampled episodes satisfy the frozen release contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  moving-window transport, stable dynamics, and `capture`. The two
  response-released samples are byte-identical policy repeats, so they provide
  the main test of the inherited mechanism rather than four unrelated scores.
- Both rows of all four combined keyframe sheets were inspected from release to
  capture. Each top-down row starts in blank still water, develops a compact
  alternating caudal-vorticity street by `3--6T`, and follows a shallow
  target-directed arc. Each oblique row shows discrete three-dimensional
  Lambda2 structures shed behind the caudal region while the body advances.
  The fish are self-propelled rather than advected; none shows collision, wake
  collapse, domain exit, or instability. The sheets remain visually close, so
  the late trajectory and actuator metrics, not vortex prominence, distinguish
  the policies.
- The byte-identical response-released policy captures at
  `16.071--16.088T` with distance integral `1.82203--1.82366L`. Relative to
  the sampled plain redirect-priority controller at `16.044T/1.82409L`, it
  reaches `10/8/6L` slightly earlier but reaches `4/2/1L` and capture later.
  Its head path (`13.129--13.166L`), peak planar force
  (`0.03427--0.03575`), peak yaw moment (`0.01702--0.01781`), and greater-than-
  90%-rate residence (`17.50--17.52/7.93--8.08%`) do not leave the assigned
  parent's exact redirect-repeat envelopes in a consistent favorable
  direction. Near-`2L` mean absolute yaw instead rises from `0.0943 rad/T` in
  the sampled redirect baseline to `0.1149--0.1275 rad/T`.
- The independent response-residual redirect is the informative regression:
  despite a similarly coherent wake and a slightly lower integral
  (`1.82240L`), it captures at `16.247T`, lengthens head path to `13.363L`,
  and raises near-`2L` mean absolute yaw to `0.2690 rad/T`. Together with the
  two response-released repeats, this shows that same-sign yaw alone is not a
  reliable certificate that the velocity-course redirect has been satisfied.
  Releasing either the redirect residual or negative-work carrier from that
  proxy changes the late hook without a durable protection benefit.
- The assigned parent and inherited logs bound the alternative: the exact
  plain redirect-priority controller repeated at `16.044--16.093T`, integral
  `1.82409--1.82848L`, path `13.091--13.178L`, force/moment peaks
  `0.03579--0.03634/0.01770--0.01794`, and greater-than-90%-rate residence
  `17.76--17.81/8.12--8.24%`. Predictive, load-norm, unconditional-reversal,
  and response-release guards either slowed materially or failed to move
  protection metrics beyond this envelope. This supports mechanism rollback,
  not another scalar threshold or terminal slip gate.

## One-candidate hypothesis and falsification

Materialize the evaluated plain redirect-priority carrier governor as the
single candidate. Preserve the corrected body-frame target geometry,
distance/closing relief, half-cycle steering, posterior handoff, velocity-
course redirect, carrier/steering decomposition, and bounded two-acceleration
contract. While a normalized velocity-course redirect remains unfulfilled,
use it with positive carrier work to request one common scale on the complete
two-joint carrier; do not release negative-work reversal merely because body
yaw has the requested sign. This restores the coupled traveling bend and the
fastest validated trajectory class while removing the now-falsified response
proxy.

Expected signature: reproduce capture within the assigned parent's redirect
repeat envelope, retain the coherent top-down and oblique wakes, recover the
lower terminal-yaw trajectory, and keep zero greater-than-90%-angle residence.
Falsify this selection if a repeat leaves capture, timing, integral, path,
rate, or load outside that envelope, or if a held-out pose/inflow exposes a
repeatable failure that a more specific course-satisfaction observation can
resolve. Do not reinstate yaw-alignment release until such an observation is
shown to separate useful directional response from a still-unfulfilled late
turn.

bookshelf_consulted: true
source_domain: biological C-start redirection, sensor-modulated robotic-fish CPG control, and reactive traveling-wave propulsion
source_mechanism: apply bounded curvature for a large direction correction and release into a coordinated posterior-lag rhythm only after useful directional response
transferable_invariant: preserve a coupled traveling carrier while redirect authority is unmet, and require task-satisfying measured response rather than elapsed time before any authority handoff
nontransferable_details: species-specific burst kinematics, published gains and cadence, dimensional load scales, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame velocity-course error and joint response to retain one common carrier scale while the redirect is unfulfilled; the sampled same-sign-yaw release is rejected because it did not certify course satisfaction
falsification: reject the restored controller if it fails its established repeat envelope, and test a new release only when a normalized course-satisfaction signal predicts a distinct useful trajectory without worse capture, path, rate, load, joint margin, or wake coherence

## Validation status

- The required guidance-materiality check passes after removing the duplicated
  assigned-parent marker from the rendered workspace `README.md`.
- The solver boundary check passes, and the deterministic static schema audit
  finds every direct `params.FIELD` reference in `target_policy_params()`.
  Single-entrypoint, non-empty-file, and forbidden clock/random/file-call scans
  also pass.
- The candidate SHA-256 is
  `9c1d140a59d822e03880fe6f2d6df095188004fe0b80f921edff1fa021dbe011`,
  byte-identical to the sampled finite redirect-priority artifact. The local
  Julia contract command cannot run because this workspace environment has no
  `julia` executable on `PATH`, in common install paths, or in the available
  environment modules. No CFD is run; downstream evaluation occurs after this
  worker exits.
