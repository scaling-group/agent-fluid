# Hydrodynamic-opposition posterior phase candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts and both relevant inherited step-21 rollouts
  satisfy the frozen contract: direct uniform `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and capture. Across their combined
  sheets, the body advances from quiescent release ahead of a coherent
  alternating top-down vortex street; the oblique row shows compact paired
  Lambda2 structures following the swimmer. The target-directed paths have
  tail-beat waviness but no passive advection, wake collapse, collision,
  boundary excursion, or terminal loop. Sparse keyframes do not resolve the
  small timing differences, so those differences are cross-checked below
  against trajectory and load diagnostics.
- The assigned actuator-consistent parent is the strongest sampled case: it
  captures at `18.67250T`, has mean score distance `2.02129L`, and scores
  `-0.13362`. Its speed comes with `76.14%` posterior acceleration-limit
  occupancy and `0.01350/0.00703` force/moment RMS, although local-flow RMS is
  only `0.01809U`. Current-demand recruitment, demand lead, headroom
  allocation, and half-cycle-only steering all capture later at
  `18.79899T`, `18.78799T`, `18.83199T`, and about `18.931T`, respectively.
- The inherited step-21 results are concrete negative controls. Restricting
  phase to a positive raw-demand deficit delays capture to `18.98049T`,
  worsens the score to `-0.15551`, and still leaves `75.60%` posterior limit
  occupancy and `0.01345/0.00700` loads. Complementing phase recruitment with
  amplitude-asymmetry release reduces posterior occupancy to `74.16%` and
  loads to `0.01336/0.00696`, but delays capture to `18.74950T` and scores
  `-0.14192`. Thus neither a command-magnitude residual nor a wholesale
  amplitude-to-phase handoff isolates the useful phase response.
- The assigned-parent trace exposes a physically distinct selector. The
  normalized hydrodynamic yaw moment opposes the requested recoil-conditioned
  yaw response in `63.4%` of all samples and `65.6%` of strong-response
  samples; its opposing RMS is `0.00742`, versus `0.00395` while helping.
  Reconstructing the existing phase gate shows that when recruitment exceeds
  `0.1`, the moment still opposes the requested correction in `59.8%` of
  samples, with opposing/helping RMS `0.00783/0.00459`. The current gate
  therefore recruits phase through both helpful and adverse hydrodynamic
  response, while the failed refinements looked only at actuator demand.

## Policy hypothesis recorded before editing

Preserve the parent's normalized body-frame bearing and LOS-rate request,
recoil-conditioned yaw response, distributed C-bend, response-reversing
half-cycle, persistent same-side actuator gate, fixed-norm posterior phase
rotation, and componentwise feasibility projection.

Add one wake/body-response selector after the existing phase gate. Form the
reflection-invariant product of the signed yaw-response request and the
already normalized `moment_z_L2`. A smooth opposition gate retains phase
recruitment when the measured hydrodynamic moment opposes the requested yaw
correction and releases it when the moment already helps. This does not add
carrier, route, amplitude, phase-angle, or limit authority; it replaces
command-only timing with direct physical response timing while remaining
memoryless, scale-normalized, and reflection-equivariant.

Support requires capture no later than the complementary handoff's
`18.74950T`, preferably retaining the parent's `18.67250T` timing, while
reducing posterior occupancy or force/moment load below
`76.14%` and `0.01350/0.00703`. Falsify the mechanism if capture is lost,
arrival exceeds the half-cycle comparator near `18.931T`, the alternating
wake weakens, load exceeds the assigned parent, or the path merely reproduces
the slower command-residual or complementary-handoff trajectories. Current
evidence has only about `0.018U` local-flow RMS, so stronger-wake robustness is
not claimed.

The structured bookshelf reconsultation trigger is not met: the completed
step-19 through step-21 lineage introduced phase recruitment, actuator-trend
and consistency gating, demand-residual gating, and complementary actuator
handoff, while retaining semantic capture. No bookshelf source supplies this
edit; the normalized moment selector comes from the sampled and inherited
rollout diagnostics, so no source-transfer block is asserted.

The candidate's CFD result is not claimed here; it becomes evidence only after
this worker exits.
