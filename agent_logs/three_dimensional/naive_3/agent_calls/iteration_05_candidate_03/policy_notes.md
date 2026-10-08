# Candidate wake-policy diagnosis

## Evidence read before editing

- All four sampled rollouts report `uniform_direct` initialization,
  `U_infinity=(0,0,0)`, no cylinders, and `left_domain` termination. The
  combined keyframe sheets were inspected in both their top-down mid-plane
  vorticity row and oblique body/Lambda2 row.
- The sheets show self-propelled leftward motion with a coherent alternating
  three-dimensional wake rather than passive advection. In every sample the
  fish remains well above the target corridor, then turns nearly vertical and
  exits through the upper boundary; no visible wake collapse precedes the
  trajectory failure.
- The unscheduled body-frame slip controller is the informative baseline. It
  reaches `2.960L` at `17.699T` with the head at `y=12.37L`, about `2.87L`
  above the target, speed about `0.819U`, and almost zero instantaneous closing
  speed. It then recedes and exits at `26.637T`. This is a useful trajectory
  compared with the assigned parent's best `9.141L` static-curvature closest
  approach, but it is not terminal acquisition.
- The highest-scoring finite sample is the approach-hold variant
  (`score=-7.749`, `min=3.592L`, `final=6.158L`, exit at `21.538T`). Its lower
  raw anterior/posterior acceleration clipping fractions (about `0.314/0.406`,
  versus `0.564/0.647` for the unscheduled slip baseline) did not change the
  termination class or recover the target line.
- The slip baseline and all three distance/alignment schedulers are
  effectively coincident through `12T`: head position is about
  `(14.82,12.78)L`, distance is `6.68L`, and the head is already `3.28L`
  above the target. Scheduling carrier relief only inside roughly `4--5L`
  therefore reacts after the decisive lateral-route error has accumulated.
  The four sampled closest distances span `2.960--3.592L`, yet every rollout
  retains the same coherent-wake/upper-exit topology.
- Instantaneous heading rate is dominated by the propulsive beat (sampled
  peaks near `3.62 rad/T`), so it should not be added as another raw yaw-gain
  term. Its sign can still serve as a phase/response gate: for the established
  convention, `turn_command * heading_rate > 0` means the observed yaw is
  opposing the yaw requested by the target-relative curvature command.

## Policy hypothesis

Return to the evidenced unscheduled bearing-minus-body-slip carrier and add
one preemptive wave-shape mechanism. Keep the normal posterior lag whenever
yaw is target-directed or turn demand is small. Smoothly relieve only the
lagged `phi_dot1` share, with a bounded floor, during beat phases in which yaw
opposes a significant turn request. This uses raw yaw as a response/phase gate
rather than as a course signal, leaves the zero-centered anterior oscillator
unchanged, and does not introduce distance stages. The falsifiable expectation
is a target-directed mean turn before `distance_L=6L`, with preserved leftward
surge and coherent alternating wake. Reject the mechanism if the trajectory is
still above the target line near `12T`, if termination remains an upper exit
without better bearing containment, or if lag relief erases propulsion or
increases joint-limit occupancy.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking
source_mechanism: sensor-gated modulation of rhythmic wave shape, translated as response-gated posterior phase-lag relief
transferable_invariant: preserve the propulsive oscillator and modulate a bounded wave-shape component only when target error is significant and the measured turn response has the wrong sign
nontransferable_details: published oscillator gains, robot geometry, species kinematics, clock phase, exact tail phase, and task-specific routes
policy_translation: form a bounded turn command from normalized body-frame bearing and lateral velocity, then reduce only the posterior lag term when turn_command times normalized heading rate is positive
falsification: reject if early target-line correction or termination class does not improve, or if coherent surge, wake organization, or actuator reserve worsens
