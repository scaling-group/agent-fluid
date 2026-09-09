# Replicated actuator-consistent route candidate

## Evidence diagnosis recorded before candidate selection

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no prewarm or cylinders,
  finite dynamics, and capture at `18.6560--18.6890T`. The assigned-parent
  evidence is also a capture. The informative failure is therefore lack of a
  replicated route/load advantage for an added allocator, not a termination
  failure among the current samples.
- I compared the best-score actuator-consistent combined sheet with the
  slower one-sided demodulated-residual sheet from release through capture.
  Both top-down rows show body-led translation from wake-free release and a
  coherent alternating caudal vorticity street by `4T`; both oblique rows show
  compact three-dimensional Lambda2 structures shed behind the moving body
  through target closure. Neither shows passive advection, growing wasteful
  sway, collision, boundary approach, wake breakup, or numerical instability.
  Local-flow RMS is tightly grouped at `0.01808--0.01816U`, agreeing with the
  visual diagnosis that route/allocation semantics, not wake survival, own
  the small differences.
- The exact actuator-consistent policy is represented twice in the current
  sample. Both instances capture at `18.6725T`; their scores
  (`-0.13362` and `-0.13219`), acceleration-limit occupancy
  (`42.2%/76.1%` and `40.7%/75.5%`), and force/moment RMS
  (`0.01350/0.00703` and `0.01331/0.00693`) quantify rollout variation while
  preserving the semantic result. This strengthens capture replication but
  also shows that small one-run effort differences overlap background spread.
- Helpful-moment amplitude relief is again the fastest current sample at
  `18.6560T`, score `-0.13321`, with `40.7%/75.7%` acceleration occupancy and
  `0.01328/0.00691` force/moment RMS. However, the assigned-parent exact repeat
  took about `18.9915T` and scored `-0.15772`; its apparent `0.0165T` current
  edge therefore remains unreplicated and does not justify another moment
  gate or gain.
- One-sided carrier-demodulated moment-residual recruitment captures later at
  `18.6890T`, has the worst current mean-distance cost (`2.02295L`) and score
  (`-0.13525`), and its `40.5%/75.3%` occupancy plus
  `0.01329/0.00692` load does not separate from the exact baseline's sampled
  spread. This is a concrete negative result for further instantaneous
  residual allocation in direct-uniform still water.
- The available `turn_rate_recent` and bearing-window observations span only
  seven integration intervals, about `0.0385T` versus the `0.55T` carrier.
  They cannot honestly implement the genuinely beat-scale response requested
  by inherited guidance. Joint phase and previous feasible action remain the
  only evaluated bounded persistence proxy in the present contract.

## Candidate hypothesis recorded before policy selection

Select the prefilled `dogfish3d_actuator_consistent_tail_phase_v1` policy
unchanged as exactly one controlled-replication candidate. It retains the
normalized body-frame bearing-plus-LOS-rate route, distributed C-bend,
state-feedback traveling carrier, response-reversing half-cycle steering,
persistent same-side feasible-action gate, bounded coefficient-norm-preserving
posterior phase rotation, and componentwise feasibility projection. It adds
no instantaneous moment, force, flow, or sub-beat-rate allocator. This is an
evidence-led exploitation candidate, not a same-worker claim of improvement.

Support requires capture within the established `18.6725--19.0520T` band,
coherent wakes in both views, posterior acceleration-limit occupancy no higher
than `76.2%`, and force/moment RMS no higher than `0.01350/0.00703`. Falsify
the recovery if it loses capture, leaves that timing band, weakens either wake,
or exceeds those effort bounds. A later architecture should wait for a true
beat-scale response observable or a disturbance regime that separates fast
fluid response from the carrier; it should not scalar-tune the current
instantaneous negative controls.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and wake-adaptive swimming
source_mechanism: preserve a productive rhythmic carrier while separating slow route demand from bounded fast hydrodynamic response
transferable_invariant: normalized body-frame target geometry owns the slow route, the posterior-lagged traveling bend remains primary, and an extra response channel is recruited only when its disturbance signature is observably distinct from carrier recoil
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, full-body waveforms, exact vortex phases, cylinder geometry, and task-specific routes
policy_translation: retain body-frame bearing and LOS-rate C-bend guidance plus joint-state phase and previous feasible action; do not substitute the available sub-beat window or instantaneous moment for an unobserved beat-scale disturbance state
falsification: reject if replication loses capture, leaves 18.6725--19.0520T, weakens either wake, exceeds 76.2% posterior acceleration occupancy or 0.01350/0.00703 force/moment RMS, or if a future true beat-scale observable replicably separates route and load without those costs

The current candidate's CFD result is produced only after this worker exits
and is not used as evidence here.
