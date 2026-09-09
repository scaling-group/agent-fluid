# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled rollouts and the assigned parent's inherited evaluations
  report direct uniform still-water initialization with
  `U_infinity=[0,0,0]`, no cylinders, and no prewarm. Motion in both visual
  rows is therefore self-propelled, not ambient advection or reused flow.
- Both top-down and oblique rows were inspected for the sampled `0.7493L` and
  `0.7480L` captures and the `3.0031L` and `3.1135L` left-domain failures.
  The captures sustain a coherent alternating top-down street and compact
  three-dimensional Lambda2 structures through interception at `18.6065T`
  and `18.2050T`. The broad failures also keep swimming, but their nearly
  straight target-missing routes carry them through the left boundary. This
  supports retaining the captured achieved-course/intercept topology rather
  than changing far-field route gain, cadence, or the traveling bend.
- The assigned parent's sparse actuator-reserve mechanism is now positive
  sampled evidence: relative to its inherited projected-intercept miss at
  `1.0509L`, it reached `0.7480L` capture while preserving the terminal wake,
  about `0.908L/T` capture speed, and comparable or lower force/moment peaks.
  One evaluation does not establish repeatability, especially because the
  earlier `0.7493L` LOS policy later failed an exact-policy repeat.
- The reserve mechanism did not meet its separate actuator-envelope
  expectation. Its action clamp fractions remained about `68.6%/71.0%`, and
  exact joint-speed-limit residence increased to about `10.6%/11.3%` from the
  inherited intercept guard's `8.6%/7.9%`. At capture, joint 2 was exactly at
  the `260 deg/T` bound while its returned acceleration was still outward.
  Carrier-only relief can leave the additive steering residual requesting
  acceleration that the joint-speed clamp cannot realize.
- The inherited half-cycle steering and posterior phase-lag transfers missed
  at `1.7456L` and `1.6818L`; posterior mean curvature also missed at
  `1.5454L`. Together with the two broad failures, this rejects another
  half-cycle weight, phase-lag edit, static curvature, tighter intercept
  corridor, or scalar-only propulsion change for this candidate.

## Candidate mechanism and falsification

Start from the evaluated reserve-gated capture policy without changing its
body-frame course error, projected-intercept release guard, cadence,
traveling-bend target, steering allocation, or carrier-reserve parameters. Add
one terminal joint-speed governor after carrier and steering are combined.
For each joint, normalize measured speed by the known actuator limit and form
a smooth gate only when the proposed total acceleration points outward. Near
the speed ceiling, continuously replace that infeasible outward command with
a small restoring acceleration; pass inward acceleration through unchanged.
The existing body-frame terminal-distance gate keeps the governor out of the
far-field route. This is an actuator-feasibility projection, not lower cadence
or more route gain.

Expected test: preserve the sampled capture topology and coherent alternating
wake while reducing exact speed-limit residence and returned-acceleration
clipping. A capture remains the primary semantic criterion; a sub-`1.0509L`
pass with meaningfully lower envelope residence and no load increase is useful
but does not supersede capture.

Falsification: reject the governor if it changes far-field closure, weakens
the terminal traveling wake, loses capture or worsens the `1.0509L` reference
pass, merely pins speed at the ceiling with zero command, raises force/moment
loads, or reduces joint-speed residence only by recreating carrier collapse.
An additional capture is still provisional until the same policy repeats.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and terminal approach hold
source_mechanism: preserve the rhythmic traveling bend while measured actuator state withdraws only commands that are infeasible at an envelope boundary
transferable_invariant: terminal feedback should preserve propulsion and redirect only outward saturated effort into bounded restoring action instead of globally suppressing the carrier
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, exact beat and vortex phases, prescribed duty ratios, and task-specific routes
policy_translation: retain the body-frame intercept controller and use normalized two-joint speed plus proposed acceleration sign to blend infeasible outward terminal acceleration into mild restoring acceleration
falsification: reject if capture topology or wake coherence is lost, far-field closure changes, speed-limit and clamp residence do not fall, or loads rise

## Non-CFD verification

- The parameter-schema inventory contains every direct `params.FIELD`
  reference, and the solver editable-boundary check passes.
- Algebraically, the governor gate is exactly zero outside the terminal range,
  below its joint-speed threshold, and whenever proposed acceleration is
  restoring. At the exact speed boundary with outward acceleration it returns
  the opposite-signed `4 rad/T^2` restoring command; simultaneous lateral
  reflection negates that result.
- A recorded-trace projection, not a CFD prediction, activates above a `0.01`
  gate on `205/6620` joint samples of the sampled captured trace and
  `433/12388` samples of the inherited `1.0509L` trace. Mean gates are only
  `0.0146` and `0.0172`, confirming sparse terminal intervention. Closed-loop
  evaluation must determine whether it actually reduces limit residence.
- Julia is not installed on this worker's executable path, so the local Julia
  contract command cannot run here; the designated checker records that
  environment result separately.
