# Axis-selective approach-cadence candidate

## Completed evidence and visual diagnosis before editing

- All four sampled solver episodes are finite `capture` rollouts initialized
  directly from uniform still water with `U_infinity=(0,0,0)`, no cylinders,
  and no prewarm.  The assigned v43 axis-selective parent is the strongest by
  scalar score: it captures at `17.75400 T`, score `-0.07917`, and
  total/observed distance integrals `1.965079/1.349898 L`.  Its mean/max speed,
  any-joint acceleration-limit residence, and peak normalized lateral-force /
  yaw-moment magnitudes are `0.7168/0.9603 L/T`, about `44.1%`, and
  `0.03225/0.01609`.
- The two sampled full-axial-launch implementations reproduce capture at
  `17.89700 T`, score `-0.08687`, and integrals `1.973131/1.359275 L`.
  They lead v43 by `0.0050/0.0195 L` at `2/4 T`, but trail it by
  `0.0378/0.0720/0.0929/0.0909 L` at `8/10/12/16 T`.  The inherited
  energy-conditioned bridge also regresses to `17.76500 T`, `-0.08764`, and
  `1.973614/1.358667 L`.  Together these completed results require preserving
  total-speed governance on the base posterior launch and axial governance
  only on v43's small energy-deficit residual.
- The sampled response/turn-load approach-cadence candidate is a semantic
  near-tie rather than a clear improvement.  It crosses one solver step
  earlier at `17.74850 T` and slightly lowers the observed integral to
  `1.349847 L`, with unchanged `0.9603/0.03225/0.01609` maximum
  speed/force/moment.  Its shallower terminal sample (`0.749589 L` versus
  `0.747977 L`) raises the terminal-hold contribution, total integral to
  `1.966395 L`, and worsens score to `-0.08082`; acceleration-limit residence
  also rises by about `0.17` percentage point.  Arrival time and observed
  approach therefore support retaining a small response-conditioned cadence
  hypothesis, but neither terminal sample depth nor scalar score supports
  adopting its steering-complement gate unchanged.
- I inspected every sampled combined sheet and compared the strongest v43
  parent with the readable full-axial regression from release through capture.
  Their top-down rows show active self-propulsion along the same smooth
  target-signed arc: the compact startup disturbance develops into a coherent
  alternating posterior street, with no reversal, collision, domain exit, or
  wake collapse.  Their readable oblique rows show compact paired Lambda2
  structures following the caudal region through capture.  The other two
  oblique rows are black rendering failures and are not evidence about 3D wake
  quality.  The matched visible topology and load scale identify response
  allocation, not a new vortex pattern, as the meaningful policy difference.
- The inherited guidance rules out extending crossflow to route-rate or direct
  actuation, route-wide lateral-load confidence, raw-crossflow dropout bridges,
  reverse steering spillover, whole-wave rate projection, and another launch
  amplitude change.  The completed carrier, selective crossflow pose cue,
  target curvature, posterior launch, and one-way carrier-first allocation
  therefore remain unchanged.

## One-candidate policy hypothesis

Start from the assigned v43 policy.  Preserve its carrier, route sensing,
target-signed curvature, launch envelope, approach steering, and actuator
allocation.  Reuse only the sampled candidate's small response-retained
approach-cadence branch, but replace its complement-of-turn-load discriminator
with a reflection-even axial-propulsion confidence: nonnegative forward
body-axis speed divided by total planar body speed.  Productive normalized
closing response must still be present.  Thus proximity does not withdraw a
coherent cadence while the fish is actually translating forward, whereas
lateral sway, backward motion, or lost closure continuously recovers the
evaluated v43 distance gate.  The ratio introduces no dimensional gain, route
identity, elapsed time, exact beat phase, mean bend, or direct flow actuation.

This mechanism is exact v43 outside the `2.1 L` approach region, when closing
is nonpositive, or when motion is wholly lateral/backward.  The intended
signature is a robust capture before `17.754 T` with observed and total
integrals below `1.349898/1.965079 L`, without depending on a lucky shallow or
deep terminal sample.  Reject it if the route or capture regresses, the
alternating two-view wake degrades, acceleration-limit residence materially
exceeds about `44.3%`, or maximum speed and normalized force/moment exceed the
completed `0.9603/0.03225/0.01609` envelope.

```text
bookshelf_consulted: true
source_domain: Lighthill-style posterior reactive thrust and sensor-modulated robotic-fish CPG control
source_mechanism: preserve an established traveling-wave carrier and modulate only residual cadence when measured motion is aligned with the propulsive body axis and task progress remains productive
transferable_invariant: lateral body motion is not axial propulsion, so a bounded gait residual should distinguish reflection-even forward response from sway while normalized closing feedback retains task authority
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, full-body amplitude envelopes, prescribed approach stages, exact vortex phases, and task-specific routes
policy_translation: blend only the existing normalized approach cadence gate toward full cadence using positive closing response times nonnegative forward body-axis speed divided by total planar body speed; preserve the two-joint state-feedback carrier, mean curvature, posterior launch, and componentwise projection
falsification: reject if capture or observed and total distance integrals regress, improvement depends only on terminal sampling depth, acceleration-limit residence grows materially, the organized alternating wake degrades, or speed and normalized force/moment exceed the completed v43 envelope
```

## Evidence boundary

All numerical outcomes and visual claims above come from the assigned parent,
sampled completed solver results, inherited optimizer notes, and inherited
durable guidance.  The candidate proposed here has no same-worker CFD result;
formal CFD runs only after this worker exits.

## No-CFD implementation audit

- The single materialized candidate is
  `dogfish_target_control_v45_axial_response_approach_cadence`, with SHA-256
  `a5d503dd0ccb3a55d2fc661847d462bb06454e6e8ec9ed20e9d0a73aaa11fbe9`.
- A targeted Julia comparison against the completed v43 policy confirms exact
  actions for representative far-target, nonclosing, lateral-only, and
  backward-motion states.  A near-target state with positive closure and
  forward body-axis motion changes action, remains finite, and stays within
  the componentwise acceleration limit.  All `66` direct `params.FIELD`
  references resolve against fields returned by `target_policy_params()`.
- The required configured check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this account.  Its material-guidance,
  lightweight Julia contract, and solver editable-boundary commands were run
  locally and separately and pass.  The duplicated rendered assigned-parent
  marker in the workspace README was removed so the prescribed guidance
  comparison has exactly one parent.  No formal CFD was run.
