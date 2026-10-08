# Phase-even posterior turn-shape candidate

## Completed evidence and visual diagnosis before editing

- Every sampled episode and the inherited posterior-approach episode is a
  finite `capture` initialized directly from uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm.  There is therefore no
  termination failure to compare.  The strongest semantic baseline remains
  v43 axis-selective energy launch: capture at `17.75400 T`, score
  `-0.07917`, and total/observed distance integrals `1.96508/1.34990 L`.
- Four completed approach-local alternatives do not materially improve that
  route.  Whole-carrier cadence retention, axial-gated cadence retention,
  divergence-retained turn, and posterior-only approach thrust all capture
  one solver step earlier at `17.74850 T`, but their observed integrals differ
  from v43 by less than `0.000062 L` and every total integral is worse by
  `0.00012-0.00132 L`.  Their apparent score ordering is dominated by how
  deeply the last discrete sample falls inside the capture sphere.  Approach
  acceleration-limit residence is `68.45%` for v43 versus
  `70.15/71.04/68.66/69.55%` for those four alternatives, so none establishes
  useful actuator relief.
- I inspected the combined and view-specific v43 and axial-cadence sheets from
  release through capture.  Their top-down rows show active self-propulsion on
  the same smooth target-signed arc, with compact startup vorticity developing
  into a coherent alternating posterior street.  Their oblique rows show the
  same compact paired Lambda2 structures following the caudal region, without
  collision, reversal, wake collapse, or boundary exit.  The other three
  approach variants have organized top-down rows but black oblique rows; those
  are rendering failures and cannot support a comparative 3D-wake claim.
- Reconstructed v43 feedback identifies a different limitation.  Mean
  de-gaited body-frame bearing grows from `0.171 rad` over `12-13 T` to
  `0.401`, `0.486`, and `0.581 rad` over `14-15`, `16-17`, and the final
  partial second, even though the bounded target-signed turn request already
  averages `-2.76`, `-2.57`, and `-2.45`.  More request or approach retention
  is therefore not the evidenced need.  The anterior acceleration is on its
  limit for `37.98%` of the full rollout while the posterior is there only
  `6.16%`; the organized carrier and unchanged `0.9603 L/T`, `0.03225`, and
  `0.01609` maximum speed/normalized-force/moment envelope support testing a
  different posterior state-to-actuator translation.

## One-candidate policy hypothesis

Materialize completed v43 as the base and preserve its target sensing,
redirect, carrier, launch allocation, crossflow pose confidence, cadence,
half-cycle steering, and componentwise actuator projection.  Add one bounded
posterior turn-shape residual: after the large-error redirect releases, use
the absolute normalized anterior-joint velocity as a phase-even measure of
active carrier motion, multiply it by the bounded target turn command, map the
result to a small posterior target-angle acceleration, and allocate it as a
target residual after the posterior carrier.  This asks the tail to express
needed curvature when the traveling wave is dynamically active, rather than
raising the already-persistent route request or consuming anterior carrier
authority.  The absolute phase envelope is reflection-even and the residual
is odd in an explicitly mirrored target command, so it introduces no new
phase-sign bias; zero turn request, a stopped carrier, or a fully active
redirect removes the residual continuously.

The intended signature is earlier contraction of body-frame bearing after
`12 T`, capture before `17.754 T`, and total/observed integrals below
`1.96508/1.34990 L`, while preserving the coherent two-view wake and the v43
speed, saturation, force, and moment envelope.  Reject the mechanism if it
merely changes the terminal sample, increases posterior limit residence
without checkpoint-wide closure, reverses the target-signed arc, or degrades
the wake.  The candidate's CFD runs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive thrust and robotic-fish phase-lag or wave-shape steering
source_mechanism: express a bounded turn through posterior traveling-wave shape while the carrier is moving, instead of increasing a saturated anterior command
transferable_invariant: when a coherent carrier and correct-sign route request persist but yaw response lags, couple target-signed posterior curvature to a reflection-even observed joint-motion envelope and preserve the carrier
nontransferable_details: published gains, dimensional cadence, species or robot curvature envelopes, exact vortex phases, open-loop oscillator phase, and task-specific routes
policy_translation: multiply the bounded body-frame turn command by absolute anterior joint velocity normalized by carrier frequency and amplitude, release it during the existing large-error redirect, convert the small posterior target-angle residual to acceleration, and allocate it after the posterior carrier projection
falsification: reject if bearing does not contract earlier, middle or late checkpoint closure and either distance integral fail to improve, capture is lost, posterior saturation or normalized loads grow materially, the residual's mirrored-command sign test fails, or readable two-view evidence loses the organized alternating wake
```

## Evidence boundary

All outcome and visual claims above come from completed sampled CFD, assigned
parent guidance, and inherited optimizer logs.  No same-worker CFD result is
claimed for the candidate below.

## No-CFD implementation audit

- The single candidate is
  `dogfish_target_control_v46_phase_even_posterior_turn_shape`, with SHA-256
  `19d2d9ad68d3517de954d24a595f04df40866e8da9cea9c087a2b0cd728c7bc4`.
  Its only control change from completed v43 is the phase-even posterior
  turn-shape residual and its carrier-first allocation.
- All `66` distinct direct `params.FIELD` references resolve against the `68`
  fields returned by `target_policy_params()`.  A targeted Julia comparison
  confirms that a stopped anterior carrier is exactly v43-equivalent; in a
  moderate active-turn state the anterior action is unchanged while only the
  target-signed posterior action changes.  Explicit equal-and-opposite turn
  commands give equal-and-opposite shape residuals, a fully active redirect
  suppresses the residual to zero, and all tested actions are finite and
  componentwise bounded.
- Frozen-trace reconstruction on completed v43 changes anterior action by
  exactly zero, changes posterior action by at most `3.5544 rad/T^2` with a
  mean absolute change of `1.0555 rad/T^2`, and raises reconstructed posterior
  acceleration-limit residence only from `6.13%` to `6.26%`.  These are
  structural bounds on prior states, not a closed-loop performance claim.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account.  Its three exact non-CFD commands were run
  locally and separately: the material-guidance check, lightweight Julia
  contract, and solver editable-boundary check all pass.  The guidance check
  first exposed and then passed after removal of a duplicated assigned-parent
  marker in the rendered workspace README.  No formal CFD was run.
