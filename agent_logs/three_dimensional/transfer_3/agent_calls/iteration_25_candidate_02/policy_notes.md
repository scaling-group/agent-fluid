# Helpful-moment amplitude-relief replication

## Evidence diagnosis recorded before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, finite
  dynamics, and capture. Their top-down sheets show body-led progress with a
  coherent alternating posterior vortex street from release through capture;
  their oblique sheets independently show compact paired three-dimensional
  Lambda2 structures following the swimmer. None shows passive advection,
  wake collapse, collision, looping, boundary exit, or instability. Trace
  local-flow RMS is only `0.01806--0.01816U`, consistent with a self-generated
  carrier rather than ambient transport.
- Helpful hydrodynamic moment used to relieve only satisfied half-cycle
  amplitude authority is the strongest current sample. It captures at
  `18.65600T`, scores `-0.133208`, and has mean scored distance `2.02115L`.
  Its anterior/posterior action RMS is `24.710/28.766 rad/T^2`, 99%-limit
  occupancy is `41.19%/75.97%`, and force/moment RMS is
  `0.013277/0.006912`.
- The actuator-consistent phase baseline has two current identical-hash
  captures at `18.67250T` and `18.73849T`. The faster realization uses
  `42.68%/76.41%` limit occupancy and `0.013499/0.007028` force/moment RMS;
  the repeat uses `40.97%/75.81%` and `0.013270/0.006908`. Thus the amplitude-
  relief sample preserves the route and occupies the lower load band, but its
  `0.01650T` lead over the fast baseline is smaller than the baseline's
  `0.06600T` same-policy timing spread and is not a resolved improvement.
- Moving the same helpful-moment release upstream to the posterior phase
  actuator is a concrete negative control. Error-conditioned phase release
  remains a coherent capture but arrives at `18.77150T`, scores `-0.137127`,
  and offers no load separation from the low-load baseline repeat. Together
  with inherited sign-only and moment-forecast results, this supports keeping
  normalized LOS phase recruitment in charge of route closure while treating
  hydrodynamic moment only as a residual allocation cue.

## Policy hypothesis recorded before editing

Replace the prefilled actuator-consistent controller with the exact sampled
helpful-moment amplitude-relief policy. Preserve normalized body-frame bearing
and LOS-rate guidance, recoil-conditioned yaw response, the continuous
distributed C-bend, response-reversing half-cycle steering, persistent
same-side posterior phase recruitment, the traveling-wave carrier, and
componentwise feasibility projection. When measured yaw moment helps and the
recoil-conditioned yaw error is already near closure, reduce only half-cycle
amplitude asymmetry; do not suppress the carrier, mean curvature, or posterior
phase actuator. This is a deliberate replication rather than a new gain or a
claim based on a one-run scalar lead.

Support requires capture with coherent top-down and oblique wakes, arrival no
later than the current baseline repeat at `18.73849T`, posterior 99%-limit
occupancy no greater than `76.41%`, and force/moment RMS no greater than
`0.01350/0.00703`. A second amplitude-relief result at or below `18.67250T`
with loads in its current band would distinguish the allocation from the slow
phase-release control. Falsify it if capture is lost, arrival exceeds the
replicated half-cycle bound near `19.052T`, wake coherence degrades, or loads
exceed the inherited failed-route bounds `0.01574/0.00810`. The evidence is
limited to quiescent local flow near `0.018U`; no external-wake rejection claim
is made.

bookshelf_consulted: true
source_domain: wake-interaction studies and sensor-modulated robotic-fish CPG control
source_mechanism: preserve useful fluid-induced response while modulating only a residual rhythmic steering channel
transferable_invariant: keep slow normalized target geometry in charge of route closure and relieve the smallest fast steering contribution only after measured body response already helps satisfy the request
nontransferable_details: organized-wake phase, published gains, species and robot kinematics, dimensional frequency, exact vortex timing, and task-specific routes
policy_translation: retain body-frame LOS and joint-state phase feedback; use reflection-invariant helpful yaw-moment alignment and yaw-error satisfaction to reduce only posterior half-cycle amplitude asymmetry
falsification: reject if capture or wake coherence is lost, arrival exceeds 19.052T, posterior occupancy exceeds 76.41%, or force/moment RMS exceeds 0.01574/0.00810; do not extrapolate beyond direct low-flow still water

The current candidate's CFD outcome is not claimed here; it becomes evidence
only after this worker exits.
