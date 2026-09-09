# Candidate diagnosis and hypothesis

## Evidence read before the edit

- Confirmed all four sampled rollouts used direct uniform still water with
  `U_infinity=(0,0,0)` and terminated in capture. Read every combined
  `wake_keyframes.jpg`, including the top-down mid-plane and oblique Lambda2
  rows, plus each observation, metric, diagnostic, trajectory, score, and
  candidate policy.
- The top-down rows show self-propulsion along the same direct upper-right to
  lower-left route, not background advection. Each carrier sheds a compact,
  alternating red/blue wake with comparable lateral wavelength and no visible
  breakup before capture. The oblique rows confirm paired three-dimensional
  structures remain localized around the posterior wave; none shows a load or
  stability failure before the target sphere is reached.
- The response-plus-predicted-miss consensus policy is the strongest current
  finite example: `solver_e0a2513d969f` captured at `15.50081T`, scored
  `-0.02108896`, and had a `1.90236L` distance integral. It crossed while
  retaining a nearly horizontal targetward velocity and the same compact wake.
  Peak normalized planar force/moment were `0.03653/0.01801`, neither joint
  dwelled beyond `40 deg`, and near-rate occupancy was `17.84/17.03%`.
- The assigned parent `solver_64ab25982638` also captured, but response alone
  released shared half-cycle steering before predicted miss was small. It
  arrived at `16.02701T`, scored `-0.02335129`, and had a `1.90579L` distance
  integral; its final top-down path was visibly lower and more downward. The
  always-pulse sample arrived at `15.98301T`. A raw lateral-corridor release of
  shared steering with an always-on pulse arrived at `15.92089T` but crossed
  still lower, scored `-0.02548660`, and introduced `0.276%` posterior
  `>40 deg` dwell. Those are informative underperforming captures rather than
  semantic failures.
- Inherited guidance supplies the missing failure contrast: byte-identical or
  closely related response/pulse executions have missed in the
  `1.01--1.22L` band and exited left, while angle-domain carrier subtraction
  missed at `0.8293L`. Thus a single capture does not establish repeat
  robustness, and raw measured target/course geometry should not be replaced.

## One candidate

Keep the evidenced oscillator, posterior lag, predictive interception, mean
bend, carrier-separated yaw response, and far-field half-cycle steering
unchanged. Change only terminal handoff structure. Shared half-cycle steering
will release when corrective carrier-separated yaw agrees with the raw
body-frame lateral capture corridor. The posterior mid-stroke pulse will
continue to release when that same response agrees with small predicted course
miss. This actuator-specific response-plus-geometry consensus is distinct from
all four sampled policies: the shared actuator controls lateral route geometry,
whereas the posterior pulse shapes the predicted course.

Expected result: preserve the direct compact-wake capture topology and the
parent's low-load/joint-quality class, while avoiding premature common-channel
release on a transient yaw response. Reject the mechanism if it loses capture,
does not improve the inherited `1.01--1.22L` miss band in later repeats, or
worsens arrival/distance integral, route shape, rate/angle occupancy, or
normalized force/moment together.

bookshelf_consulted: true
source_domain: biological burst redirects and sensor-modulated robotic-fish CPG turning
source_mechanism: strong asymmetric rhythmic redirect released by observed response and remaining geometric error rather than a clock
transferable_invariant: preserve the propulsive rhythm while response and normalized task geometry jointly decide when a transient redirect has completed
nontransferable_details: species kinematics, published gains, duty ratios, exact vortex phase, and any task-specific route
policy_translation: use carrier-separated yaw response plus raw body-frame lateral corridor to release shared half-cycle asymmetry, and the same response plus normalized predicted course miss to release the posterior pulse
falsification: reject on loss of capture or compact-wake route, failure to improve inherited near misses, or joint/load degradation without an arrival or distance-integral benefit
