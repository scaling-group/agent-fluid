# Evidence-selected phase-even posterior turn-shape candidate

## Completed evidence and visual diagnosis before editing

- All four assigned rollouts are finite `capture` episodes initialized directly
  from uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm.  The sampled v46 phase-even posterior turn-shape controller is the
  strongest completed result: it captures at `17.64401 T`, score `-0.07419`,
  and total/observed distance integrals `1.95985/1.34371 L`.  The v43
  axis-selective parent captures at `17.75400 T`, score `-0.07917`, and
  `1.96508/1.34990 L`; the posterior-only approach-thrust and axial-confident
  approach-wave variants both capture at `17.74850 T` without a meaningful
  route-integral improvement over v43.
- The phase-even controller is closer than v43 at every `2 T` checkpoint from
  `2-12 T`, by `0.0075-0.0508 L`.  It trails slightly at `14/16 T` by
  `0.0068/0.0110 L`, then crosses the capture boundary `0.1100 T` earlier.
  This is a route-wide improvement rather than only a deeper terminal sample:
  its observed integral improves by `0.00619 L` and its total integral by
  `0.00523 L`.
- I inspected all four combined sheets from release through capture.  Every
  top-down row shows active self-propulsion on a smooth target-signed arc, with
  the compact startup disturbance developing into an organized alternating
  posterior vorticity street; there is no passive advection, collision,
  reversal, boundary exit, or wake collapse.  The v43, phase-even, and
  axial-confident approach-wave oblique rows are readable and show compact
  paired Lambda2 structures following the caudal region through capture.  The
  posterior-only approach-thrust oblique row is black, so it is a rendering
  failure and cannot establish a comparative 3D-wake benefit.
- Trace diagnostics support preserving the phase-even mechanism.  Relative to
  v43, mean/max speed changes only from `0.71678/0.96031` to
  `0.71993/0.96625 L/T`, any-joint acceleration-limit residence falls from
  `44.14%` to `43.83%`, and peak normalized planar force/moment remains
  `0.03225/0.01609`.  Its late crossing is more oblique: final heading error is
  `0.2910 rad` versus `0.0518 rad` for v43, so the result supports faster
  first-crossing capture but not a general terminal-hold or alignment claim.

## One-candidate policy decision

Replace the weaker prefilled axial-confident approach-wave candidate with the
completed sampled v46 phase-even posterior turn-shape controller exactly.
Preserve its carrier, target sensing, redirect, launch governor, selective
crossflow pose confidence, cadence, half-cycle steering, spillover allocation,
and componentwise projection.  Its one distinguishing mechanism maps the
bounded body-frame turn request through a reflection-even anterior-joint
motion envelope into a small posterior wave-shape residual, and releases that
residual during the large-error redirect.  This uses posterior authority while
the traveling wave is active without adding a fixed route, clock, direct flow
steering, or another scalar-only gain experiment.

The intended formal-evaluation signature is reproduction of capture near
`17.644 T`, total/observed integrals near `1.95985/1.34371 L`, the organized
two-view alternating wake, and the sampled speed/action/load envelope.  Reject
the selection if direct-uniform reevaluation loses capture, regresses behind
v43 in either integral or middle-route closure, materially raises saturation
or normalized loads, or loses the coherent wake.  Treat terminal alignment as
an open held-out question because first-crossing capture ends the sampled
episode.  The candidate's CFD runs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive thrust and robotic-fish phase-lag or wave-shape steering
source_mechanism: express target-signed curvature through posterior traveling-wave shape while the observed carrier is active instead of increasing an already saturated anterior command
transferable_invariant: couple a bounded target-derived posterior curvature residual to a reflection-even observed joint-motion envelope while preserving the coherent traveling-wave carrier
nontransferable_details: published gains, dimensional cadence, species or robot curvature envelopes, exact vortex phases, open-loop oscillator phase, and task-specific routes
policy_translation: multiply the bounded body-frame turn command by absolute anterior joint velocity normalized by carrier frequency and amplitude, release it during the existing large-error redirect, convert the small posterior target-angle residual to acceleration, and allocate it after the posterior carrier
falsification: reject if capture or either distance integral regresses, checkpoint-wide closure is lost, posterior saturation or normalized loads grow materially, reflection symmetry fails, or readable two-view evidence loses the organized alternating wake
```

## Evidence boundary

All outcome and visual claims above come from completed sampled CFD, the
assigned parent guidance, and inherited optimizer notes.  No same-worker CFD
result is claimed for this candidate.

## No-CFD implementation audit

- The single candidate is
  `dogfish_target_control_v46_phase_even_posterior_turn_shape`, with SHA-256
  `19d2d9ad68d3517de954d24a595f04df40866e8da9cea9c087a2b0cd728c7bc4`;
  it is byte-identical to the completed strongest sampled policy.
- All `66` distinct direct `params.FIELD` references resolve against the `68`
  fields returned by `target_policy_params()`.  The lightweight Julia contract
  loads the policy and returns two finite accelerations from the representative
  state.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account.  Its three exact non-CFD commands were run
  locally and separately: the material-guidance check, lightweight Julia
  contract, and solver editable-boundary check all pass.  No formal CFD was
  run.
