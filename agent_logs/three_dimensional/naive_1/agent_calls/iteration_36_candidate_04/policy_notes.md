# Wake-policy candidate notes

## Evidence diagnosis

- All four sampled rollouts are valid direct-uniform still-water evaluations
  and terminate in capture. Three use the executable-identical half-cycle
  envelope-redistribution policy: they capture at `18.6505--18.8815T`, with
  mean distance `2.08855--2.09222L`. Their repeat spread is evidence for one
  controller, not three gain choices.
- The fourth sample adds a rearward route multiplier, captures at `18.9640T`
  with mean distance `2.09072L`, and never places the target behind the fish.
  Its branch is therefore unexercised and provides non-interference evidence,
  not recovery evidence.
- The best-score redistribution sheet and the rearward-branch comparator both
  show genuine self-propulsion: a coherent alternating top-down street grows
  from release through target approach, and the oblique row retains compact
  caudal Lambda2 structures. The trajectories bend continuously toward the
  target rather than being advected; there is no visible collision, domain
  exit, or wake collapse before capture.
- Diagnostics agree with the images but expose a structural cost. Across the
  four samples, anterior/posterior acceleration projection is active on about
  `60.85--61.17%`/`72.97--73.27%` of trace rows, rate contact is about
  `11.28--11.36%`/`14.97--15.33%`, and peak planar force/moment bands overlap.
  The rearward branch does not relieve these demands.
- Assigned-parent guidance retains redistribution as the current performance
  candidate but records an executable-equivalent miss at `0.81206L`. Sampled
  optimizer guidance contains a second executable-equivalent miss: it reaches
  only `1.25093L`, bends below the target, and exits left at `32.6370T` despite
  an energetic two-view wake and finite loads. Inherited scalar-only optimizer
  logs remain capture-class and do not resolve this semantic contradiction.

## Candidate hypothesis

Test one clean architectural ablation back to geometry-scheduled common-envelope
control: retain target-signed differential curvature, displacement-only
half-cycle steering, one-sided response release, posterior lag, and the exact
final acceleration projection, but remove beat-phase redistribution from the
propulsion-amplitude relief. This leaves lateral target fraction as the sole
owner of the common envelope and prevents a joint-phase observation from
simultaneously changing both steering bias and propulsion amplitude.

The expected semantic improvement is repeatable route capture without the
redistribution-specific downward near-miss topology. Prior sampled guidance
reports geometry-scheduled captures at `18.6505--18.7550T` and mean distance
`2.09340--2.09542L`, plus a later capture at `18.6010T` and `2.09042L`; this is
a robustness test, not a claim that the unevaluated candidate already improves
score or actuator demand. Falsify it if it loses capture or either coherent
wake row, falls outside those route bands, increases peak planar loads, or
reproduces the below-target/left-exit topology. Acceleration and rate contact
are secondary here and must not be credited without route retention.

```text
bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG control and asymmetric turning
source_mechanism: sensor feedback modulates a low-dimensional rhythmic carrier while coordinated oscillator coupling preserves propulsion
transferable_invariant: keep the two-joint traveling bend coordinated and let normalized body-frame target geometry own slow common-envelope modulation
nontransferable_details: published gains, clock phases, species-specific amplitudes, full-body kinematics, and task-specific routes
policy_translation: remove joint-phase redistribution from amplitude relief while retaining target-signed displacement-phase steering and the posterior-lag carrier
falsification: reject on lost capture, loss of either coherent wake view, route statistics outside the geometry-scheduled capture band, increased planar loads, or recurrence of the downward left-exit topology
```
