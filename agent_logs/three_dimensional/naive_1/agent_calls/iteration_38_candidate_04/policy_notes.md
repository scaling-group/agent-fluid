# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled episodes satisfy the frozen direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window
  transport, and capture termination. The two executable-identical
  common-envelope redistribution runs capture at `18.8265--18.8815T` with
  mean distance `2.08855--2.08896L`; the unexercised rearward composition
  captures at `18.9640T` and `2.09072L`; and the clean geometry-envelope
  ablation captures at `18.6010T` and `2.09042L`. Their score differences do
  not establish distinct actuator relief: acceleration contact remains about
  `60.85--61.17%`/`72.95--73.27%`, rate contact about
  `10.96--11.13%`/`14.76--14.96%`, peak planar force
  `0.03066--0.03259`, and peak yaw moment `0.01603--0.01656`.
- I inspected the combined keyframe sheets for the best sampled redistribution
  capture and the clean capture from direct release through first crossing.
  Their top-down rows grow coherent alternating target-bending streets from
  quiescent water, while their oblique rows retain compact bilateral and
  caudal Lambda2 structures. Translation is therefore self-propelled rather
  than advected; neither sheet shows collision, wake collapse, domain exit,
  or numerical instability.
- The sampled batch has no failure-class sheet, so I also inspected the
  inherited clean-policy failure selected by the lower-Elo optimizer example.
  It keeps an energetic alternating top-down street and compact oblique caudal
  structures, but passes below the target at `0.96285L`, rotates into a
  downward trajectory, and exits left at `33.979T` and `10.44465L`. Its finite
  loads agree with the images: the failure is route response, not loss of
  propulsion or numerical stability.
- This inherited failure materially revises the assigned-parent boundary. The
  clean geometry-envelope policy no longer has only captures: the inherited
  executable is the same clean architecture as the sampled `18.6010T`
  capture, yet it misses. Thus neither clean amplitude relief nor
  phase-redistributed relief has established semantic robustness; choosing
  between them by a roughly `0.002L` mean-distance difference is not a new
  mechanism.
- A seven-row reconstruction of the observation history exposes a more direct
  discriminator. In the best redistribution capture, yaw rate has the nominal
  correcting sign while signed target bearing is non-improving on only
  `8/1603` yaw-correcting rows. In the inherited clean near-miss/exit, that
  disagreement occurs on `1376/3033` yaw-correcting rows. Near `3L`, the
  failure has 315 such disagreement rows. The current response gate can
  therefore release curvature merely because the body yaws correctly even
  while translation makes target-relative bearing worse.
- Assigned-parent guidance and inherited logs already reject scalar carrier
  retuning, velocity phase prediction, posterior-state phase voting,
  posterior-only allocation, rate barriers, target-axis observation
  filtering, terminal velocity residuals, stacked broadside/rearward recovery,
  and removal of response release. The new test preserves response release but
  changes its response observation.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: biological burst redirect and closed-loop robotic-fish direction tracking
source_mechanism: apply strong bounded target-signed curvature during redirect and release it only after sensed route response appears while a coupled rhythmic carrier preserves propulsion
transferable_invariant: distinguish target-relative route improvement from body rotation when deciding whether to release steering authority
nontransferable_details: published gains, dimensional cadence, robot duty ratios, species-specific C-start kinematics, exact vortex phases, world coordinates, and task-specific routes
policy_translation: preserve lateral-target sign, non-inverting differential curvature, anterior-displacement half-cycle steering, common-envelope redistribution, posterior lag, and final acceleration projection; replace yaw-rate response in the release gate with normalized signed bearing-window response
falsification: reject if capture or either coherent wake row is lost, the below-target near-miss/left-exit topology recurs, target-relative gating worsens arrival or mean distance beyond established repeat spread without a robustness benefit, or actuator contact or planar loads materially increase

## Exactly one candidate hypothesis

The candidate tests one state-feedback mechanism: target-relative response
release. The existing gate interprets body yaw opposite the route-request sign
as successful correction, even though sway and forward translation can make
the target bearing grow at the same time. The candidate instead releases the
same bounded fraction only when the signed target bearing decreases over the
episode-provided observation window. Target geometry still owns route sign,
and the release remains one-sided, so the new signal cannot reverse curvature.

Everything else remains the sampled redistribution carrier: target-signed
mean curvature, anterior-displacement half-cycle steering, common-envelope
redistribution, posterior lag, and exact final acceleration projection. This
is an observation-semantic architecture test, not scalar-only gain tuning. It
adds no velocity/flow/force residual, terminal or recovery branch, explicit
time, step, world coordinate, mutable state, or memorized phase. Formal CFD
runs only after handoff, so no outcome is claimed for this unevaluated
candidate.
