# Candidate diagnosis and policy hypothesis

## Evidence read before the edit

- All four sampled rollouts report direct-uniform still water with
  `U_infinity=[0,0,0]`, no cylinders, and no prewarm. Their top-down sheets
  develop body-connected alternating vorticity and their oblique sheets show
  compact three-dimensional Lambda2 structures. Translation is self-propelled;
  the common `left_domain` result is a navigation failure, not advection or a
  missing propulsive wake.
- The sampled prefill reaches `3.312L` and then hooks upward. The closest
  sampled release reaches `2.664L` but its late sheet is a tight upward curl,
  while the best-score sample remains straighter and never comes within
  `4.650L`. Together with the inherited release-gate results, this rejects more
  scalar asymmetry, carrier-relief, or bend-threshold tuning as a terminal
  mechanism.
- The inherited course-residual carrier and `3L` target-bearing mean-curvature
  handoff define the useful approach: `1.173L` and `1.033L`, respectively, with
  a coherent wake, no `>40 deg` dwell, and low loads. At the `1.033L` closest
  point the fish is still moving down-left at about `1.07L/T`; target bearing
  has not been reduced early enough for the `0.75L` crossing.
- The latest inherited tests sharpen the negative boundary. A closing-speed
  damped hold reaches `1.008L` but nearly zeros the action at closest approach
  and visibly coasts into the lower exit. A velocity-lead target point reaches
  only `1.158L` and follows the same lower-exit topology. Applying the
  response-signed curvature continuously reaches `1.106L`; it sacrifices some
  closest approach but materially changes the recovery to a target-height
  left-edge exit. Thus the evidenced sign is useful, but it should be recruited
  only when the terminal bearing is stalled or worsening, not held throughout
  the terminal region.

## Single candidate hypothesis

Replace the weaker sampled prefill with the evidenced course-residual
traveling carrier and terminal mean-curvature handoff. Add one new semantic:
derive the full-circle target-bearing rate from the normalized body-frame
target-window rate, and smoothly recruit the empirically response-signed mean
curvature only while a close, off-course target bearing is stalled or growing.
When bearing begins shrinking, release back to the ordinary target-bearing
mean and full traveling carrier. This is a state-feedback burst redirect; it
does not brake propulsion, impose a clock, or add a fixed route.

Capture is the primary support criterion. Weaker support requires a closest
pass below `1.008L` or a non-left termination while retaining coherent wake,
joint reserve, and low loads. Falsification is loss of the inherited `1.033L`
approach, another lower-boundary coast, a target-height left escape without a
closer pass, persistent joint-limit dwell, or load growth without capture.

bookshelf_consulted: true
source_domain: fish C-start burst redirection and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: recruit strong curvature when directional error is large, then release it when the observed heading response appears so the traveling propulsive rhythm resumes
transferable_invariant: turn authority should depend on both target error and measured error response, rather than remaining as a static terminal posture or a clocked maneuver
nontransferable_details: published gains, dimensional response times, species-specific C-start kinematics, robot linkage geometry, exact oscillator phase, vortex phase, and prescribed routes
policy_translation: use normalized body-frame target geometry and its observed window rate to gate a response-signed two-joint mean-curvature redirect around the unchanged course-residual traveling carrier
falsification: reject if capture or closest-pass and termination class do not improve together, or if wake coherence, joint reserve, or load quality regress

## Dry validation only

A `314,928`-state grid spanning joint angles and rates, fore/aft and lateral
target geometry, translational velocity, target-window rate, and distance
produced finite commands strictly inside the smooth `30 rad/T^2` envelope and
exact left/right reflection (maximum error `0.0`). On the same representative
close off-course state, a stalled bearing response produces
`(-20.091,-19.858) rad/T^2`, a correcting response releases to
`(2.532,25.389) rad/T^2`, and unavailable startup history safely uses the
ordinary carrier at `(4.058,26.243) rad/T^2`. The configured policy contract,
parameter schema, guidance materiality, and editable boundary pass. These are
algebraic checks, not CFD evidence; later formal evaluation must decide every
physical falsifier above.
