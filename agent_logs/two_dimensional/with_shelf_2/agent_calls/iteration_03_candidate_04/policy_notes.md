# Multi-Wake Policy Candidate Notes

## Evidence diagnosis before the edit

- The shared prewarm sheet confirms a common developed four-street wake and
  identical held release pose, so differences after release are controller
  evidence rather than different initial flow.
- All four sampled rollouts exit through the lower domain without collision or
  numerical failure. The target-blind seed and the two posterior-only
  half-cycle variants form the same early topology: they move upstream only
  `-3.55L` to `-4.56L`, then turn almost vertically downward and exit after
  `50.13--54.90` release-time units. Their closest approaches remain
  `8.20--9.29L`, both joint velocities and accelerations meet the hard caps,
  and moment RMS remains `523--542`.
- The strongest sampled policy changes where the half-cycle asymmetry enters:
  it biases the zero-centered anterior acceleration and a smaller share of the
  posterior acceleration, with a smooth candidate-owned acceleration limit.
  Its sheet shows sustained self-propelled upstream motion into the useful wake
  region before a long downward arc. Metrics agree: upstream displacement
  improves to `-9.73L`, minimum/mean distance to `4.62L`/`9.14L`, release
  duration to `91.24`, and mean command energy to `853` from the assigned
  parent's `1504`. This is useful motion, but not robust steering: the fish
  passes below the target corridor, reaches `0.73` rad anterior bend and the
  velocity cap, and raises force/moment RMS to `314`/`3430` before lower exit.
- The inherited negative lesson against mean-curvature equilibrium remains
  supported. The new evidence sharpens it: preserve distributed
  acceleration-level half-cycle steering, but stop the command from continuing
  to build yaw after the body has already begun the requested turn.

## Candidate hypothesis

Use the strongest sampled zero-centered traveling-bend scaffold and retain its
distributed anterior/posterior half-cycle asymmetry. Replace the proportional
bearing-only turn fraction by a bounded predicted bearing error,
`bearing - response_horizon * heading_rate`. This is a structural
response-release mechanism, not a gait-gain sweep. It should preserve early
upstream propulsion while reducing persistent same-sign curvature, joint-limit
occupancy, moment load, and the final downward arc. The next CFD rollout
falsifies the hypothesis if it loses the strong sample's upstream displacement
or `4.62L` closest approach, or if it retains a lower-domain exit without a
material reduction in yaw/load symptoms.

bookshelf_consulted: true
source_domain: biological burst-redirect control and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: release asymmetric turning actuation when observed heading response is already closing the target error
transferable_invariant: combine body-frame target error with measured turn response so steering authority decays before overshoot while the propulsive rhythm remains active
nontransferable_details: species-specific burst kinematics, robotic CPG topology, published gains, dimensional response times, exact wake phases, and world-frame routes
policy_translation: retain the two-joint state-feedback traveling bend and distributed half-cycle asymmetry; drive its bounded turn fraction with bearing minus a candidate-owned normalized heading-rate lookahead
falsification: reject this transfer if upstream propulsion or closest approach regresses, or if the same downward exit, joint-cap contact, and high moment load survive despite the response term
