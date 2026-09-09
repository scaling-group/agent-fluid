# Wake-policy candidate diagnosis

## Evidence read before editing

- All sampled and assigned-parent episodes used direct uniform still-water
  initialization with `U_infinity=[0,0,0]`, no cylinders, and no prewarm.
  Their finite translation and alternating wakes therefore show
  self-propulsion rather than ambient advection or initialization leakage.
- Both rows of the combined keyframe sheets were inspected. The sampled
  line-of-sight-guarded policy captures at `0.74934L` after `18.6065T` while
  retaining a coherent alternating top-down vortex street and compact oblique
  Lambda2 structures. The terminal mean-curvature failure also retains a
  strong wake, but bends into a sustained downward turn after its first pass,
  reaches only `1.5454L`, and exits through the lower boundary. The visual
  distinction is route realization, not presence of propulsion.
- The phase-compensated bearing and achieved-course rate cascades reach only
  `3.0031L` and `3.1135L` and repeat an upper/left exit. The successful trace
  shows that the achieved-course outer observation and carrier-aligned
  steering can instead produce the correct broad route, but its capture is
  only `0.00065L` inside the threshold and inherited replays miss at `1.5891L`
  and `1.7715L`; the narrow yaw-response release is not robust evidence.
- The assigned parent already tested terminal energy recovery (`1.1444L`),
  additive slip curvature (`1.0561L`), closing-speed cadence relief
  (`1.0959L`), and finally a velocity-ray collision corridor (`1.6045L`). All
  retain the lower-exit termination. The collision-corridor sheet still shows
  a coherent terminal wake, so its regression from the carrier-aligned
  `0.9532L` pass is evidence against another route-release threshold or scalar
  course adjustment.

## Candidate mechanism and falsification

Restore the unmodified achieved-course route error and the evidenced
traveling-bend carrier. Preserve shared carrier-aligned steering outside the
terminal region. As the target approaches, transfer part of that steering
authority into one bounded posterior wave-shape actuator: modulate tail lag in
opposite directions on the two observed anterior-velocity half-cycles. The
modulation depends on `turn_command * phi_dot[1]`, which is reflection-even;
its product with posterior lagged velocity remains reflection-odd. Thus it can
create requested turning through within-beat phase asymmetry without a clock,
static mean tangent, carrier attenuation, or memorized route.

Expected test: retain the early carrier-aligned route and coherent wake,
reduce the persistent fast lower pass by realizing terminal course correction
through posterior wave shape, and improve on `0.9532L` or capture while
reducing reliance on the already saturated additive acceleration channel.

Falsification: reject if behavior outside `4L` changes, minimum distance does
not beat `0.9532L`, the two-joint carrier or alternating wake weakens, action
saturation grows, or the same lower-exit topology remains. Then bounded
posterior lag asymmetry is not a useful steering actuator in this two-joint
plant; later workers should test a separately normalized yaw/slip disturbance
residual rather than tune lag magnitude or restore a collision corridor.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and sensor-modulated CPG wave-shape control
source_mechanism: change posterior phase lag differently over the two carrier half-cycles to turn while retaining rhythmic propulsion
transferable_invariant: realize a persistent body-frame route request through bounded within-beat wave asymmetry so steering does not extinguish the traveling carrier
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, prescribed CPG and vortex phases, exact routes, and source-specific duty ratios
policy_translation: use normalized anterior joint velocity and body-frame achieved-course error to modulate posterior lag equivariantly, while continuously transferring authority from the existing additive two-joint steering channel inside the terminal range
falsification: reject if early closure changes, the sub-0.9532L pass or termination class does not improve, saturation rises, or joint excursion and the alternating terminal wake deteriorate

## Non-CFD verification

- The material-guidance check, deterministic Julia policy contract, parameter
  schema guard, and solver editable-boundary check pass. The Julia contract
  returns two finite accelerations for the supplied synthetic observation.
- A paired synthetic lateral reflection produces accelerations equal to the
  negatives of the original outputs to `1e-12`. The effective posterior lag
  remains within `0.50--1.10`, and the terminal transfer gate is exactly zero
  at `5L`, so the new actuator cannot alter the evidenced far-field policy.
- These checks establish implementation semantics only. No CFD was run, and
  no improvement is claimed for this unevaluated candidate.
