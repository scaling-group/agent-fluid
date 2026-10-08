# Evidence-selected collision-course commitment candidate

## Visual diagnosis before editing

- I inspected the release-to-capture combined keyframe sheets for the strongest
  finite sample, v44 (`solver_5f4a4f255da6`), and a replicated v41 comparator
  (`solver_04aeebd1c860`) in both required views.  All report direct uniform
  still-water initialization (`U_infinity=[0,0,0]`) without cylinders or a
  prewarm snapshot.  The top-down rows begin wake-free, then show sustained
  self-propelled diagonal progress, a coherent alternating mid-plane vortex
  street, and a compact transverse hook through the target disk.  The oblique
  Lambda2 rows retain compact three-dimensional structures through the hook.
  Neither sheet shows passive advection, wake breakup, out-of-plane escape,
  collision, or instability, and the sheets are visually indistinguishable at
  their sampling cadence.
- No sampled rollout has a failed termination or distinct failure sheet, so I
  do not manufacture a visual failure comparison.  The informative contrast is
  the lower-performing v41 capture replicated by the other three samples, plus
  the inherited completed v42/v43 allocation controls.  V42 transfers rejected
  posterior effort to the anterior phase anchor and v43 vetoes the anterior
  share when posterior safety rejects its mate; both retain capture but worsen
  terminal/mean distance and crossing margin without improving the load class.
- Trace metrics resolve the difference that the sheets cannot.  V44 is exactly
  identical to v41 through about `22.308T` (`1.816L` from the target), then its
  collision-course gate tapers only additive anterior route steering.  Relative
  to replicated v41, it advances capture from `24.640015T` to `24.557514T`,
  improves final distance from `0.748356L` to `0.747654L`, mean distance from
  `2.347937L` to `2.347238L`, and score from `-0.448328283` to
  `-0.447653764`.  Final constant-velocity projected miss falls from
  `0.631928L` to `0.612134L` and terminal yaw rate from `1.887` to
  `1.564 rad/T`.  Peak absolute planar force/yaw-moment coefficients remain in
  the same low class and change from `0.02303/0.03169/0.01559` to
  `0.02292/0.02893/0.01559`; no joint position hard stop appears.  The moving
  window performs `283` rather than `284` shifts.  These jointly support a
  useful terminal allocation effect, not more thrust or a different route.

## Policy hypothesis

Produce exactly one candidate by promoting the fully evaluated v44 policy
unchanged.  Preserve v41's state-derived anterior oscillator, posterior lagged
traveling bend, normalized body-frame predicted-miss corridor, phase-selective
terminal residual, posterior stopping reserve, and posterior rate coast.  Add
only v44's already evaluated collision-course commitment: when range, positive
closing, course speed, and projected miss show that inertial velocity already
intersects the capture corridor, continuously withdraw additive route steering
from the anterior joint while leaving its propulsive oscillator and all
posterior authority unchanged.

This candidate selects a sampled improvement over the assigned v41 parent; it
does not claim a new same-worker CFD result.  Do not add a gain change, a
flow/wake residual, posterior-to-anterior headroom transfer, or coupled
anti-windup.  Falsify the selection if post-exit evaluation fails to reproduce
capture, changes the route before the `2.10L` approach neighborhood, loses the
terminal distance/miss/yaw benefit, or regresses the coherent wake,
zero-position-hard-stop, low-load, or command-envelope class.  Treat the result
as fixed-pose evidence only until reflection or release-pose perturbations are
evaluated.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal approach hold
source_mechanism: separate the rhythmic phase anchor from a bounded sensor-driven steering residual and stop direction chasing once measured velocity already defines a safe intercept
transferable_invariant: preserve the propulsive oscillator while normalized body-frame range, positive closing, course speed, and projected miss decide whether additive route steering is still necessary
nontransferable_details: published gains, dimensional cadence, robot hardware, species kinematics, full-body waveforms, exact vortex phases, capture geometry, and source-task routes
policy_translation: promote the evaluated v44 gate that tapers only anterior additive route steering inside the existing collision-course corridor while leaving oscillator acceleration and posterior allocation unchanged
falsification: reject if nominal capture or the measured terminal distance, projected-miss, and yaw-rate advantage is lost, the far route changes, or wake, load, stroke, rate, or raw-command classes regress; separately test reflection or pose perturbation before claiming generality

## Evaluation boundary

Formal CFD is deferred to the post-worker evaluator.  The current evidence
supports selecting v44 over the assigned v41 parent but does not establish
robustness to reflection, perturbed release pose, imposed inflow, or external
wakes.

## Pre-evaluation validation

- The sole materializable candidate has SHA-256
  `311b36856266cfb0258b452c5bec9b877f290fd30277e1f7b53262a89cf358c6`
  and is byte-identical to the evaluated v44 sample.  No sibling candidate was
  created.
- The mandated check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unsupported on this account, matching the inherited infrastructure failure.
  Its three declared no-CFD checks were therefore run directly and separately:
  reusable-guidance semantics, the Julia public policy contract, and the solver
  editable-boundary audit all pass.  The contract returns finite accelerations
  `(-14.3858335, 0.0005062)`.
- The deterministic schema audit resolves all `87` direct `params.FIELD`
  references among the `89` fields returned by `target_policy_params()`.
  Formal CFD remains reserved for the post-worker evaluator.
