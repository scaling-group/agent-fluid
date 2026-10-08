# Candidate wake-policy notes

## Visual and numerical diagnosis before the edit

- All four sampled rollouts satisfy the released direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, capture
  termination, and no reported instability. The complete
  `solver_1a1f00e33399` combined sheet shows active self-propulsion rather than
  advection: an alternating red/blue mid-plane street grows from rest, the
  top-down path closes continuously, and discrete oblique Lambda2 structures
  persist through `24.3375T` capture. The inherited closing-deficit boost has
  the same top-down wake and path at sheet resolution, but its oblique row is
  blank and cannot independently support a three-dimensional wake claim.
- `solver_1a1f00e33399`, `solver_a7973a9fe513`, and
  `solver_d1547c83d2d0` are exact replications of the unmodified reactive-rudder
  policy: each reaches `0.749625L` at `24.337509T`, has mean distance
  `2.224316L`, scores `-0.325566`, and uses 4,425 steps. This establishes a
  deterministic fixed-pose baseline, not held-out robustness.
- The inherited `solver_666b72f43d6a` closing-deficit rudder boost and sampled
  `solver_392ed1eddf30` relief form a matched response-allocation comparison.
  Adding up to 20% tail rudder below `0.35L/T` delayed capture to `24.414513T`,
  worsened mean distance to `2.224632L`, and raised mean action norm inside
  `1.5L` from `42.948` to `43.707`. Removing up to 20% under the same observed
  deficit instead advances capture to `24.326511T`, improves mean distance to
  `2.224097L`, and lowers the terminal mean action norm slightly to `42.934`.
  Its peak normalized planar force/yaw moment remain exactly
  `0.031649/0.016385`, and anterior/posterior rate-cap occupancy remains
  `14.04/6.92%`, so the improvement is a small steering-allocation effect, not
  a higher-load or saturation trade.

## One candidate hypothesis

Promote the sampled response-scheduled relief as the single candidate. Preserve
the repeatable joint-state traveling carrier, slip-aware anterior center,
full-angle half-cycle redistribution, and distance/error-gated posterior
reactive rudder. When one-step normalized closing speed falls from `0.35L/T`
toward `0.10L/T`, smoothly release at most 20% of only the posterior steering
offset; do not suppress the carrier. This is a distinct feedback allocation
mechanism supported by opposite-direction finite differences, not a proposal
to tune the carrier or rudder magnitude.

The candidate is falsified if it does not reproduce capture near `24.3265T`
and `0.749329L`, if mean distance fails to remain below `2.224316L`, or if its
top-down route, coherent complete oblique wake, rate-cap occupancy, or
force/moment envelope materially worsens. The improvement is only two control
steps and the signal is one-step closing speed, so it must not be generalized
as robust terminal damping; later work should prefer a smoother response
observable and evaluate pose or hydrodynamic perturbations.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal capture scheduling
source_mechanism: preserve a rhythmic propulsive carrier while measured approach response continuously releases an over-commanded steering channel near the target
transferable_invariant: separate propulsion from steering allocation and reduce only the steering offset when observed terminal response shows excess lateral loading
nontransferable_details: published CPG gains, linkage geometry, species-specific kinematics, dimensional frequencies, exact vortex phases, prescribed maneuver timing, and task-specific routes
policy_translation: joint state retains carrier phase; normalized body-frame target geometry retains rudder sign; normalized closing deficit smoothly removes at most 20% of the posterior mean offset without scaling the traveling carrier
falsification: reject if the sampled earlier capture and lower mean distance are not reproduced or if wake coherence, saturation, effort, force, or yaw-moment envelopes worsen
