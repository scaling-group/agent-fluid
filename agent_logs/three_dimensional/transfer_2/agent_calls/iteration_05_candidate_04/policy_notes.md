# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- All four sampled rollouts report direct uniform still-water initialization
  (`U_infinity=[0,0,0]`), no cylinders, and no prewarm.  Their translation and
  wakes are self-generated.  The useful `0.55T/28 deg` carriers show a strong
  alternating mid-plane wake and compact three-dimensional Lambda2 structures;
  local body-frame flow remains roughly `0.02U` while body speed is commonly
  `0.6--0.8U`, so imposed advection or a wake-rejection residual is not the
  evidenced limitation.
- Both visual rows of the strongest sampled rollout
  (`solver_e3aa71fd7b95`) and the contrasting slow-carrier failure
  (`solver_a1d9e06dfe8a`) were inspected and cross-checked against metrics,
  diagnostics, and trajectories.  The slow, soft-limited policy has a weaker
  but coherent wake, reaches only `8.752L`, and exits above at `14.911T`.
  Global cadence reduction therefore remains a poor substitute for steering.
- One-sided posterior half-cycle attenuation is a genuine reusable gain.  From
  the curvature-release parent (`solver_045019f39c2a`) to the evaluated
  phase-selective child (`solver_e3aa71fd7b95`), minimum distance improves from
  `4.141L` to `3.033L`, mean distance from `8.947L` to `8.346L`, and survival
  from `32.197T` to `40.331T`; the exit moves from the lower edge to the left
  edge while wake coherence persists.  The sibling balanced phase-allocation
  rollout in inherited logs instead reaches only `3.965L`, exits below at
  `33.555T`, and finishes at `10.163L`.  Preserve attenuation of only the
  opposing posterior half-cycle; do not strengthen the complementary half or
  replace this result with another scalar phase-allocation gain.
- The remaining miss is localized geometrically.  In the evaluated parent the
  normalized body-frame forward target component falls to about `0.05` near
  `20.999T`; at the `23.238T` closest pass the target is already behind and far
  to the side, with body-frame target components about `(0.672, 2.957)L`.
  Distance then rises monotonically enough for the fish to pass below the
  target and continue left.  The inherited always-on negative mean-bend tests
  curled upward almost at release even below `0.5 deg`, so the evidenced
  polarity can be useful only behind a gate that is dormant during the initial
  aligned approach and releases through target geometry rather than the
  subcycle `turn_rate_recent` signal.

## Policy hypothesis

Retain the evaluated one-sided phase-selective carrier exactly through the
front-target approach.  Add one bounded burst-redirect mechanism inside the
posterior target, upstream of acceleration clipping: when the existing
wrong-polarity curvature release is active and the normalized body-frame target
enters a smooth abeam-to-posterior sector, add a small route-signed mean tail
tangent of the empirically correct opposite polarity.  Release it continuously
as the target returns forward or becomes aligned.  This uses the completed
upper-turn failures as a polarity calibration without copying their unsafe
always-on timing.

The expected closed-loop signature is bit-for-bit preservation of the early
carrier branch while the target remains clearly forward, followed by an upward
course redirect near the sampled `3.033L` pass and either capture, a return
approach, or a materially better termination trajectory.  Falsify the mechanism
if it activates near release, recreates the early upper-exit topology, destroys
the alternating wake, increases raw envelope exposure materially, or retains
the same below-target left exit without a useful distance/trajectory change.

bookshelf_consulted: true
source_domain: biological C-start or burst redirection and sensor-modulated robotic-fish CPG turning
source_mechanism: apply bounded high-curvature steering only for a large directional error, then release it when observed geometry shows the target returning to the forward sector
transferable_invariant: keep the propulsive rhythm separate from a brief response-gated redirect whose sign comes from body-frame route error
nontransferable_details: published gains, species-specific bend envelopes, clock-driven burst duration, motor timing, exact vortex phase, dimensional cadence, and task-specific routes
policy_translation: combine normalized body-frame target posteriority with the existing off-axis curvature-release gate, add a bounded signed mean tail tangent inside the two-joint state-feedback carrier, and release continuously when either geometric condition clears
falsification: reject the transfer if the front-target approach changes, the sampled upper curl returns, wake coherence or actuator exposure worsens, or no semantic or useful trajectory improvement appears after the closest-pass sector

## Pre-evaluation checks

- Recorded-state replay of the evaluated parent and this candidate over all
  `7333` sampled states is action-identical whenever the new posterior-sector
  gate is closed.  The new bend first becomes nonzero at `20.240T`, shortly
  before the parent's `23.238T` minimum, is active on `33.7%` of the full
  trace, and reaches `2.840 deg` under its `3 deg` bound.  It changes only the
  posterior raw command, by at most `8.322 rad/T^2` on those fixed states.
- On the same counterfactual replay, exposure to at least one raw command above
  `1800 deg/T^2` changes from `93.65%` to `92.96%`, tail-only exposure from
  `55.15%` to `54.13%`, and mean summed absolute command from `86.02` to
  `85.46 rad/T^2`.  These reconstructed-state figures establish selectivity
  and no algebraic increase in clipping burden; they do not predict the
  closed-loop CFD trajectory, which remains deferred to EvE.
- The lightweight Julia policy contract passes.  All `62` direct
  `params.FIELD` references resolve among the `64` fields returned by
  `target_policy_params()`, and a `42525`-state grid over target geometry,
  bearing, yaw rate, and both joint states remains finite.  Mirrored posterior
  target tests give opposite redirect signs within the same `3 deg` bound.
- The configured check-runner was invoked, but its pinned model is unavailable
  for this account.  Its three prescribed no-CFD commands were therefore run
  directly and separately: the semantic guidance delta, Julia policy contract,
  and solver editable-boundary checks pass.  The guidance checker initially
  exposed a duplicate identical assigned-parent marker in the rendered
  `README.md`; removing only that redundant entry lets it resolve the existing
  assigned parent unambiguously.
