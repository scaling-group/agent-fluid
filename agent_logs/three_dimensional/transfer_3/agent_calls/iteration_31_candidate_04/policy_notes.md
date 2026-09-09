# Stress-arbitrated posterior phase candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled solver rollouts satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  dynamics, and capture at `18.6560--18.7440T`. There is no sampled
  non-capture, so the informative relative failures are completed allocators
  that preserve capture and wake coherence but worsen route cost.
- I inspected both rows of every sampled combined keyframe sheet and compared
  the best-score helpful-moment rollout with the assigned parent's latest
  no-moment replication and its preceding anterior-release result. Every
  top-down row shows body-led translation with a coherent alternating caudal
  vorticity street, and every oblique row shows compact paired three-dimensional
  Lambda2 structures shed behind the fish through target closure. None shows
  passive advection, wake collapse, growing wasteful sway, collision, boundary
  approach, or instability. Direct-zero initialization and local-flow RMS
  `0.01800--0.01838U` confirm self-propulsion; the useful distinction is route
  and actuator allocation rather than wake survival.
- The sampled actuator-consistent no-moment policy captures at `18.6725T`,
  score `-0.13362`, mean distance `2.02129L`, posterior acceleration-limit
  occupancy `76.11%`, action RMS `24.95/28.85 rad/T^2`, and force/moment RMS
  `0.01350/0.00703`. Its exact-hash assigned-parent replication captures at
  `18.9970T`, mean distance `2.04736L`, and `75.01%` posterior occupancy, so
  small timing or score differences are not robust mechanism evidence.
- The sampled carrier-demodulated phase allocator lowers posterior occupancy
  to `74.14%`, action RMS to `24.46/28.56 rad/T^2`, and force/moment RMS to
  `0.01309/0.00682`, but its exact-hash assigned-parent repeat returns only
  `74.64%` and `0.01325/0.00689` while slowing to `18.8650T` and mean distance
  `2.03488L`. Completed one-sided and amplitude moment allocations likewise
  fail to replicate a route/load separation. Instantaneous moment therefore
  does not merit another allocation role in this low-flow lane.
- Instantaneous LOS-counter-response release lowers joint effort and loads but
  slows capture to `18.9310T` and raises mean distance to `2.04457L`; the
  sampled demodulated-amplitude variants are slower still at
  `18.9750--19.1070T`. These are concrete evidence that withdrawing anterior
  route curvature or modulating posterior amplitude from a fast physical cue
  removes route-useful authority. The remaining supported direction is the
  guidance bank's bounded phase recruitment, but without stacking full
  half-cycle amplitude asymmetry on top of it as saturation approaches.

## Policy hypothesis recorded before editing

Recover the evaluated no-moment controller: normalized body-frame bearing plus
LOS-rate guidance, recoil-conditioned yaw response, continuous two-joint
C-bend, state-feedback traveling carrier, response-reversing half-cycle
steering, persistent same-side stress detection, posterior phase rotation, and
componentwise feasibility projection. Remove the prefilled instantaneous
hydrodynamic-moment residual.

Test one new actuator-arbitration mechanism. Below the stress gate, retain the
replicated half-cycle amplitude path exactly. As persistent same-side posterior
stress recruits the coefficient-norm-preserving phase rotation, continuously
transfer the same fraction of steering ownership away from half-cycle amplitude
asymmetry. At full recruitment the posterior carrier is phase-steered without
an additional amplitude multiplier; at zero recruitment the sampled baseline
is unchanged. The gate and beat phase come only from observed joint state,
previous action, and bounded yaw response, so the mechanism is normalized,
reflection-equivariant, and contains no clock, route memory, or scalar gain
increase.

Support requires capture within the observed successful band ending near
`19.008T`, coherent top-down and oblique wakes, posterior acceleration-limit
occupancy below the sampled no-moment `76.11%`, and no worse than the baseline
`0.01350/0.00703` force/moment RMS. A useful separation should approach the
sampled phase allocator's roughly `74.3%` posterior occupancy without the
failed moment repeat's route penalty. Falsify the arbitration if it loses
capture, leaves the timing band, weakens either wake, raises loads, or merely
slows the route while occupancy remains in the `75--76%` baseline band; later
workers should then keep the plain no-moment policy until a genuinely
beat-scale response observation is available.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and phase-lag steering of a propulsive traveling wave
source_mechanism: preserve the primary rhythmic carrier while bounded observed-state phase modulation replaces a saturating amplitude steering path
transferable_invariant: slow body-frame target geometry must retain route ownership, the productive traveling rhythm must remain intact, and alternative rhythmic steering actuators should be blended rather than stacked when observed stress shows that amplitude authority is exhausted
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, full-body waveforms, exact vortex phases, world-frame routes, and source-task timing
policy_translation: keep normalized bearing and LOS-rate C-bend guidance; use joint state and previous action to recruit coefficient-norm-preserving posterior phase rotation and withdraw the same bounded fraction of response-reversing half-cycle amplitude asymmetry
falsification: reject if capture exceeds 19.008T, either wake loses coherence, posterior acceleration occupancy is not below 76.11%, force/moment RMS exceeds 0.01350/0.00703, or lower effort is purchased only by a slower route

## Post-edit signal audit (not CFD evidence)

Replaying the stress and arbitration expressions on all four sampled state
histories recruits phase with mean activation `0.752--0.770`; activation
exceeds `0.5` on `75.46--77.44%` of rows. The arbitration is therefore not a
no-op. On those fixed histories it changes the feasible posterior command by
only `0.110--0.125 rad/T^2` on average while reducing replayed posterior
saturation by `0.79--0.94` percentage points. This establishes that the edit
is bounded and specifically targets stacked authority near the envelope; the
open-loop replay cannot predict the new closed-loop route, loads, wake, or CFD
outcome.

The current candidate's CFD outcome is not claimed here; it becomes evidence
only after this worker exits.
