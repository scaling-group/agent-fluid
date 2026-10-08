# Coupled command-direction saturation projection

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture from
  `12.327720 L` at `25.118523 T` after 268 storage-window shifts. Three
  byte-identical intercept-corridor policies reproduce the best score
  `-0.5280772274`, mean distance `2.4290872138 L`, and final distance
  `0.7461352944 L`. The force-vetoed intercept composition is slightly but
  deterministically worse at `-0.5280778498`, mean distance
  `2.4290877051 L`, and final distance `0.7461359501 L`, without changing the
  capture step.
- I inspected the complete combined sheets for a reproduced best intercept
  rollout and the force-vetoed intercept failure, including their top-down
  vorticity and oblique body/Lambda2 rows from release to termination. Both
  fish self-propel along the same compact target-directed arc, develop an
  organized alternating posterior wake and finite three-dimensional vortex
  packets, and then enter a quiet held-bend glide. Neither sheet shows passive
  advection, a collision or boundary-exit precursor, out-of-plane instability,
  a late loop, or wasteful terminal thrashing. The failed force veto is a
  subtle terminal allocation regression, not a visible wake collapse.
- The current samples expose an untested outer-allocation issue that terminal
  response refinements cannot address. In every `4,567`-state trajectory, all
  limit hits occur outside `4 L`: the anterior command is at the
  `30.543262 rad/T^2` policy limit on 1,789 of 3,567 outer states, the posterior
  command on 1,436, and only one joint is limited on 1,387 states. Independent
  component clipping therefore changes the requested two-joint command
  direction on at least those 1,387 states. Inside `4 L`, neither joint reaches
  the policy limit, so the reproduced terminal intercept mechanism does not
  need a saturation edit.
- Inherited completed evidence constrains the experiment: do not enlarge the
  `3.5%` terminal release, change shared mean curvature, split joint roles,
  choose a beat side, or stack instantaneous force onto the optional terminal
  release. Shared-mean unloading regressed to `-0.5295583`, phase-selective
  carrier scaling to `-0.5281233`, and the current force-veto composition to
  `-0.52807785`. The candidate instead tests allocation only when the outer
  carrier pair exceeds the existing hard envelope.

## Policy hypothesis

Preserve the reproduced v29 state-feedback oscillator, posterior lag,
target-angle redirect, closure preview, two-joint mean-curvature equilibrium,
helpful-crossflow response, intercept-corridor release, and every parameter.
Replace independent per-joint clipping of the outer carrier with a coupled
infinity-norm projection: form the anterior/posterior carrier pair, and when
either component exceeds the existing limit, multiply both by the same bounded
scale. Use normalized target range to fade continuously back to the parent
allocator before `4 L`. This preserves the direction and relative allocation
of a saturated outer two-joint request while satisfying exactly the same
actuator box; unsaturated pairs and every state inside the proven terminal band
are unchanged.

This is one actuator-allocation mechanism rather than a gain change. It should
be active on the evidenced outer saturation topology, preserve the traveling-
bend command relationship instead of independently truncating it, and leave
the entire stored terminal regime unchanged. Reject it if stored-state replay
shows inactivity or changes any unsaturated pair, or if later CFD delays or
loses capture, worsens mean/final distance, changes the compact target-directed
topology without useful progress, weakens closure, causes joint-stop dwell or
load growth, destabilizes the solver, or degrades the coherent wake in either
view.

bookshelf_consulted: true
source_domain: coupled-oscillator robotic-fish control and traveling-wave/reactive-thrust swimming models
source_mechanism: preserve coordinated anterior-to-posterior bend propagation when a low-dimensional rhythmic command meets actuator constraints
transferable_invariant: actuator limiting should preserve the direction and relative allocation of a proven two-joint state-feedback command whenever possible
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, full-body waveforms, exact phase lags, Strouhal targets, vortex phase, and task-specific routes
policy_translation: use normalized target range to enable a common projection of the outer two-joint carrier only when its infinity norm exceeds the existing limit, with a continuous handoff to the reproduced terminal allocator and no clock, route, new steering authority, or world-frame cue
falsification: reject if the projection is dormant, changes unsaturated or terminal commands, delays or loses capture, worsens distance or closure, creates joint-stop dwell or load growth, or degrades the planar or three-dimensional wake

The current candidate's CFD evaluation occurs only after this worker exits and
is not claimed as evidence here.

## Non-CFD implementation audit

- The candidate keeps the parent's parameter schema and introduces no new
  authority. The lightweight contract returns two finite accelerations within
  the existing `30.543262 rad/T^2` policy limit.
- Approximate stored-state replay reconstructing target/body geometry and the
  seven-state observation window from all 4,567 trace rows changes 2,319 outer
  states and zero states below `4 L`; maximum candidate-parent differences are
  about `21.26/17.48 rad/T^2`. Eleven changed transition states have an
  unsaturated parent output because the raw carrier is already limited before
  terminal blending. The candidate maximum remains exactly the inherited
  limit. These results establish that the mechanism is active, bounded, and
  terminal-noninterfering on stored states only; they do not establish a CFD
  improvement.
