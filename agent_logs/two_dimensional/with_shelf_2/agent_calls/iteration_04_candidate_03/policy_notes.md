# Multi-wake policy candidate notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the common held fish near the upper-right
  release boundary while four developed, interacting vortex streets occupy the
  target corridor. Candidate differences therefore begin at release, not in
  wake development.
- The prefilled mean-curvature controller (`solver_c047d8bd6501`) visibly
  pitches into a tight bend immediately after release and terminates as
  `unstable_dynamics` after only `9.37` units. Its `1.212` RMS relative
  crossflow, `23111` force RMS, `397906` moment RMS, and hard acceleration and
  velocity caps confirm that the two-frame failure is a load instability, not
  useful target-directed propulsion.
- The strongest finite sampled trajectory (`solver_a84fba8bf04f`) preserves a
  traveling wake and self-propels diagonally upstream into the multi-wake
  corridor. It reaches `1.646L` from the target, but the keyframes show it pass
  below the capture circle, turn steeply downward, and leave the lower boundary
  after `75.09` units with `-13.23L` lateral head displacement. Both joint
  velocities reach the cap; force/moment RMS are `487/4680`.
- The same joint-shared half-cycle controller without heading-response lead
  (`solver_928f830d4c45`) survives longer (`91.24`) and has lower but still
  large `314/3430` force/moment RMS, yet approaches only to `4.62L` and ends
  with essentially the same `-13.31L` lateral escape. Thus response damping
  changes the useful approach, but sharing one acceleration asymmetry across
  both joints does not arrest the terminal turn.
- A posterior-wave half-cycle modulation alone (`solver_785c44ad57e0`) is not
  the answer: it reaches only `8.20L`, advances just `-4.56L` upstream, hits the
  joint velocity and acceleration caps, and again exits after about `-13.29L`
  lateral displacement. Later candidates should not merely move or amplify
  the same duty asymmetry.

## Candidate hypothesis

Preserve the evaluated, zero-centered anterior oscillator and its bounded
half-cycle propulsion/turn scaffold, because it recovers upstream travel that
the recentered prefill loses. Replace the matching posterior acceleration
asymmetry with a separately actuated total-tail tangent bias. Compute that bias
from body-frame bearing plus a clamped bearing-rate lead so steering releases
when target-relative geometry is already correcting and strengthens when wake
motion reverses it. This remains a state-feedback law; it uses neither route,
coordinates, elapsed time, nor externally prescribed wake phase.

Expected evidence is retained negative-x displacement together with a smaller
negative-y excursion, closer target passage or success, and lower force/moment
load than the joint-shared response-damped variant. Falsify the mechanism if
upstream propulsion collapses, the lower-boundary topology remains, or the
posterior bias returns the joints and loads to persistent caps.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish turning and tail-beat bias
source_mechanism: separate a propulsive rhythm from a bounded tail steering offset and release the offset with measured directional response
transferable_invariant: retain a traveling propulsive bend while a target-error signal biases posterior curvature without recentering the anterior oscillator
nontransferable_details: published gains, dimensional beat frequency, robot geometry, clock-driven CPG phase, exact vortex phase, and task-specific routes
policy_translation: use clamped body-frame bearing and bearing rate to bias the observed-state posterior total-tail target while preserving the bounded anterior half-cycle scaffold
falsification: reject if upstream displacement is lost, lateral escape is not reduced, closest approach does not improve, or joint and hydrodynamic loads remain cap dominated
