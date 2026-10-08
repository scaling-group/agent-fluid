# Posterior-only terminal phase-allocation candidate

## Visual diagnosis before the policy edit

- All four sampled policies and rollout artifacts are byte-identical v41
  replications.  They satisfy the frozen evidence contract: direct uniform
  still water (`U_infinity=[0,0,0]`), no cylinders or prewarm, and the L64
  inertial moving window.  Every replication captures at `24.640015T`, with
  minimum/final distance `0.748356L`, mean distance `2.347937L`, score
  `-0.448328283`, and 284 storage-window shifts.
- Both the top-down mid-plane and oblique Lambda2 sheets were inspected from
  release through capture.  The top-down view begins wake-free, then shows
  self-propelled diagonal progress with a coherent alternating vortex street
  and a bounded transverse hook into the target.  The oblique view shows
  compact three-dimensional wake structures rather than an out-of-plane
  escape or numerical breakup.  The fish is not passively advected, and no
  visible route or wake-class difference exists among the four replicas.
- The current sample contains no termination failure, so no failed keyframe is
  available to compare visually.  The informative failure boundary comes
  from inherited audited logs: posterior reference-velocity feedforward
  changed the established far route by `8T`, missed at `0.993183L`, and exited
  left at `37.1470T` despite a coherent wake and reduced rate-limit occupancy;
  broad dual-joint rate barriers also converted capture into a pass-and-turn
  exit.  These negatives exclude another widespread phase correction or any
  attempt to regulate both joints merely to improve saturation statistics.
- Against the replicated v40 corridor parent, v41's state-inferred half-cycle
  allocation advances capture by `0.021999T`, reduces mean distance by
  `0.000236L`, improves score by `0.000242448`, and lowers terminal projected
  miss from `0.637713L` to `0.631928L`.  All four current replicas confirm that
  small result exactly while retaining zero posterior hard-stop occupancy,
  roughly `13%` exact-rate exposure, `73.59%` raw acceleration-envelope
  exposure, and the low peak force/moment class near `0.023/0.032/0.0156`.
  Replication supports phase-aware terminal allocation, but the unchanged
  route and load classes do not justify another phase-gain or corridor scalar.

## Policy hypothesis

Preserve v41's anterior state-feedback oscillator, lagged posterior traveling
wave, normalized body-frame collision-course corridor, course-preview route,
steering-priority envelope, posterior stroke braking, posterior rate coast,
and every existing route-scale gain.  Make one actuator-routing change: keep
the established route steering coupled across both joints, but send the extra
terminal collision-course residual only to the posterior follower on the
already selected lagged-wave half-cycle.  The anterior oscillator therefore
remains the phase reference during this localized terminal correction instead
of receiving the same pulse.  Transfer the removed anterior share to the
posterior so the residual's total tail-tangent acceleration allocation is
unchanged before the inherited stroke/rate safety filters.

This is a controller-mechanism test, not scalar gain tuning.  It is exactly
inactive before the existing terminal residual is active, uses only normalized
body-frame geometry, velocity, and observed joint phase, and introduces no
clock, global direction, target identity, or stored route.  Expected evidence
is retained capture and exact far-route noninterference, with no regression in
coherent wake, posterior hard-stop, rate, or low-load class; posterior-only
authority may reduce needless anterior command interference while retaining
the v41 terminal miss/arrival improvement.  Falsify it if capture is lost,
arrival or projected miss regresses to v40, the pre-terminal command changes,
the posterior pulse returns a hard stop or higher load class, or the change is
hydrodynamically inert.  The candidate's CFD outcome will be produced only
after this worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: Lighthill tail-emphasized reactive swimming and sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: an anterior rhythm generator anchors a traveling bend while bounded sensory steering is applied through the posterior follower where tail kinematics supply control authority
transferable_invariant: preserve the observed anterior phase anchor and posterior lag, and localize a bounded target-derived correction to the posterior actuator on the productive state-inferred half-cycle
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, full-body envelopes, prescribed duty ratios, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: retain v41's mirror-equivariant body-frame collision-course residual and lagged-wave phase gate, keep route steering coupled, and transfer only the anterior share of the allocated terminal residual to the posterior follower
falsification: reject if capture, exact far-route locality, coherent wake, zero posterior hard-stop occupancy, or the low-load class is lost, or if terminal arrival and projected miss fall back to the v40 class

## Pre-evaluation validation

- A pure-function audit on all `4480` reconstructed v41 trace states returns
  finite commands.  The candidate differs on `245` states, first at
  `21.983505T` and `2.098608L`, and has zero same-state command difference at
  or beyond `2.10L`.  Thus the actuator-routing edit is confined exactly to
  the inherited phase-selected terminal support; it does not create a new far
  route signal.
- On that fixed trace the maximum candidate-parent command differences are
  `0.30618 rad/T^2` anterior and `0.27156 rad/T^2` posterior, far below the
  owned `31.41593 rad/T^2` acceleration envelope.  The posterior difference is
  smaller than the transferred anterior share where the inherited stroke and
  rate guards already filter it.  This is a locality and boundedness audit,
  not a coupled hydrodynamic result.
- An isolated reflected actuator pair gives exactly opposite allocated
  terminal steering and joint deltas, confirming that the routing preserves
  the inherited body-frame reflection parity.  The public contract returns
  two finite accelerations, and all `87` direct `params.FIELD` references
  resolve among the `89` fields returned by `target_policy_params()`.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account.  Its three declared checks were therefore
  run directly and separately: the reusable-guidance semantic check, Julia
  public-contract probe, and solver editable-boundary check all pass.  The
  duplicated assigned-parent marker in the rendered workspace README was
  removed so the guidance validator has one unambiguous baseline.  No formal
  CFD was run.
