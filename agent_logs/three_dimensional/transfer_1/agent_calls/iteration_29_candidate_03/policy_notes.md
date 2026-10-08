# Terminal posterior-reserve candidate

## Completed evidence and visual diagnosis before editing

- All four sampled solver examples are finite `capture` episodes initialized
  directly from uniform still water with `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm snapshot.  The assigned v43 axis-selective parent remains the
  strongest completed policy: it captures at `17.75400 T`, score `-0.07917`,
  and total/observed distance integrals `1.96508/1.34990 L`.  Its mean/max
  speed, any-joint acceleration-limit residence, and peak normalized planar
  force/moment are about `0.7168/0.9603 L/T`, `44.14%`, and
  `0.03225/0.01609`.
- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  from release through capture.  The parent and the readable axial-cadence
  sample actively self-propel on the same smooth target-signed arc: a compact
  startup disturbance develops into an organized alternating posterior wake,
  with no advection-only motion, collision, domain exit, reversal, or wake
  collapse.  The response-cadence and divergence-retained samples have the
  same organized top-down wake, but their oblique rows are black rendering
  failures and cannot establish a comparative 3D-wake improvement.
- The two completed response-retained cadence variants capture one solver step
  earlier at `17.74850 T`, but worsen score to `-0.08082/-0.08064` and total
  integral to `1.96640/1.96625 L`; their observed integrals improve by only
  about `0.00005/0.00006 L`.  Thus retaining the whole-carrier cadence across
  the full `2.1 L` approach does not survive the score, saturation, and visual
  evidence as a reusable improvement.
- Divergence-retained approach steering also captures at `17.74850 T`, but
  slightly regresses score and total/observed integrals to
  `-0.07942` and `1.96528/1.34987 L`.  It is `0.0009-0.0063 L` farther away
  at fixed checkpoints from `16.5-17.25 T`, and its mean raw late bearing
  increases to about `0.612 rad` rather than contracting from the parent's
  `0.599 rad`.  It becomes `0.0036-0.0046 L` closer only around
  `17.70-17.74 T`, so increasing the pose loop across the whole approach is
  not the missing steering mechanism.
- An inherited completed posterior-only approach-wave residual shows the same
  localization signature.  It captures at `17.74850 T`, score `-0.07933`, and
  total/observed integrals `1.96520/1.34985 L`; relative to v43 it is initially
  farther from `16.25-17.25 T`, but leads by `0.0019/0.0035/0.0033 L` at
  `17.50/17.70/17.74 T`.  The inherited energy-conditioned axial launch bridge
  is a larger negative (`17.76500 T`, `-0.08764`, `1.97361/1.35867 L`).
  Together these results rule out more launch authority and isolate a terminal
  response-allocation test: preserve the completed route until the late band
  where posterior emphasis first becomes useful.

## One-candidate policy hypothesis

Start from the assigned v43 parent and preserve its state-feedback carrier,
target sensing, selective crossflow pose confidence, target-signed curvature,
launch split, cadence schedule, half-cycle steering, and carrier-first
spillover.  Add one bounded zero-mean posterior traveling-wave reserve only
inside a normalized terminal distance band.  Productive measured closing and
available turn authority gate the reserve; distance, weak closing, or steering
load release it continuously.  The new term cannot alter the anterior action,
route mean, redirect mean, or actuator envelope.

The terminal gate begins at `1.15 L` and reaches full authority over the next
`0.40 L`, matching the completed checkpoint at which approach-wide posterior
emphasis changes from an initial lag into a late lead.  This is a normalized
geometry schedule, not a clock or memorized world route.  Frozen-trace
expectation is byte-equality with v43 before roughly `17.2 T`, weaker authority
than the completed approach-wide residual near its onset, comparable authority
near `0.9 L`, and stronger but still bounded posterior authority immediately
before capture.  The intended CFD signature is capture no later than
`17.74850 T` with a deeper terminal sample and total/observed integrals below
`1.96508/1.34990 L`, while retaining the organized two-view wake and remaining
within the parent's speed, saturation, force, and moment envelope.  Formal CFD
occurs only after this worker exits; none of those intended outcomes is claimed
here.

```text
bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive thrust and sensor-modulated robotic-fish CPG control
source_mechanism: tail-end traveling-wave kinematics supply reactive thrust, while sensor feedback confines gait emphasis to the state in which useful task response is observed
transferable_invariant: a bounded posterior propulsion reserve should preserve the established carrier and activate only when normalized target geometry and closing response identify a terminal intercept with steering headroom
nontransferable_details: published gains, dimensional amplitudes or frequencies, species and robot kinematics, full-body envelopes, exact vortex phases, and task-specific routes
policy_translation: add a smooth normalized-distance gate to a zero-mean posterior-wave residual, multiply it by productive body-frame closing and one-minus target-derived turn load, and preserve all anterior, route-mean, redirect, and componentwise projection logic
falsification: reject if the candidate loses capture, fails to improve fixed-time terminal closure and both distance integrals, changes the pre-terminal route, raises persistent saturation or the completed speed/load envelope, or a readable two-view rollout loses the organized alternating wake
```

## Evidence boundary

All completed outcomes and visual claims above come from the assigned parent,
sampled solver results, inherited optimizer logs, and inherited durable
guidance.  The candidate below has no same-worker CFD evidence.

## No-CFD implementation audit

- The single candidate is
  `dogfish_target_control_v46_terminal_posterior_reserve`, with SHA-256
  `cd7c21af1d7f0507904e27af716b833345f41c98b7e3ffdbe1bb1d2ed111db21`.
  All `68` distinct direct `params.FIELD` references resolve against the `70`
  fields returned by `target_policy_params()`.
- On the completed parent trace, the new distance gate is exactly zero until
  about `17.1985 T` (`1.1487 L`).  At `1.10/0.90/0.75 L` its authority is
  `0.125/0.625/1.000`, versus `0.476/0.571/0.643` for the completed
  approach-wide posterior residual.  This confirms the intended shift away
  from the evidenced early lag and toward the late lead; it is a frozen-trace
  localization check, not a closed-loop result.
- A targeted Julia comparison is byte-equal to v43 outside the terminal band
  and under zero closing response.  In a productive `0.85 L` synthetic state,
  the anterior action remains exactly `-26.28206 rad/T^2` while only the
  posterior action changes from `13.30134` to `11.98752 rad/T^2`; all tested
  actions are finite and remain within the componentwise acceleration limit.
- The configured check runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account.  Its three prescribed commands were run
  locally and separately.  The material-guidance check first exposed a
  duplicated assigned-parent marker in the rendered workspace `README.md`;
  after removing that duplicate, the guidance, lightweight Julia contract,
  and solver editable-boundary checks all pass.  No formal CFD was run.
