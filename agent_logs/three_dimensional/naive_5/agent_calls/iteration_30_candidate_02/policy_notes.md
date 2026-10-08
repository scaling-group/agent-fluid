# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled rollouts and the assigned-parent rollout satisfy the
  direct-uniform still-water contract: `U_infinity=(0,0,0)`, no cylinders or
  prewarm, and inertial moving-window transport. Every rollout captures. The
  strongest sampled candidate (`solver_8e7135ef9173`, also the solver prefill)
  reaches `0.748338L` at `26.2460T` with score `-0.616147`; the assigned
  parent's phase-coherent request combination reaches `0.749076L` at
  `26.2130T` with score `-0.616351`. Thus the parent is slightly earlier but
  shallower and does not improve the scalar result.
- The combined top-down and oblique sheets for the strongest sample, the
  turn-priority comparison (`solver_730e610b0618`), and the assigned parent
  were inspected from release through termination. The top-down rows show
  genuine self-propulsion, comparable lateral oscillation, and an orderly
  alternating wake followed by the same late target-side hook. The oblique
  Lambda2 rows show a compact, coherent three-dimensional wake rather than
  breakup, passive advection, boundary interaction, or a moving-window
  artifact. No visible route or wake-topology change distinguishes the parent.
- Metrics agree with the visual comparison. The four samples share the same
  `10.464L`/`6.232L` distance at `8T`/`16T`, remain within `0.013L` at `24T`,
  have zero angle/rate/acceleration contacts, and have essentially identical
  peak planar force/yaw moment near `0.01883/0.00979` (the course-priority
  sample reaches `0.00990`). The assigned parent likewise stays in the same
  shallow-capture family. Combining opposed route and line-of-sight requests
  before the nonlinear half-cycle selector therefore survives as a safe
  negative result, not a semantic improvement; further arbitration or
  terminal scalar tuning is unsupported.
- A distinct response signal does survive cross-checking. From `18T` onward in
  the strongest sampled trace, velocity-to-target course error is positive in
  every row and averages `0.583` (`0.648` after `22T`), while the target-normal
  hydrodynamic force alternates between helpful and adverse phases. Its signed
  turn component correlates `0.976` with the measured inertial course rotation,
  yet it opposes the required course turn in about `54%` of rows. The current
  response closure qualifies steering using body yaw, not this translational
  force/course response. This supports testing a small force-commutated route
  residual without changing carrier gains or letting force select the route.

## Policy hypothesis

Preserve the prefilled traveling-bend carrier, translation-consistent
line-of-sight response, capture-gated posterior wave shape, coordinated command
projection, and angle/rate viability guards. Add one middle/late
hydrodynamic-response mechanism: normalized body-frame target/course geometry
continues to choose the turn side, while the measured target-normal force turns
on a bounded anterior residual only during phases when fluid force is rotating
the velocity vector away from that required course turn. The existing
translation-distance, speed-observability, positive-closing, and angle-headroom
gates confine the mechanism to the evidenced approach corridor. Far travel,
aligned force phases, non-closing motion, and the posterior carrier pass
through exactly.

The falsifiable expectation is a materially deeper or earlier capture with the
same coherent two-view wake and zero actuator contacts. Reject the mechanism if
capture is lost, the result remains in the milliscale shallow-capture cluster,
the force-gated switching increases peak force/moment or limit exposure, or a
held-out wake case shows that instantaneous force opposition is too noisy to
represent course response.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish rhythmic steering
source_mechanism: separate slow target-directed steering from fast hydrodynamic-response feedback while preserving the propulsive rhythm
transferable_invariant: geometry chooses the route and a bounded measured fluid-response residual supplies authority only when the current response opposes that route
nontransferable_details: published gains, species kinematics, robot linkage geometry, dimensional frequencies, prescribed paths, and exact vortex phases
policy_translation: use normalized body-frame target/course error for steering sign and normalized target-normal force only as a smooth adverse-response gate on one anterior acceleration residual inside the observed closing approach
falsification: reject on lost capture or wake coherence, a milliscale-equivalent trajectory, new actuator contacts, higher force or moment exposure, or failure of force sign to track course rotation in held-out wakes

## Non-CFD audit after the policy edit

- The parameter schema is exact: every direct `params.FIELD` reference is
  declared by `target_policy_params()`. The prescribed contract state returns
  two finite accelerations, and a deterministic grid spanning near-limit joint
  angles/rates and both force signs remains inside the `30 rad/T^2` envelope.
- Paired lateral-reflection states produce sign-reflected two-joint commands.
  Synthetic far-field and non-closing states are command-identical with and
  without adverse force, while an in-corridor adverse-force state changes only
  the anterior request before downstream feasibility coupling.
- Re-evaluating both the prefilled and candidate laws on reconstructed states
  from all `4772` rows of the prefilled trace changes `399` post-guard commands,
  from about `19.217T` through `26.230T`; none changes at or beyond `4.5L`.
  The largest command difference is `1.217 rad/T^2`, and the candidate's peak
  frozen-state command remains the parent's `29.72585 rad/T^2`. This verifies
  bounded, material activation and exact far-route pass-through only; it is not
  CFD evidence of improvement.
- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable on this account. Its exact three commands were run directly as
  the established fallback. The rendered `README.md` contained the same
  assigned-parent marker twice; removing that duplicate repaired the guidance
  check. Guidance semantics, Julia policy contract/schema, and the solver
  editable-boundary check then pass without running CFD.
