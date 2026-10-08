# Evidence-selected v41 candidate after repeated nominal capture

## Visual diagnosis before candidate selection

- The four assigned solver examples are exact v41 replications: their policy,
  `4480`-row trajectory, and combined keyframe-sheet hashes match.  Each uses
  direct uniform still-water initialization (`U_infinity=[0,0,0]`) without
  cylinders or a prewarm snapshot and captures at `24.640015T` and
  `0.748356L`, with mean distance `2.347937L`, score `-0.448328283`, and 284
  inertial moving-window shifts.  This establishes deterministic nominal
  behavior, not four distinct mechanisms or held-out robustness.
- I inspected the combined sheet from release through capture in both views.
  The top-down row starts wake-free, then shows self-propelled diagonal
  progress, a coherent alternating mid-plane vortex street, and a compact
  transverse hook through the target disk.  The oblique row retains compact,
  paired three-dimensional Lambda2 structures throughout the hook.  Because
  background flow is zero, this is propulsion rather than passive advection;
  there is no visible wake breakup, out-of-plane escape, collision, or
  numerical instability.
- The trace cross-check agrees: neither joint occupies the `45 deg` position
  stop, peak absolute planar body-force/yaw-moment coefficients are
  `0.02303/0.03169/0.01559`, and the terminal yaw rate is `1.887 rad/T`.
  Raw acceleration-envelope exposure remains `73.594%`, and the final
  crossing margin is only `0.001644L`, so this is a narrow dynamic capture,
  not a settled or unsaturated hold.
- No current solver sample provides a distinct failed visual rollout.  The
  informative failure contrast is inherited trace-level evidence.  V42
  transfers rejected posterior terminal effort to the anterior phase anchor;
  it crosses one row earlier but worsens final/mean distance to
  `0.749001/2.348455L`, raises raw acceleration exposure to `74.124%`, and
  worsens score to `-0.448986`.  V43 tests the opposite coupling by vetoing
  anterior terminal effort when posterior safety rejects its mate; it captures
  later at `24.656513T`, reduces crossing margin to `0.000397L`, and worsens
  mean distance/score to `2.348909L/-0.449516` without a better load or command
  class.  Older broad rate barriers and posterior phase feedforward reduce
  selected saturation counts but change the route and lose capture.
- Multiple inherited workers then selected v41 unchanged, and their completed
  evaluations reproduced the exact nominal rollout.  This is a semantic stall
  and therefore triggers the structured bookshelf consultation; repetition
  still does not expose a disturbance event from which to calibrate a new
  force, moment, crossflow, or approach-hold response.

## Candidate hypothesis

Keep exactly one candidate: the existing v41 terminal phase-allocation policy,
byte-identical in dynamics and parameter schema to the four sampled successful
solvers.  Preserve the observed-state anterior phase anchor, lagged posterior
traveling bend, normalized body-frame projected-miss corridor, bounded
phase-compatible terminal residual, posterior stopping-stroke reserve, and
posterior rate coast.  Keep posterior safety joint-local; do not adopt v42's
inverse headroom transfer, v43's coupled anti-windup, another terminal
allocator, an approach-drive scalar, or an uncalibrated wake-load residual.

This is completed-evidence selection and a concrete negative transfer result,
not a same-worker CFD claim.  Post-exit evaluation should reproduce capture,
the coherent two-view wake, zero position hard-stop occupancy, and the low-load
class.  Reject the selection if nominal replication fails.  A later active
mechanism requires a reflected, perturbed-release, or genuinely disturbed
rollout that supplies a distinct normalized body-frame trigger and calibrated
sign; it must remain null before that trigger and preserve the established far
route.

bookshelf_consulted: true
source_domain: elongated-body traveling-wave propulsion, sensor-modulated coupled-oscillator robotic-fish control, and asymmetric fish turning
source_mechanism: preserve a stable anterior-to-posterior traveling bend and place bounded sensory steering on a compatible observed half-cycle only for a diagnosed error
transferable_invariant: infer phase from joint state, retain the anterior phase anchor and posterior lag, and localize any added correction with a normalized body-frame error whose sign and scale are evidenced by a divergent rollout
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, species or robot kinematics, full-body waveforms, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant projected-miss residual, lagged-wave phase gate, anterior anchor, posterior stopping-stroke reserve, and posterior coast; add no unsupported cross-joint transfer, scalar tune, or disturbance residual
falsification: reject if nominal capture, far-route locality, coherent wake, zero position hard-stop occupancy, or the low-load class fails to repeat; reject a future residual if it activates before a distinct body-frame disturbance or removes necessary correction on a held-out route

## Evaluation boundary

Formal CFD is deferred to the post-worker evaluator.  The retained candidate is
not evidence for reflection, release-pose perturbation, imposed inflow, or
external-wake robustness.

## Pre-evaluation validation

- The single materializable candidate remains byte-identical to all four
  sampled v41 policies (LF SHA-256
  `9e6a29b253671527cc436021e572b18ba5bf6994d71936eadf98ca674753fadd`).
  No sibling candidate was created.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unsupported on this account.  Its three declared no-CFD commands
  were therefore run directly and separately.  After removing the duplicated
  assigned-parent marker from the rendered workspace README, reusable-guidance
  semantics, the Julia public policy contract, and the solver editable-boundary
  audit pass; the contract returns finite accelerations
  `(-14.3858335, 0.0005062)`.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.
  Formal CFD remains reserved for the post-worker evaluator.
