# One-sided carrier-demodulated response candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled solver evaluations satisfy the frozen contract: direct
  `uniform_direct` initialization with `U_infinity=(0,0,0)`, no prewarm or
  cylinders, finite dynamics, and capture at `18.6560--18.7440T`. There is no
  termination failure in this cohort, so the informative relative failure is
  the lowest-score carrier-demodulated sample against the best finite helpful-
  moment sample, supplemented by completed inherited allocator controls.
- I inspected the combined keyframe sheets for best-score
  `solver_0288c0d51d57` and prefilled `solver_e85ca9b86253` from release to
  capture. In both top-down rows the body translates toward the target while a
  coherent alternating red/blue caudal street grows behind it. Both oblique
  rows independently show compact three-dimensional Lambda2 structures shed
  behind the moving body. Neither sheet shows passive advection, growing
  wasteful sway, wake collapse, collision, domain approach, or instability;
  both fish bend continuously toward the capture arc. Monotone distance
  progress and local-flow RMS near `0.018U` agree with this visual diagnosis,
  so the sparse visual difference is not used to rank these close allocators.
- The best sampled helpful raw-moment amplitude relief captures at `18.6560T`,
  score `-0.13321`, mean distance `2.02115L`, with posterior acceleration-limit
  occupancy `75.74%` and force/moment RMS `0.01328/0.00691`. Its `0.0165T`
  timing lead over the faster actuator-consistent repeat is smaller than the
  `0.0660T` current same-hash spread, so it does not establish a robust raw-
  moment benefit.
- The prefilled carrier-demodulated residual captures at `18.7165T`, score
  `-0.13525`, and its inherited same-hash replication captures at `18.7605T`.
  They repeat lower posterior acceleration-limit occupancy
  (`74.17--74.44%`) and force/moment RMS
  (`0.013093--0.013105/0.006816--0.006822`) while remaining within the
  inherited successful route band. This is a replicated effort benefit, not
  an arrival benefit; posterior velocity-limit occupancy remains
  `7.73--7.83%`.
- Two completed inherited controls sharpen the negative boundary. Gating raw
  helpful-moment amplitude relief by stress and yaw closure captures later at
  `18.7825T` with higher `0.01332/0.00694` loads than the demodulated parent.
  Withdrawing the demodulated phase increment when posterior velocity is near
  its limit captures at `18.8100T`; despite lowering acceleration-limit
  occupancy to `73.83%`, it raises velocity-limit occupancy to `8.10%` and
  loads slightly to `0.01312/0.00683`. Instantaneous phase withdrawal therefore
  does not create measured velocity headroom and should not be scalar-tuned.

## Policy hypothesis recorded before editing

Preserve the evaluated normalized body-frame bearing/LOS-rate route,
recoil-conditioned yaw error, continuous distributed C-bend, state-feedback
traveling carrier, response-reversing half-cycle steering, persistent same-
side stress gate, coefficient-norm-preserving phase rotation, carrier moment
estimate, and componentwise acceleration projection.

Change one allocator semantic. The carrier-demodulated fluid residual may
increase posterior phase recruitment only when it opposes the requested yaw
response. When the residual helps, retain the established actuator-consistent
phase path instead of withdrawing phase authority. This separates disturbance
rejection from effort relief: it preserves useful physical response without
making a fast moment cue responsible for reducing the slow LOS route command.
The residual and yaw-response directions are both reflection odd, so their
opposition product is invariant; clipping it to the opposing half is bounded
and introduces no clock, range stage, world coordinate, or mutable state.

Support requires capture with both wake views coherent, arrival inside the
replicated `18.6725--19.0080T` successful band, posterior acceleration-limit
occupancy no greater than the actuator-consistent `76.11%` bound, and
force/moment RMS no greater than `0.01350/0.00703`. A useful result would retain
some demodulated load relief while improving route timing beyond same-hash
spread. Falsify the mechanism if capture is lost, arrival leaves the band,
the wake weakens, loads exceed those bounds, or one-sided recruitment is
indistinguishable from the parent; later workers should then preserve the
replicated bidirectional demodulated allocator and test genuine beat-history
rather than another instantaneous release gate.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-feedback modulation of rhythmic robotic-fish CPG control
source_mechanism: preserve useful fluid-induced motion while a bounded residual channel rejects only response that opposes route correction
transferable_invariant: retain the productive traveling wave and slow route loop, subtract the self-generated carrier from a physical-response cue, and recruit only the smallest residual authority needed against opposing response
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, exact vortex phases, organized-wake synchronization, and source-task routes
policy_translation: use normalized body-frame LOS and observed two-joint phase to preserve the route and carrier; clip the reflection-even carrier-demodulated residual/request alignment so only opposing residual recruits extra posterior phase and helping residual never withdraws the established phase path
falsification: reject if capture leaves 18.6725--19.0080T, wake coherence degrades, posterior acceleration occupancy exceeds 76.11%, force/moment RMS exceeds 0.01350/0.00703, or the allocator has no measurable effect relative to the bidirectional parent

The current candidate's CFD outcome is not claimed here; it becomes evidence
only after this worker exits.
