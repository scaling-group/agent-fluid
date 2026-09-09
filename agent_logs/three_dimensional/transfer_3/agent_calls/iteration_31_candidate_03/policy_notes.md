# Helpful-only carrier-demodulated phase-relief candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled solver evaluations satisfy the frozen contract: direct
  `uniform_direct` initialization with `U_infinity=(0,0,0)`, no prewarm or
  cylinders, finite dynamics, and capture at `18.6560--18.7440T`. There is no
  sampled termination failure, so the informative weak controls are the
  slower response allocators in the assigned parent's inherited logs rather
  than a nonexistent failure sheet.
- I inspected the combined sheets for best-score `solver_0288c0d51d57`, the
  bidirectional carrier-demodulated `solver_e85ca9b86253`, the stress-gated
  `solver_bdf6dd947707`, and the assigned parent's demodulated-amplitude
  control from release through capture. In every top-down row the body advances
  toward the target while shedding a coherent alternating red/blue caudal
  street. Every oblique row independently shows compact three-dimensional
  Lambda2 structures following the moving body. None shows passive advection,
  wake collapse, boundary approach, collision, or instability. Local-flow RMS
  is only `0.01801--0.01840U`, consistent with body-led propulsion. The weak
  controls retain wake survival but show longer, more oscillatory routes, so
  allocation quality rather than propulsion failure separates them.
- The strongest sampled route controls are close. Raw helpful-moment amplitude
  relief captures at `18.6560T`, score `-0.13321`, mean distance `2.02115L`,
  with force/moment RMS `0.013277/0.006912` and anterior/posterior acceleration-
  limit occupancy `40.74%/75.74%`. Actuator-consistent phase alone captures at
  `18.6725T`, score `-0.13362`, mean distance `2.02129L`, with
  `0.013499/0.007028` loads and `42.15%/76.11%` occupancy. Inherited same-hash
  repeats arrive near `18.99T`, so the raw sample lead is not a robust response
  benefit.
- Bidirectional carrier-demodulated phase allocation preserves capture at
  `18.7165T` in the sampled solver and `18.8650T` in an inherited repeat. It
  consistently lowers posterior acceleration occupancy to `74.14--74.64%`
  and force/moment RMS to `0.013093--0.013252/0.006816--0.006894`, while both
  wake views remain coherent. This is evidence for load allocation, not faster
  routing.
- The parent's two identical opposition-only replications capture later at
  `18.8045T` and `18.8980T`. Their effort benefit does not replicate:
  force/moment RMS spans `0.013066--0.013519/0.006804--0.007041`, and posterior
  acceleration occupancy spans `74.19--75.93%`. Carrier-demodulated helpful
  residual applied to amplitude rather than phase is worse still: it captures
  at `19.1510T`, lengthens the center path to `12.5915L`, and scores
  `-0.16481` despite low `74.07%` posterior occupancy and
  `0.013060/0.006819` loads. Opposing-only recruitment and helpful-amplitude
  relief therefore should not be tuned further.

## Policy hypothesis recorded before editing

Preserve the normalized body-frame bearing/LOS-rate route, recoil-conditioned
yaw error, continuous distributed C-bend, state-feedback traveling carrier,
response-reversing half-cycle steering, persistent same-side stress gate,
coefficient-norm-preserving posterior phase rotation, sampled carrier-moment
estimate, and componentwise acceleration projection.

Change one allocator semantic to isolate the missing half of the successful
bidirectional response path. Subtract the joint-phase carrier estimate from
normalized yaw moment. When that residual helps the requested yaw response,
smoothly reduce only the *incremental posterior phase recruitment*. When it
opposes the response, retain the established actuator-consistent phase path
without adding authority. The signed residual and requested response both
reverse under reflection, so their helpful alignment is invariant. The gate
is bounded, has no clock, world coordinate, target identity, range stage, or
mutable state, and does not alter carrier or half-cycle amplitude.

Support requires capture with coherent top-down and oblique wakes, arrival no
later than the inherited actuator-consistent `18.9970T` repeat, posterior
acceleration occupancy below `76.11%`, and force/moment RMS no greater than
`0.01350/0.00703`. A useful result would approach the bidirectional residual's
`74.14--74.64%` posterior occupancy and load band without the one-sided
opposition or helpful-amplitude route delay. Falsify the mechanism if capture
is lost, arrival exceeds `19.1510T`, the route exceeds `12.5915L`, either wake
view weakens, or loads exceed the actuator-consistent bounds. If falsified,
later workers should preserve the replicated bidirectional demodulated
allocator and stop using instantaneous moment for further authority splits;
the next genuinely different test needs a longer response history exposed by
the observation contract.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-feedback modulation of rhythmic robotic-fish CPG control
source_mechanism: preserve useful fluid-induced motion while a bounded residual channel removes only redundant rhythmic steering authority
transferable_invariant: retain the productive traveling wave and slow route loop, subtract self-generated carrier response from the physical cue, and avoid cancelling fluid response already aligned with the requested route correction
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, exact vortex phases, organized-wake synchronization, recurrent-network state, and source-task routes
policy_translation: use normalized body-frame LOS and observed two-joint phase as the primary route and carrier; use only positive alignment of carrier-demodulated yaw moment with requested yaw response to reduce incremental posterior phase recruitment, while opposing residual leaves the established actuator path unchanged
falsification: reject if capture is lost, arrival exceeds 19.1510T, path length exceeds 12.5915L, wake coherence degrades, posterior acceleration occupancy exceeds 76.11%, or force/moment RMS exceeds 0.01350/0.00703

The current candidate's CFD outcome is not claimed here; it becomes evidence
only after this worker exits.
