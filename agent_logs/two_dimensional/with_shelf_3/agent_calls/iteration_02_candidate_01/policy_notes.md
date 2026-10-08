# Multi-Wake Target-Policy Candidate Notes

## Evidence read before the policy edit

- The assigned parent is the deliberately naive, target-blind joint-state
  oscillator in the current `solver/` tree. Its lagged posterior target makes
  a visible traveling bend, so the useful seed capability is propulsion rather
  than navigation.
- The shared prewarm sheet shows the held fish above and downstream of four
  fully developed, interacting vortex streets. It is common initial-condition
  evidence for all four sampled policies, not a policy-specific advantage.
- In `solver_4b03cd285d3a`, the released fish moves under its own traveling body
  wave but curls into a nearly vertical descent and leaves the lower domain at
  `50.1269` release time. Head displacement `(-3.545,-13.300)L`, closest
  approach `8.615L`, and progress `0.0243` confirm that it never converts its
  initially useful upstream component into target navigation. Both joints hit
  the velocity and acceleration envelopes, so more oscillator drive is not
  the missing feedback class.
- `solver_ad1db499142c` is the informative transferred-mechanism failure. Its
  bearing-biased oscillator puts as much as `10 deg` of mean bend on joint 1
  and `5 deg` on joint 2. The keyframes show no sustained upstream traverse;
  it is carried out after only `18.6834` time units, with head displacement
  `(2.195,-1.302)L`, minimum distance `12.424L`, and negative progress
  `-0.1407`. Its low relative-crossflow and load metrics arise because it
  never enters the useful wake corridor, not because it controls the wake
  better.
- Two more coherent curvature allocations reach the target. The `8 deg`
  anterior / `5.2 deg` posterior-limit structure in `solver_cf905c92f9f7`
  arrives at `42.8560`, with mean distance `2.119L`. The total-curvature split
  in `solver_96495c5b1e65` limits the joint centers to `5.4 deg` anterior and
  `6.6 deg` posterior and arrives at `39.7374`, with mean distance `1.934L` and
  the best sampled score, `-0.05676`. Their keyframes show active, nearly
  diagonal upstream swimming through the developed wakes to first capture,
  rather than passive advection.
- The successful policies tolerate more, not less, recorded disturbance than
  either failure: RMS relative crossflow is `0.215-0.227`, RMS lateral force
  `50.4-53.7`, and RMS moment `713-762`. Both also touch the joint velocity and
  acceleration envelopes. Therefore these rollouts validate target-signed
  curvature and posterior wave preservation, but do not validate indiscriminate
  wake cancellation, reduced-drive tuning, or an efficiency claim.
- Inherited worker notes proposed the same mean-curvature family from the seed
  and correctly made sign, propulsion retention, saturation, and load the
  falsification boundaries. The newly available evaluations now resolve that
  hypothesis positively for two allocations and negatively for the
  anterior-heavy implementation. The unevaluated actuator-headroom proposal
  remains a hypothesis and is not promoted over two completed captures.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological and robotic-fish turning with closed-loop CPG modulation
source_mechanism: body-frame direction error biases the mean curvature of an otherwise propulsive rhythm
transferable_invariant: a bounded target-signed average bend can redirect a traveling body wave while posterior lag and posterior authority preserve propulsion
nontransferable_details: published gains, species and robot kinematics, dimensional beat rates, exact vortex phases, duty ratios, and source-task routes
policy_translation: map normalized body-frame bearing through a smooth saturation to one total curvature request, split it across the two joint centers with a slight posterior emphasis, and retain the seed's state-feedback oscillator and velocity-derived posterior lag
falsification: reject the transfer if a repeated or held-out rollout loses target capture, reverses the turn sign, collapses upstream propulsion, or converts the observed envelope contact and wake loads into instability

## Candidate hypothesis

Relative to the assigned naive parent, add exactly one controller mechanism:
body-frame target bearing to bounded mean curvature. Promote the best completed
sample, `solver_96495c5b1e65`, without an unsupported scalar extrapolation. A
`12 deg` total request is smoothly scheduled by a `20 deg` bearing scale and
split `45/55` between the anterior and posterior joint centers. The oscillator
and posterior lag remain unchanged, and no flow, force, coordinate, time, or
wake-phase signal is added.

The expected formal evidence is a repeat of the direct diagonal trajectory and
`target_reached` termination near the sampled `39.74` release time. The
candidate does not claim a new CFD result before evaluation. Later workers
should compare repeatability, distance integral, arrival time, saturation
residence, and force/moment loads; a failed repeat would falsify promotion from
this single common wake phase even though the sampled run succeeded.
