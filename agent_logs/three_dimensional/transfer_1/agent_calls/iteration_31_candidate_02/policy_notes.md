# Evidence-selected phase-even posterior turn-shape promotion

## Completed evidence and visual diagnosis before editing

- All four sampled rollouts are finite `capture` episodes initialized directly
  from uniform still water with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm snapshot.  Three samples are byte-identical copies of the phase-even
  posterior turn-shape controller and reproduce capture at `17.64401 T`, score
  `-0.07419`, and total/observed distance integrals `1.95985/1.34371 L`.
- The assigned prefill is the informative negative comparator.  Its
  axial-confident posterior approach-wave residual captures at `17.74850 T`,
  score `-0.07899`, and total/observed integrals `1.96493/1.34985 L`.
  Relative to it, the phase-even controller is closer at every `2 T`
  checkpoint through `12 T`, gives back only `0.0071/0.0106 L` at `14/16 T`,
  and then captures `0.10450 T` earlier.  This is a route and integral change,
  not merely a deeper terminal sample.
- I inspected the combined and view-specific sheets from release to capture.
  Both policies self-propel along a smooth target-signed arc; compact startup
  vorticity develops into a coherent alternating posterior street rather than
  passive advection, wasteful standing oscillation, collision, or reversal.
  Two of the three phase-even samples and the comparator have readable oblique
  rows with compact paired caudal Lambda2 structures through capture.  The
  remaining phase-even oblique sheet is black and is treated as a rendering
  failure, not supporting evidence.
- The metric cross-check attributes the improvement to actuator allocation,
  not more carrier drive.  Relative to the comparator, mean/max speed changes
  only from `0.71699/0.96031` to `0.71993/0.96625 L/T`; anterior/posterior
  acceleration-limit residence shifts from `37.96/6.23%` to `35.97/8.10%`,
  and any-joint residence falls from `44.19%` to `43.83%`.  Peak componentwise
  normalized force and moment remain in the inherited `0.03225/0.01609`
  envelope.  The assigned-parent guidance and inherited step-29/30 notes
  likewise identify persistent target-signed request plus occupied anterior
  authority, and explicitly select the posterior state-to-actuator mapping
  over another proximity-gated thrust term.

## One-candidate policy decision

Replace the assigned axial-confident approach-wave prefill with the completed
phase-even posterior turn-shape controller byte-for-byte.  Preserve its
target sensing, mean-preserving carrier-pose rejection, selective crossflow
confidence, redirect, launch governor, cadence, half-cycle steering,
carrier-first spillover, and componentwise projection.  Remove the unsupported
approach-only propulsion residual and retain one small posterior wave-shape
residual: multiply the bounded body-frame turn command by absolute normalized
anterior-joint velocity, release it during the large-error redirect, convert
the target-angle residual to acceleration, and allocate it after the posterior
carrier.  This uses observed joint motion rather than a clock or route stage;
the motion envelope is reflection-even and the target request is odd, so the
added steering mirrors with the target.

The next evaluation should reproduce capture near `17.644 T`, both distance
integrals at or below `1.95985/1.34371 L`, the early-to-middle checkpoint lead,
and the established speed/action/load envelope.  Reject the mechanism if it
loses capture or the target-signed arc, returns either integral to the
approach-wave band, materially increases posterior saturation or normalized
loads, fails mirrored-command symmetry, or loses the coherent wake in a
readable two-view rollout.  The current candidate's CFD runs only after this
worker exits; no same-worker outcome is claimed.

```text
bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive swimming and sensor-modulated robotic-fish wave-shape steering
source_mechanism: preserve a traveling carrier while expressing bounded turning through posterior wave shape during observed carrier motion
transferable_invariant: when coherent propulsion and a correct-sign body-frame route request persist but anterior authority is occupied, couple target-signed posterior curvature to a reflection-even observed joint-motion envelope
nontransferable_details: published gains, dimensional cadence and amplitude, species or robot curvature envelopes, exact vortex phases, clocked CPG phase, and task-specific routes
policy_translation: normalize absolute anterior joint velocity by the state-feedback carrier scale, multiply it by the bounded body-frame turn command, release it under the existing geometric redirect, convert the small posterior target angle to acceleration, and retain carrier-first componentwise projection
falsification: reject if the replicated arrival and integral gains fail, capture or target-signed curvature regresses, posterior saturation or normalized loads grow materially, mirrored target commands do not mirror the residual, or readable two-view evidence loses the organized alternating wake
```

## Evidence boundary

Outcome and visual claims above come from the assigned parent guidance,
sampled completed solver results, and inherited optimizer notes.  The source
shelf supplies only the qualitative posterior wave-shape invariant; completed
rollouts are the reason for selecting this candidate.

## No-CFD implementation audit

- The sole candidate is
  `dogfish_target_control_v46_phase_even_posterior_turn_shape`, SHA-256
  `19d2d9ad68d3517de954d24a595f04df40866e8da9cea9c087a2b0cd728c7bc4`,
  byte-identical to each of the three completed winning samples.
- All `66` distinct direct `params.FIELD` references resolve against the `68`
  fields returned by `target_policy_params()`.  The lightweight Julia contract
  returns two finite accelerations.  Target-sign reversal mirrors the posterior
  residual exactly, while a stopped anterior carrier or fully active redirect
  reduces that residual to zero; final projection remains finite and bounded.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable for this account.  Its three exact checks were therefore run
  locally and separately: material guidance/notes, lightweight Julia policy
  contract, and solver editable-boundary checks all pass.  The first check
  initially exposed two inherited copies of the same assigned-parent marker in
  the rendered `README.md`; removing one duplicate made the parent unambiguous.
  No formal CFD was run.
