# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations and the assigned-parent evaluation report direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm. I inspected the combined sheets for the sampled
  response-selected brake (`2.385L` minimum), the informative joint-phase
  counterbend failure (`2.512L`), and the assigned parent's target-behind hold
  (`2.293L`), including the top-down vorticity and oblique body/Lambda2 views
  from release to termination. Each forms a long alternating planar wake with
  compact three-dimensional vortices, follows the same diagonal inbound path,
  passes below the target, turns nearly vertical, and remains in stable motion
  to a lower-boundary `left_domain` exit near `30--31T`. The common defect is
  terminal recovery, not advection, collision, wake collapse, or instability.
- The assigned parent's target-behind hold produces the best inherited minimum
  (`2.293L` versus `2.385L` for the brake), but worsens mean distance from
  `8.436L` to `8.487L` and retains essentially the same final distance and
  lower exit. Its selector is inactive at its minimum (`0.001` replayed weight)
  and rises after the target crosses behind the head near `18.0T`. From
  `20--22T` it reduces anterior joint-rate RMS from `2.978` to
  `0.393 rad/T` and action-norm mean from `28.234` to `4.673 rad/T^2`, yet mean
  translational speed increases from `0.640` to `0.684U` while mean yaw response
  falls from `0.207` to `0.091 rad/T`. Thus damping successfully removes the
  beat but neither arrests hydrodynamic momentum nor actively reorients the
  fish toward a target that remains behind and lateral.
- Inherited completed evidence rejects more scalar drive relief, isolated
  half-cycle effort, posterior polarity reallocation, same-sign posterior
  redirects, closure-gated anterior equilibrium bursts, and both shared and
  differential course-equilibrium bends on the powered carrier. The remaining
  distinction is a semantic one: the parent's target-behind geometry is a
  useful recovery selector, but its selected action needs active reorientation
  after the traveling wave is suppressed.

## Policy hypothesis

Start from the assigned parent's response-selected brake and preserve its
inbound oscillator, cruise mean curvature, posterior lag, alignment gate, and
command reserve exactly while the target is ahead. Replace the passive
target-behind hold with one closed-loop recovery maneuver: a smooth full
body-frame behind/lateral selector simultaneously damps the joint-state rhythm
and requests a bounded same-sign anterior/posterior C-bend. This is not another
equilibrium correction on the powered approach; it is a distinct gait-damped
reorientation regime. As rotation brings the target ahead, the same geometric
selector releases both the recovery bend and damping, restoring the unchanged
traveling-wave carrier without a clock, hidden stage, world coordinate, or
memorized route.

The maximum recovery curvature is chosen so its `8 deg` residual plus the
preserved `7 deg` cruise equilibrium and `28 deg` carrier amplitude remain at
`43 deg`, below the `45 deg` joint envelope, before any hydrodynamic benefit is
assumed. Support
requires capture, survival, or a visibly different target-return trajectory
with preserved inbound progress and wake coherence. It is falsified by the
same powered lower exit without heading recovery, a short tight curl, early
carrier suppression, greater actuator/load residence, or joint-limit contact.

```text
bookshelf_consulted: true
source_domain: biological fast-start turning and sensor-modulated robotic-fish CPG direction control
source_mechanism: a large observed directional error invokes a bounded nonsteady body bend, then geometric recovery releases back into the propulsive traveling wave
transferable_invariant: separate productive cruise from target-behind recovery, use normalized geometry to select a strong bounded reorientation while rhythmic thrust is suppressed, and restore the carrier when the target returns ahead
nontransferable_details: published gains, species-specific C-start envelopes, robot geometry, dimensional frequencies, exact vortex phases, fixed burst durations, approach radii, and task-specific routes
policy_translation: normalized body-frame longitudinal target fraction selects recovery, normalized lateral target fraction sets bend sign, both joint equilibria form a bounded C-bend while measured joint velocity is damped, and the original two-joint lagged carrier returns on geometric release
falsification: reject if inbound progress or wake coherence changes, the fish curls or contacts a joint limit, target-behind yaw does not recover, or the same lower-exit topology persists
```

## Evaluation boundary

Formal coupled CFD occurs only after this worker exits. Deterministic contract,
locality, reflection, and bound probes can validate the implementation but
cannot establish hydrodynamic improvement.

## Implemented candidate and pre-CFD checks

The candidate starts from the assigned parent's response-selected brake and
changes only the target-behind action. An ahead-target cruise probe matches the
parent action within `3e-11 rad/T^2`; a mirrored behind/lateral probe has zero
reflection residual. The new recovery is bounded by the configured
`28 rad/T^2` command reserve, and its equilibrium plus carrier envelope is
`43 deg`.

Replaying completed parent states is an off-policy actuator diagnostic, not a
coupled-flow prediction. A `10 deg` recovery residual raised replayed posterior
clamp residence to `0.550` versus the parent's observed `0.364`; `8 deg` lowers
it to `0.450` while retaining a materially different C-turn action, whereas
`6 deg` only reduces it further to `0.425`. The final candidate therefore uses
`8 deg` and keeps increased posterior residence as an explicit CFD
falsification risk. The lightweight policy contract, deterministic parameter
schema, solver boundary, reflection probe, and all `324` repository non-CFD
assertions pass. Formal CFD was not run.
