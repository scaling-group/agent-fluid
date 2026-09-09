# Candidate diagnosis and hypothesis

## Evidence diagnosis

- All four sampled rollouts use direct uniform `U_infinity=0` initialization,
  have no cylinders, remain finite, and capture. The explicitly feasible
  response-triggered C-bend (`solver_efd2345fc503`) captures at `19.2335T`,
  with mean distance `2.0650L`, action RMS `25.19/28.56 rad/T^2`, acceleration-
  limit occupancy `44.9%/73.6%`, force/moment RMS `0.01322/0.00690`, and local-
  flow RMS `0.0180U`.
- The response-reversing posterior half-cycle candidate
  (`solver_85695f4d40af`) is the strongest sampled finite rollout: it captures
  at `18.9310T` with mean distance `2.0418L`. Its action RMS
  (`25.22/28.86 rad/T^2`), force/moment RMS (`0.01357/0.00707`), and local-flow
  RMS (`0.0184U`) remain close to the feasible C-bend baseline, although its
  posterior acceleration-limit occupancy rises to `76.1%`.
- In both combined keyframe sheets, the top-down row shows a coherent,
  alternating self-generated wake from release through approach; the oblique
  Lambda2 row confirms persistent three-dimensional wake structures without a
  visible body instability. The fish translates toward the target rather than
  being advected: background flow is exactly zero and local-flow RMS is small.
  The half-cycle case reaches capture slightly earlier without a visually
  weaker carrier. Neither sampled case collides with geometry or exits the
  virtual domain.
- Assigned-parent evidence supplies the robustness boundary: the same base
  distributed-C-bend hash has also missed `1.845L` high and exited left, with
  elevated `60.8%/76.4%` limit occupancy and `0.01574/0.00810` force/moment
  RMS. Therefore more mean bend, clipping, a memoryless near-range release, or
  scalar-only gain tuning is not justified. Inherited step scores also include
  left exits at `3.191L` and `11.995L` minimum range, while continuous C-bend
  and curvature-conserving variants capture; terminal closure must remain
  continuous.

## Policy hypothesis

Preserve the normalized bearing-plus-LOS route request, phase-conditioned yaw
response, continuous anterior C-bend, explicit acceleration projection, and
the sampled response-reversing posterior half-cycle scale. Add one small
response-reversing posterior phase rotation. Rotate the baseline posterior
wave coefficients rather than increasing their norm; choose the rotation from
the product of yaw-rate error and the observed joint-phase direction in which
that rotation would add desired-sign curvature. This is reflection-equivariant,
uses no clock or mutable history, reverses when yaw outruns route demand, and
offers beat-phase authority without another mean-bend gain increase.

Falsify the candidate if it loses capture, arrives later than the `19.2335T`
feasible baseline, weakens the coherent carrier, exceeds the assigned failure's
force/moment RMS (`0.01574/0.00810`), or raises posterior limit occupancy above
the assigned failed branch's `76.4%`. A single capture would support the phase
mechanism but would not establish repeatability; later workers should require
replication because the base hash has bifurcated between capture and left exit.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG control and asymmetric/phase-lag turning
source_mechanism: sensor-conditioned modulation of a propulsive oscillator's posterior phase while preserving the traveling wave
transferable_invariant: preserve the propulsive rhythm and apply bounded beat-phase steering from target error and measured response, reversing the modulation when the body turn outruns demand
nontransferable_details: published CPG gains, clock phase, robot geometry, species kinematics, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame bearing and LOS rate to form desired yaw, phase-conditioned measured yaw for response error, and joint angle/velocity to rotate the two posterior wave coefficients at fixed coefficient norm before the two-joint acceleration law
falsification: reject if capture is lost, arrival is later than 19.2335T, the alternating wake weakens, posterior limit occupancy exceeds 76.4%, or force/moment RMS exceed 0.01574/0.00810
