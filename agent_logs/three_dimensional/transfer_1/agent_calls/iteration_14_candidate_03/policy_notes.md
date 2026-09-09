# Candidate diagnosis and hypothesis

## Evidence read before the edit

- All four sampled evaluations use direct uniform still-water initialization
  with `U_infinity=(0,0,0)` and terminate by capture. The combined sheets for
  the strongest finite rollout (`solver_6b0e320e2f55`) and the lowest-scoring
  sampled capture (`solver_29faa601686c`) show self-propulsion rather than
  advection: from `4T` onward both lay down a long, coherent alternating
  top-down vortex street, and the oblique row retains compact alternating
  Lambda2 structures through the terminal approach. There is no visible wake
  collapse, collision, or numerical instability immediately before capture.
- The assigned parent bytes are reproduced exactly by
  `solver_2d0a4a628957`, `solver_5fd3c75ceead`, and
  `solver_6b0e320e2f55`. Those three independent samples all capture at
  `18.2050--18.6010T`, with mean distance `2.0387--2.0456L`, crossing speed
  `0.8268--0.9083L/T`, and similar force/moment peaks. This establishes the
  combined projected-intercept guard plus selective outward-carrier reserve
  as a repeat-supported route/capture mechanism, not a one-run threshold
  accident.
- The remaining limitation is actuator utilization. Across the three exact
  parent repeats, returned head/tail acceleration is clamped on about
  `68.9%/70.9--71.2%` of rows, both joints touch `260 deg/T`, and near-limit
  speed residence is about `13.0--13.3%/13.7--13.9%`. Thus the sparse
  carrier-only reserve preserves success but does not prevent the combined
  carrier-plus-steering command from continuing to request outward
  acceleration at the velocity envelope.
- The assigned parent's inherited log sequence contains a new capture at step
  12 between lower-domain failures at steps 11 and 13, so the protocol's
  three-consecutive-stagnant-iteration trigger is not met. The shelf was also
  consulted organically because this candidate changes the control-allocation
  mechanism rather than a scalar gain.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation and terminal capture control
source_mechanism: preserve a propulsive rhythm while sensor feedback bounds when corrective actuation is admitted
transferable_invariant: retain the joint-state traveling bend and use normalized observed state to withhold only dynamically infeasible effort while leaving useful restoring motion available
nontransferable_details: published gains, duty ratios, species kinematics, exact tail-beat phases, dimensional frequencies, and task-specific routes
policy_translation: after the inherited intercept and sparse-reserve logic, project only the terminal combined acceleration component pointing outward with joint velocity as normalized speed approaches its envelope; pass restoring acceleration and all far-field commands unchanged
falsification: reject the projection if capture ceases to repeat, the coherent alternating wake weakens or coasts, early distance closure changes, crossing speed collapses, loads rise, or speed/clamp residence does not improve

## Candidate policy hypothesis

Add one smooth terminal velocity-feasibility projection after carrier and
steering are combined. For each joint, derive speed ratio from observed joint
velocity; above a parameter-owned threshold, attenuate only the acceleration
component having the same sign as velocity, reaching a small retained outward
fraction at the hard speed envelope. Acceleration opposing velocity is passed
unchanged, as are all commands outside the inherited terminal distance gate.
This should preserve the repeat-supported route, intercept veto, and traveling
wake while preventing the controller from spending terminal authority pushing
against the joint-speed clamp. The next CFD evaluation must decide the
hypothesis; no outcome from this unevaluated candidate is claimed here.
