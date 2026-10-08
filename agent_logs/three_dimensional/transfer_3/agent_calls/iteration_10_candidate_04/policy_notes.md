# Productive-crossflow terminal curvature-relief candidate

## Evidence diagnosis before the policy edit

- All four sampled solvers satisfy the frozen physical contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm snapshot, active moving-window transport, and capture
  from `12.32772 L`. They reproduce the same score (`-0.5283387731`), capture
  time (`25.11852 T`), mean distance (`2.429293780 L`), and final distance
  (`0.746410191 L`). The assigned prefill and the three peers are behaviorally
  identical; their policy files differ only in version text and comments.
- I inspected the combined sheets from release to capture for the assigned
  parent (`solver_6a17cfeee4e8`) and the visually incomplete comparator
  (`solver_89a97c83567b`), including the top-down vorticity and oblique
  body/Lambda2 rows. The parent is self-propelled along a compact curved route,
  sheds a coherent alternating wake with finite three-dimensional structures,
  and changes from broad oscillation to a stable held bend before capture.
  There is no collision, passive advection, domain-exit precursor, or visible
  instability. The comparator's top-down row agrees, while its oblique row is
  blank and therefore cannot establish a different 3D wake.
- I also compared the inherited terminal-response evaluations. Adding a
  shared yaw-rate-error curvature residual regressed to `-0.528781874`, a
  larger response-completion offset regressed to `-0.529278394`, and restoring
  extra paired carrier from bearing convergence regressed to `-0.531219848`.
  All still captured, so their useful negative result is that neither residual
  bearing at capture nor a one-step-earlier crossing proves a missing-turn or
  missing-propulsion mechanism.
- The parent's terminal trace instead shows productive crab-like translation.
  Below `1.6 L`, the normalized body-frame lateral target component is
  `0.654--0.772`, relative crossflow is `-0.279` to `-0.258 U` after the initial
  sample artifact, and range closes at `0.674--0.712 L/T`. Thus the flow seen
  opposite the target's lateral side agrees with motion toward the target,
  despite substantial body-heading error. Commands below `2.4 L` are tiny,
  both joints avoid their stops, and speed remains about `0.65 L/T`; more yaw
  authority or more carrier would fight an already useful terminal state.

## Policy hypothesis

Preserve the evaluated outer carrier, target-relative redirect, closure
preview, coordinated two-joint response release, and all command limits. Add
one independently gated terminal mechanism: only below `1.6 L`, use the sign
agreement between normalized body-frame target lateral geometry and relative
crossflow, together with positive range closure, to relax both targets of the
shared held-curvature equilibrium by at most ten percent. This does not damp
the productive crossflow, restore an oscillatory carrier, split joint roles,
or command a world-frame course. The mechanism is inactive throughout the
propulsive outer route and fades out whenever crossflow is not target-helpful
or range stops closing.

Expected evidence is the same two-view outer wake and compact capture, followed
by slightly straighter near-target joints and at least as much range closure,
with a deeper crossing or lower distance integral. Reject it if outer commands
change, capture is delayed or lost, lateral closure falls, the route loops,
the coherent wake changes before `1.6 L`, or joint-stop, command, force, or
moment excursions return.

bookshelf_consulted: true
source_domain: biological Karman-gait and wake-interaction studies
source_mechanism: retain useful lateral flow-induced motion when it advances the objective instead of reflexively cancelling it
transferable_invariant: a lateral response should be relieved rather than rejected when body-frame target geometry and measured relative flow agree that it is producing stable target closure
nontransferable_details: cylinder geometry, inflow speed, exact vortex phase, species-specific body waves, published gains, dimensional thresholds, and task-specific routes
policy_translation: normalized target lateral sign times relative body-frame crossflow and normalized closing speed smoothly gate a small coordinated relaxation of both terminal curvature targets inside a target-relative distance band
falsification: reject if the gate activates without positive range closure, if helpful lateral closure or capture regresses, or if outer wake topology, saturation, loads, or stability worsen

The new CFD evaluation occurs only after this worker exits and is not claimed
as evidence here.

## Non-CFD implementation audit

The candidate returns two finite bounded commands. Against the assigned
parent, a representative `6 L` state is command-exact, and a `0.8 L` state
with the same geometry and closing speed but wrong-sign relative crossflow is
also command-exact. For a sampled-like productive-crossflow state at `0.8 L`,
the command changes from `(-0.0893,-0.4285)` to
`(-0.0317,-0.3174) rad/T^2`, far inside the declared acceleration limit and in
the predicted bend-relief direction. This establishes gate sign,
noninterference, and boundedness only, not coupled-flow performance.
