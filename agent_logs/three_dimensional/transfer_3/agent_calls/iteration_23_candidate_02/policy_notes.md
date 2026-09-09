# Moment-anticipated beat-response candidate

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  dynamics, and capture. Their top-down rows show body-led self-propulsion and
  coherent alternating posterior vortex streets from release through capture;
  the oblique rows independently show compact paired three-dimensional
  Lambda2 structures following the swimmer. No sample shows passive advection,
  wake collapse, collision, a loop, boundary exit, or instability. Because the
  four sparse sheets are visually almost identical, route timing, action, load,
  and response histories decide among them.
- The actuator-consistent phase policy is the strongest sampled controller. It
  captures at `18.67250T`, scores `-0.13362`, and has mean distance `2.02129L`.
  Its anterior/posterior acceleration-limit occupancy is `42.68%/76.41%`,
  force/moment RMS is `0.01350/0.00703`, and local-flow RMS is only `0.01809U`.
  The assigned prefill's complementary amplitude-to-phase handoff reduces
  posterior occupancy to `74.48%` and loads to `0.01336/0.00696`, but delays
  capture to `18.74950T` and scores `-0.14192`; wholesale authority handoff is
  therefore an efficiency trade, not a route improvement.
- The inherited hydrodynamic-opposition selector is a new concrete negative
  control. Releasing phase recruitment whenever normalized yaw moment already
  helps still preserves the coherent wake and capture, and lowers occupancy to
  `40.95%/74.41%` and force/moment RMS to `0.01306/0.00679`. It nevertheless
  arrives at `18.78799T` and scores `-0.13976`, `0.11550T` later than the
  actuator-consistent parent. A memoryless helping-moment gate discards useful
  route authority even though it modestly relieves load.
- Moment itself is not an uninformative signal. Across all four sampled traces,
  the previous normalized hydrodynamic yaw moment predicts next-sample yaw
  acceleration with positive slope `2336.7--2341.7` and correlation `0.972`;
  one-step yaw-rate-change RMS is `0.0900--0.0930 rad/T`. Thus the failed
  selector used a strongly predictive physical response in the wrong role: as
  an authority switch rather than as bounded response anticipation.

## Policy hypothesis recorded before editing

Start from the fastest actuator-consistent policy. Preserve its normalized
body-frame bearing and LOS-rate request, recoil-conditioned yaw response,
continuous distributed C-bend, coherent traveling-wave carrier, persistent
same-side actuator gate, coefficient-norm-preserving posterior phase rotation,
and componentwise feasibility projection.

Add a bounded physical-response forecast only to the fast beat-side path. Map
normalized yaw moment to a signed prospective yaw-rate increment capped near
the observed one-step response scale, then subtract that increment from the
existing yaw-rate error before choosing response-reversing half-cycle and
posterior phase direction. A helping moment therefore starts braking before
measured yaw rate overshoots, while an opposing moment strengthens the existing
correction; neither case removes phase authority. The slow mean-curvature and
LOS route loops remain unchanged. Moment and yaw error both reverse under
reflection, so the forecasted error and the two-joint command remain odd.

Support requires capture with the alternating wake intact and either arrival
earlier than `18.67250T` or arrival no later than the assigned prefill's
`18.74950T` with load/occupancy below the actuator-consistent parent's
`76.41%` and `0.01350/0.00703`. Falsify the mechanism if capture is lost,
arrival is later than `18.78799T`, posterior occupancy or load exceeds the
parent, or the trajectory merely reproduces the slower moment-release branch.
The evidence is limited to self-generated wakes and about `0.018U` local-flow
RMS, so no external-wake robustness is claimed.

bookshelf_consulted: true
source_domain: wake-interaction control and sensor-modulated robotic-fish CPG steering
source_mechanism: preserve the propulsive carrier and slow route request while using measured fast fluid response as a bounded residual instead of cancelling all lateral motion or switching steering off
transferable_invariant: a signed hydrodynamic response can anticipate near-future yaw and adjust only the fast beat-side correction while continuous target geometry retains route ownership
nontransferable_details: published gains, robot or species kinematics, cylinder-wake phase, dimensional frequency, exact vortex timing, and task-specific routes
policy_translation: retain normalized LOS and two-joint feedback, convert normalized body yaw moment into a bounded prospective yaw-rate increment, and use the anticipated yaw error for half-cycle and posterior phase direction without changing the actuator-consistency gate
falsification: reject if capture or wake coherence is lost, arrival exceeds 18.78799T, load exceeds 0.01350/0.00703, or the path reproduces the slower helping-moment authority-release result

The current candidate's CFD outcome is not claimed here; it becomes evidence
only after this worker exits.
