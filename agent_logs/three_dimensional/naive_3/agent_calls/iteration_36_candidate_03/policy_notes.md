# Body-turn-cancelled terminal intercept candidate

## Evidence-led diagnosis recorded before the policy edit

- All sampled and assigned-parent evaluations report direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders, and
  no prewarm. Three sampled policies are byte-identical copies of the prefill
  and reproduce the same `16.93205T`, `-0.20004481`, `2.08513L`-mean-distance
  capture at `0.74389L`. This replication supports preserving the complete
  zero-centered carrier, velocity-course steering, soft acceleration
  envelope, phase-local speed guards, directional work allocation, and
  posterior stopping-risk projection.
- I inspected the combined keyframe sheets for the replicated prefill, the
  sampled bidirectionally arbitrated allocator, and the assigned parent's
  terminal bearing-rate candidate from release through capture. Both visual
  rows retain the same useful topology: continuous target approach behind a
  coherent alternating red/blue top-down street and compact three-dimensional
  caudal Lambda2 structures through capture. The prefill diagnostics confirm
  self-propulsion (`1.391U` peak speed versus `0.0327U` peak local flow), with
  no held-joint coast, wake collapse, collision, or boundary exit.
- Mirroring adverse-yaw arbitration into anterior-to-posterior transfer is a
  sampled negative control. It arrives only `0.00587T` earlier but worsens
  score from `-0.200045` to `-0.200966`, mean distance from `2.08513L` to
  `2.08585L`, crossing distance from `0.74389L` to `0.74483L`, and terminal
  yaw from `4.4430` to `4.4536 rad/T`, without reducing the `0.5992 rad`
  posterior excursion. Actuator-specific transfer roles should remain intact.
- The assigned parent's bounded body-frame bearing-rate damping is the most
  informative failure. It retains capture and lowers terminal peak yaw only
  from `4.4430` to `4.4362 rad/T`, while regressing score to `-0.204535`, mean
  distance to `2.08874L`, and crossing distance to `0.74825L`; arrival changes
  by only `0.00530T`, and whole-route speed, joint, force, and moment peaks are
  unchanged. This repeats the inherited capture-corridor result: withdrawing
  established target-course steering does not improve terminal geometry.
- The observation, rather than insufficient damping gain, explains the weak
  result. Below `2L`, the prefill's seven-state body-frame bearing rate has
  about `2.55 rad/T` mean magnitude while recent body turn has about
  `2.35 rad/T` mean magnitude. Their difference—the rotation of the actual
  head-to-target ray after cancelling body yaw—is only about `0.316 rad/T` on
  average and spans `-0.461` to `+0.583 rad/T`. Thus raw bearing rate largely
  observes the carrier's own yaw. The already successful course error cancels
  body orientation algebraically, but uses center velocity; the corrected ray
  rate supplies distinct head-capture-point geometry near the target.

## Single-candidate policy hypothesis

Preserve the demonstrated controller verbatim outside a smooth terminal gate.
Inside `2L`, form a body-turn-cancelled head-ray rate as
`bearing_window_rate - turn_rate_recent`. Add its bounded sign directly to the
existing target-course request as a small intercept residual: it may reinforce
or oppose pursuit according to actual inertial line-of-sight rotation, but it
never replaces or gates off the base request. Apply the combined request only
to posterior mean steering before the existing acceleration reserve, while
leaving target intent for signed work allocation and every carrier and safety
mechanism unchanged.

The falsifiable expectation is capture with unchanged broad route and wake,
but a cleaner head intercept than either raw-bearing damping or corridor
release: improve on `-0.200045/2.08513L`, do not arrive later than `16.932T`,
and retain a crossing below `0.74389L` without posterior excursion above
`0.5993 rad`, speed contact, or force/yaw-moment peaks above
`0.0370/0.0184`. Reject the mechanism if it loses capture, changes the broad
trajectory, weakens alternating shedding, merely reduces terminal yaw while
repeating the worse distance integral, or increases joint/load use.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and terminal approach control
source_mechanism: preserve the propulsive rhythm while a bounded measured line-of-sight residual corrects terminal direction
transferable_invariant: separate target-ray motion from self-generated body oscillation, then modulate direction without withdrawing the base target request or traveling wave
nontransferable_details: published gains, dimensional rates and beat frequencies, species-specific kinematics, prescribed approach stages, exact vortex phases, capture radius, and task-specific routes
policy_translation: inside a normalized body-frame distance gate, subtract recent body turn from windowed target-bearing rate and add the bounded head-ray rate to posterior mean steering while retaining the joint-state carrier and all safety projections
falsification: reject if broad-route equivalence, capture, or coherent alternating shedding is lost, or if score, mean/final distance, terminal yaw, joint use, force, or yaw moment regress beyond the replicated prefill
```

No formal CFD is run in this worker. The candidate's rollout becomes evidence
only after this worker exits.

## Non-CFD projection after the edit

Reconstructing the adapter's seven-state bearing and turn windows over the
3,079 recorded prefill states gives 183 nonzero residuals, all between
`15.932T` and capture and all below `1.998L`; no broad-route state changes. The
body-turn-cancelled head-ray rate remains within `[-0.461,+0.583] rad/T` and
the bounded residual changes the assembled turn request by only
`[-0.0774,+0.0899]`, with `0.0440` mean absolute change. It reinforces the
base request in 81 terminal states and opposes it in 102, while output clamping
affects 13 already-near-saturated states. This confirms that the candidate is
localized, bounded, and distinct from an unconditional steering release. The
projection does not evolve the body or fluid and is not evidence that capture,
intercept geometry, loads, or score will improve.

## Contract checks after the edit

- The optimizer guidance check passes with a material reusable lesson, and the
  workspace boundary check confirms that the candidate is the only solver
  file changed from the permitted surface.
- The deterministic schema audit finds 32 direct `params.FIELD` references
  and all 32 fields in `target_policy_params()`, with no missing or unused
  field. A 20,000-state static mirror of the policy finds finite commands
  within the `1800 deg/T^2` envelope and zero reflection-equivariance error.
- The configured check-runner was invoked, but its fixed model is unavailable
  in this account. A supported read-only fallback reran its three commands:
  guidance and boundary checks pass; the native Julia contract command is
  unverified because `julia` is not installed. No CFD was run.
