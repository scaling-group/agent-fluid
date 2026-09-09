# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled evaluations report `uniform_direct` initialization,
  `U_infinity=(0,0,0)`, no cylinders, and capture. The current finite leader is
  `solver_649d7e789a5a` at score `-0.20040558`, arrival `18.82649T`, and mean
  distance `2.088545L`; its executable redistribution policy is identical to
  `solver_d2a3f8408b10` and `solver_e6ed5ba2c4a4`. Those three captures span
  `18.65050--18.88149T` and mean distance `2.088545--2.092222L`.
- The three redistribution sheets show genuine self-propulsion: their
  top-down rows develop a coherent alternating street that bends toward the
  target, while the oblique rows retain compact paired caudal Lambda2
  structures through capture. The separately sampled broadside-reserve policy
  (`solver_de4c121e5685`) has the same useful two-view wake class and captures
  at `18.70550T`, but its mean distance `2.093857L` does not beat the
  redistribution band. No current sampled solver is a failure, so there is no
  failure keyframe sheet to inspect; the informative failure is the assigned
  parent's completed direct composition, whose inherited record reports an
  energetic two-view wake but a `1.90495L` near miss followed by left exit.
- Reconstructing normalized body-frame target direction from each sampled
  trajectory finds `46--47` lateral-sign crossings and `9.35--9.88%` of rows
  within `|lateral_fraction| < 0.05`. A moving mean over the available eight
  observation rows leaves every sign-crossing count unchanged, so merely
  averaging that short history is not a supported filter. The three
  redistribution traces also remain actuator-heavy: anterior/posterior
  acceleration contact is `60.85--61.00%`/`72.97--73.27%`, and rate contact is
  `11.03--11.07%`/`14.91--15.07%`.

## Policy hypothesis

Retain the executable redistribution carrier, traveling bend, target-owned
turn sign, correcting-yaw release, and hard acceleration projection. Replace
only the route mapping inside a narrow normalized alignment sector: smoothly
release mean-curvature steering when the body-lateral target fraction is tiny,
and recover the inherited route request exactly outside that sector. This is
intended to stop the mean controller from chasing beat-scale sign changes while
leaving large-error redirect and the propulsion envelope unchanged. It is not
an actuator-gain or propulsion retune.

Falsify the candidate if it loses capture, changes either coherent wake view,
departs adversely from the sampled arrival/mean-distance band, worsens
actuator/load contact, or fails to reduce active opposite-sign route requests
inside the alignment sector. A capture with unchanged demand and trajectory is
non-interference, not evidence of relief.

A read-only replay of the new static route map over the four prior traces
confirms its intended scope: the gate differs from unity on
`14.99--15.82%` of rows, fully releases route curvature on
`5.46--5.73%`, and changes route-request RMS only from
`0.63093--0.64559` to `0.62956--0.64427`. This is a scope check, not a CFD
outcome or an improvement claim.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and asymmetric-flapping steering
source_mechanism: keep the rhythmic propulsion carrier intact while sensor feedback modulates a slower directional steering channel
transferable_invariant: separate persistent target-directed mean curvature from small beat-scale direction alternation
nontransferable_details: published CPG gains, clock phase, robot geometry, species kinematics, dimensional frequencies, and task-specific routes
policy_translation: apply a smooth deadband-to-unity gate to normalized body-lateral target feedback before the existing two-joint mean-curvature map, with exact recovery outside the alignment sector
falsification: reject on lost capture, degraded top-down or oblique wake coherence, worse route or load metrics, or no measurable reduction of low-error steering reversals
