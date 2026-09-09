# Candidate diagnosis and hypothesis

## Evidence read before editing

- The assigned parent is the prefilled geometry-scheduled half-cycle policy,
  byte-identical to `solver_02eaf03fe1d2`. It captures at `18.6505T`, with
  mean distance `2.09340L`, acceleration-limit contact of about
  `61.0%/73.2%`, and joint-rate-limit contact of about `11.0%/15.1%`.
- Both combined sheets inspected for `solver_8687829e1d01` (best sampled
  scalar score) and `solver_072da2f3a45e` (most informative sampled
  underperformance) report direct uniform `U_infinity=0` initialization.
  Their top-down rows show self-propelled, target-directed alternating vortex
  streets without advection or wake collapse. Their oblique rows retain
  compact, alternating caudal Lambda2 structures from release through capture.
  The weaker sample takes a visibly larger vertical excursion near the target;
  neither view supports changing the traveling-bend carrier or adding a
  disturbance-rejection residual in still water.
- `solver_8687829e1d01` is an executable comment-only replication of the
  parent and captures at `18.6835T`, mean distance `2.09405L`.
  `solver_a1b6333c00d2` couples the geometry amplitude schedule to the existing
  correcting-response gate and lands inside that repeat band (`18.6615T`,
  `2.09362L`), so the extra coupling is not a semantic improvement.
  `solver_072da2f3a45e` stacks terminal range relief and lateral-velocity lead;
  it still captures but is slower and less direct (`19.0520T`, `2.09874L`),
  while demand remains about `60.9%/73.1%` acceleration contact and
  `10.9%/14.8%` rate contact. This is negative evidence against another
  terminal or velocity compound.
- Inherited completed evidence further bounds the edit: joint-velocity phase
  prediction and removal of the one-sided response-release gate both lose
  capture in coherent-wake downward exits, while pointwise outward rate
  barriers remove rate contact but also lose capture. Therefore the candidate
  preserves displacement-only phase, target-owned turn sign, response release,
  differential mean curvature, the `15%` target-lateral amplitude schedule,
  posterior lag, and final acceleration projection.

## Policy hypothesis

Add one new mechanism: slowly reduce the state-feedback oscillator's natural
rate in proportion to absolute normalized body-frame target lateral fraction.
Use the same effective rate consistently in the anterior restoring term, the
dimensionless posterior `qdot1/omega` lag, posterior tracking, and posterior
damping. This schedules a coherent limit cycle rather than clipping an
outward command at the joint-rate boundary, and it never supplies route sign.

Expected outcome: the persistent geometry schedule should give steering
curvature more authority per beat and reduce rate/acceleration contact without
changing the successful trajectory topology. The mechanism survives only if
CFD retains capture, the coherent wake in both views, and the established
`2.0934--2.0941L` mean-distance band, with a measurable demand reduction.
Reject it if arrival becomes meaningfully slower, capture is lost, the route
leaves that band, or rate/acceleration contact does not fall; in that case the
carrier should retain geometry-only amplitude scheduling and later workers
should test a different actuation primitive rather than tune this relief.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control
source_mechanism: closed-loop modulation of rhythmic angular velocity while a coupled oscillator preserves gait organization
transferable_invariant: slow task geometry may schedule the rate of a state-feedback traveling wave if phase relationships and bounded route authority remain coherent
nontransferable_details: published gains, robot morphology, clock phase, species beat rates, dimensional frequencies, and task-specific paths
policy_translation: absolute target_body_L lateral fraction smoothly lowers one effective omega used by every omega-dependent two-joint oscillator and lag term; target geometry and the inherited gate still exclusively own turn sign
falsification: reject on lost capture or wake coherence, departure from the 2.0934--2.0941L route band, meaningfully later arrival, or no measured reduction in acceleration and rate contact
