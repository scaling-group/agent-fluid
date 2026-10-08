# Evidence-selected posterior coast-rate candidate

## Visual diagnosis before the policy edit

- The four assigned solver examples satisfy the frozen rollout contract: direct
  uniform still-water initialization with `U_infinity=[0,0,0]`, no cylinders,
  no prewarm, and inertial moving-window transport. Three are byte-identical
  v27 course-preview replications that capture at `24.5795T`, minimum/final
  distance `0.746968L`, mean distance `2.36044L`, and score `-0.460673`.
  The fourth is the v34 posterior coast-rate guard; it captures at `25.0635T`,
  minimum/final distance `0.749973L`, mean distance `2.35222L`, and the best
  sampled score, `-0.452083`.
- Both visual rows were inspected for the v34 capture, an assigned v27
  replication, the assigned-parent v32 braking-reserve capture, and the
  inherited v33 dual-joint rate-barrier failure. The successful top-down
  sheets start wake-free, show self-propelled diagonal translation with a
  coherent alternating mid-plane street, and retain a target-directed terminal
  redirect. Their oblique sheets show compact three-dimensional Lambda2
  structures persisting through capture. The v33 failure remains
  self-propelled and wake-coherent, but diverges during the long approach,
  passes outside the capture circle, curls upward, and exits the domain. It is
  a controller/route failure rather than passive advection, wake breakup, or
  numerical instability.
- The assigned parent's completed v32 replication is the relevant control. It
  captures at `24.6290T` and `0.748702L`, has mean distance `2.36161L`, zero
  sampled posterior hard-stop occupancy, and peak absolute planar body-frame
  force/yaw-moment coefficients `0.0241/0.0303/0.0149`. The v34 posterior-only
  coast guard preserves capture and zero hard-stop occupancy while reducing
  posterior rate-limit occupancy from `5.806%` to `4.586%` and any-joint
  occupancy from `15.163%` to `13.869%`. Its force/moment peaks remain in the
  inherited low class (`0.0244/0.0337/0.0162`). Raw acceleration-envelope
  exposure rises slightly (`73.046%` to `73.930%`), so the mechanism is not a
  general saturation cure.
- The contrast with the inherited v33 result is causal enough to select a
  narrow mechanism. Applying active braking across both joints drove exact
  rate-limit occupancy to zero but lost capture at `0.848L` and exited; merely
  coasting velocity-increasing commands on the posterior follower retains the
  anterior phase anchor and improves both rate occupancy and integrated route
  performance. The separately completed terminal collision-cone residual also
  retains capture (`0.747850L`, score `-0.461276`) but does not beat v34 and
  does not change the v32 rate-occupancy class, so combining it here would
  confound the stronger completed result.

## Policy hypothesis

Materialize the completed v34 posterior coast-rate controller as the single
downstream candidate. Preserve the course-preview steering, steering-priority
allocation, predictive posterior stroke gate, braking reserve, anterior
state-feedback oscillator, and posterior phase-lagged traveling-wave target.
Only when measured posterior rate enters the owned `250--260 deg/T` boundary
band and the final posterior command would increase that rate, taper its
permitted velocity-increasing component to zero. Never turn the rate guard
into an inward brake, never modify an already speed-reducing command, and never
touch the anterior command.

The expected result is replication of the completed v34 semantic improvement:
capture with the same coherent three-dimensional wake and route class, zero
posterior hard-stop occupancy, posterior/total exact-rate occupancy near
`4.586/13.869%`, and planar loads remaining below roughly `0.035`. Falsify the
selection if capture is lost, the far trajectory or wake changes materially,
posterior hard-stop contact returns, exact-rate occupancy fails to improve on
v32, or the narrow `0.000027L` terminal crossing margin proves nonrepeatable.
The new CFD outcome is not claimed here; EvE evaluates this candidate only
after the worker exits.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive swimming and sensor-modulated robotic-fish CPG control
source_mechanism: an anterior phase anchor sustains and steers a traveling bend while a phase-lagged posterior follower supplies reactive thrust under bounded proprioceptive modulation
transferable_invariant: preserve the anterior oscillator and cycle-scale traveling-wave impulse while suppressing only redundant posterior actuation that would increase an already boundary-limited rate
nontransferable_details: published gains, dimensional cadence, species-specific envelopes and kinematics, full-body waveforms, exact vortex phases, Strouhal targets, and task-specific routes
policy_translation: use normalized observed posterior joint rate and the owned rate/acceleration envelope to taper only velocity-increasing posterior commands to coast, leaving anterior and already-braking commands unchanged
falsification: reject if capture or coherent wake is lost, the far route changes, posterior hard-stop protection or the low-load class regresses, or posterior rate-limit occupancy does not remain below the v32 control

## Pre-evaluation validation

- The candidate is byte-identical to the completed v34 posterior coast-rate
  artifact associated with the sampled `-0.452083` capture. This is selection
  of prior CFD evidence, not a claim about the new evaluation that will run
  after this worker exits.
- The prescribed public-contract state returns exactly two finite joint
  accelerations. All `84` direct `params.FIELD` references resolve among the
  `86` fields returned by `target_policy_params()`.
- The reusable-guidance semantic check and solver editable-boundary audit pass.
  The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account; its three declared no-CFD commands were run
  directly and separately and passed. No formal CFD was run.
