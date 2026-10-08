# Axial-response-conditioned posterior phase-lag candidate

## Evidence diagnosis before the policy edit

- All four assigned rollouts satisfy the frozen experiment contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders
  or prewarm, finite dynamics, and capture. The three terminal-LOS sources
  `solver_0d0db1d9cf71`, `solver_144c414f516d`, and
  `solver_83b9554e9569` are byte-identical in trajectory and combined sheet;
  they capture after 2,867 steps at `15.768509T`, use 232 moving-window
  shifts, cross at `0.745720148L`, have distance integral `1.924067164L`, and
  score `-0.041674176`. The axial-response parent
  `solver_6f6a10775fde` has the same arrival step, shifts, joint extrema,
  limit residence, and force/moment peaks, differing only at the crossing
  (`0.745725095L`, integral `1.924071330L`, score `-0.041679331`). Thus the
  present sample provides no support for another terminal-rate, onset, or
  curvature edit.
- I inspected the combined sheets for the replicated best
  `solver_0d0db1d9cf71` and the slightly weaker finite control
  `solver_6f6a10775fde` from release through capture. Both top-down rows show
  a release transient developing by `4T` into a coherent alternating lateral
  wake and a smooth target-directed arc. Both oblique body/Lambda2 rows show
  compact three-dimensional caudal structures without collision, wake
  collapse, virtual-boundary exit, or out-of-plane instability. Because the
  background velocity is exactly zero, the motion is self-propelled rather
  than advected. Their terminal difference is below sheet resolution and the
  best three sheets are byte-identical. No failed-termination sheet is present
  in this allocation, so the weaker capture is the informative visual control
  and inherited failed trajectories are not promoted into new visual claims.
- The inherited logs establish the route-scale mechanism worth preserving.
  Compared with the replicated forward-speed-only posterior boost, adding the
  axial-force response selector advanced capture from `15.977511T` to
  `15.768509T`, reduced distance integral from `1.928580797L` to about
  `1.92407L`, and reduced shifts from 238 to 232 while preserving the
  coherent two-view wake. It advanced the `6/4/2/1.25L` milestones, although
  it delayed the `8L` milestone by about `0.011T`, raised posterior
  acceleration-limit residence from `22.58%` to `23.58%`, and increased
  posterior excursion from `33.1` to `34.7 deg`. The current sample confirms
  that the tiny LOS change leaves those route and load quantities unchanged.
  Response allocation is therefore positive evidence, but a larger wave gain
  or another terminal scalar is not.
- The present positive-force endpoint multiplies both terms of the posterior
  target, `-q1 - tail_lag_gain*qd1/omega`. It therefore mixes a general
  amplitude increase with the directional quadrature term that creates the
  two-joint traveling bend. The sampled improvement does not identify which
  term is responsible, while its higher limit residence and mixed early
  milestones make that distinction a useful architecture test. The inherited
  adverse-force-relief proposal is unevaluated in the assigned sample; this
  candidate does not duplicate it or treat it as positive evidence.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: Lighthill-style reactive tail propulsion and sensor-modulated robotic-fish CPG phase control
source_mechanism: preserve an anterior rhythm and base posterior wave while measured propulsive response reinforces the posterior quadrature that carries bend phase downstream
transferable_invariant: tail-directed traveling-wave motion depends on a lagged posterior response, so bounded sensory authority can reinforce the lag component without scaling the entire body-bend amplitude
nontransferable_details: published gains, dimensional frequencies, species-specific amplitude envelopes, exact Strouhal values, exact tail or vortex phases, clock-defined bursts, and task-specific routes
policy_translation: retain the evaluated normalized body-forward speed and axial-force gates, the full base posterior target, navigation, approach, terminal response, and actuator projection; replace only the positive-response supplemental endpoint so it adds a bounded fraction of the normalized anterior-velocity quadrature rather than multiplying both posterior target components
falsification: reject if early or later distance milestones regress, capture is delayed or lost, the alternating two-view wake loses coherence, distance integral worsens, or reduced limit residence occurs without retaining target progress; also reject the phase interpretation if the full-wave endpoint clearly outperforms this isolated lag endpoint

## One candidate hypothesis

Keep the assigned parent's anterior oscillator, body-frame target steering,
redirect, approach scheduling, translational line-of-sight terminal response,
mean-first posterior allocation, and exact velocity-boundary projection
unchanged. Keep the evaluated low-forward-speed eligibility and positive axial
force response gate unchanged as well. Change only what its supplemental
posterior endpoint represents: under positive measured axial response, add a
bounded fraction of `-tail_lag_gain*qd1/omega` to the full base posterior wave
instead of multiplying the complete `-q1 - tail_lag_gain*qd1/omega` target.
At zero or adverse force the proven base wave remains available; after forward
speed recovery the candidate is exactly the assigned carrier. The inherited
`0.25` bound is reused to isolate this mechanism change rather than invent a
new gain sweep.

This is a phase-structure experiment, not scalar-only amplitude tuning. Its
falsifiable expectation is that concentrating the response-selected increment
on the traveling-bend quadrature will retain the axial allocator's later
milestone and capture gain while reducing unproductive displacement growth,
posterior limiting, or the inherited `8L` delay. If the response-selected
in-phase `-q1` increment was actually essential, the candidate should lose
that route advantage and the mechanism must be rejected. Formal CFD occurs
only after this worker exits, so no outcome for this candidate is claimed
here.

## Non-CFD verification after the edit

- Candidate SHA-256 is
  `e818cdd7b62d1ec78b8d7ebb71876cc09b37d31d0692c8d4eed5e49331d236a0`.
  Its executable diff from the assigned prefill changes only the supplemental
  posterior endpoint and its owned parameter name; the anterior, navigation,
  approach, terminal, allocation, and actuator-projection code is unchanged.
- The deterministic schema audit resolves all 52 direct `params.FIELD`
  references against exactly the 52 fields returned by
  `target_policy_params()`, with no missing or unused field. The lightweight
  Julia contract returns two finite accelerations.
- An exhaustive 28,812-state endpoint and reflection sweep finds 4,020 early
  states where positive axial response changes feasible posterior action,
  with maximum action difference `10.9418 rad/T^2`. The response produces no
  action change after normalized forward speed exceeds the existing recovery
  envelope and no change when anterior velocity quadrature is zero. All
  actions remain within `1800 deg/T^2`, lateral-reflection error is exactly
  zero, and non-finite observation fallbacks remain finite. This establishes
  that the new branch is state-supported and non-clamp-equivalent without
  predicting its unevaluated closed-loop CFD response.
- The configured `.codex/agents/check-runner.toml` was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this account. Its three prescribed
  checks were run directly and separately: guidance materiality, the
  lightweight Julia policy contract, and solver editable-boundary enforcement
  all pass. No CFD was run.
