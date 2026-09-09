# Replicated phase-route rollback candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no prewarm or cylinders,
  finite dynamics, and capture at `18.6560--18.7440T`. The two exact
  actuator-consistent samples both capture at `18.6725T`, with scores
  `-0.13219` and `-0.13362`; their small score and load differences establish
  a same-policy variation band rather than an allocator effect.
- I inspected all four combined keyframe sheets from release to capture. The
  best-score actuator-consistent sheet and the slower stress-gated-moment
  sheet are the informative sampled contrast because there is no termination
  failure in the current batch. In both top-down rows the translating body
  builds a coherent alternating posterior vorticity street, and in both
  oblique rows compact three-dimensional Lambda2 structures are shed behind
  the fish through target closure. Neither shows passive advection, growing
  wasteful sway, collision, boundary approach, wake breakup, or instability.
  Direct-zero initialization and local-flow RMS `0.01807--0.01816U` confirm
  self-propulsion; the nearly indistinguishable wakes do not support the extra
  instantaneous-moment allocator.
- The sampled stress-gated moment residual, which prefilled this workspace,
  captures at `18.7440T`, score `-0.13364`, versus `18.6725T` and
  `-0.13219` for the best exact actuator-consistent sample. Its posterior
  acceleration-limit occupancy (`75.44%`) and force/moment RMS
  (`0.01343/0.00699`) remain inside the exact baseline spread
  (`75.46--76.11%`, `0.01331--0.01350/0.00693--0.00703`). The added
  response channel therefore has no resolved route or effort advantage.
- The assigned parent's completed joint-quadrature observer is the most
  informative inherited failure even though it still captures. Relative to
  the best exact baseline, it delays arrival from `18.6725T` to `22.3025T`,
  worsens score from `-0.13219` to `-0.44947`, raises trajectory-mean distance
  from `7.5648L` to `7.8997L`, and raises maximum absolute heading error from
  `0.661` to `0.968 rad`. Its lower posterior occupancy (`57.19%`) and lower
  force/moment RMS (`0.01118/0.00582`) accompany body-speed RMS falling from
  `0.706U` to `0.613U`; they are route/propulsion loss, not improved authority.
  Its top-down row shows a wider curved approach while its oblique row still
  shows a coherent body-led wake, so the failure is closed-loop response
  semantics rather than wake collapse or instability. A low offline
  beat-average residual was not sufficient evidence for a causal yaw observer.
- The inherited exact actuator-consistent recovery at `18.7275T` and score
  `-0.13717` supplies a third successful sample of the same policy. Together
  with failed instantaneous moment, flow, LOS, and joint-quadrature additions,
  it favors removing unsupported response channels rather than another scalar
  gain or proxy-observer tune.

## Policy hypothesis recorded before the policy edit

Replace the prefilled stress-gated-moment residual with exactly the replicated
`dogfish3d_actuator_consistent_tail_phase_v1` controller. Preserve normalized
body-frame bearing and line-of-sight-rate guidance, the distributed C-bend,
state-feedback traveling carrier, recoil-conditioned yaw response,
response-reversing half-cycle steering, persistent same-side previous-action
gate, bounded coefficient-norm-preserving posterior phase rotation, and
componentwise feasibility projection. Remove the instantaneous yaw-moment
residual rather than retuning it, and do not adopt the falsified joint-position
quadrature observer.

Support requires capture within the completed exact-policy arrival envelope
`18.6725--18.7275T`, a coherent body-led wake in both views, score near the
completed `-0.13219-- -0.13717` band, posterior acceleration-limit occupancy
no greater than `76.2%`, and force/moment RMS no greater than
`0.01350/0.00703`. Falsify this rollback if it loses capture, leaves that
timing band, weakens either wake, or exceeds those effort bounds. A later
architecture should require a genuinely causal beat-scale observation with a
closed-loop mechanism test; it should not refit instantaneous joint
quadratures or add another moment/flow gate.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and tail-beat-averaged turning models
source_mechanism: preserve a productive traveling rhythm while slow route feedback remains separate from carrier-phase response
transferable_invariant: normalized body-frame geometry owns the slow route, the posterior-lagged bend remains the primary propulsor, and a fast response channel is retained only when its causal effect separates from carrier recoil in completed closed-loop evidence
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, full-body waveforms, exact tail or vortex phases, averaging-window implementations, and task-specific routes
policy_translation: retain the replicated bearing-plus-LOS C-bend and joint-state phase path; remove instantaneous moment relief and reject the offline-fitted joint-quadrature observer because neither improves the completed closed-loop route
falsification: reject if capture leaves 18.6725--18.7275T, either wake loses coherence, score falls outside the exact-policy band, posterior occupancy exceeds 76.2%, or force/moment RMS exceeds 0.01350/0.00703

The current candidate's CFD result is produced only after this worker exits
and is not claimed as evidence here.
