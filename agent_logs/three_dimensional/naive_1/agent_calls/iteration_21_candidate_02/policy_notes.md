# Wake-policy candidate notes

## Evidence diagnosis

- All four sampled evaluations are valid direct-uniform still-water rollouts
  with `U_infinity=(0,0,0)` and all terminate in capture. The two clean
  displacement-half-cycle policies capture at `18.6505--18.6835T` with mean
  distance `2.09340--2.09405L`; the two envelope-redistribution policies
  capture at `18.8265--18.8815T` with mean distance
  `2.08855--2.08896L`. This small distance-integral separation is not a
  semantic reason to retune the propulsive carrier.
- In all four combined sheets, the top-down row shows self-propelled translation
  with a coherent alternating street directed along the approach. The oblique
  row shows compact paired caudal Lambda2 structures through release and
  approach, without a visible loss of propulsion or instability before
  capture. The views agree with monotonically successful distance progress and
  finite `18.65--18.88T` horizons.
- The assigned parent is unchanged in this workspace. Its inherited logs add a
  capture at `0.74811L` and a near-miss/left-domain result at `0.85155L` minimum
  distance and `10.33926L` final distance. The parent experience bank also
  records an executable-equivalent envelope-redistribution capture/miss pair:
  the miss reached `0.81206L`, then exited at `34.232T` and `10.67789L` as the
  target became rearward and lateral direction cosine decayed from `0.361` to
  `0.128`. Thus the reusable failure is post-miss loss of route magnitude, not
  a demonstrated defect in wake production.

## Policy hypothesis

Preserve the prefilled oscillator, posterior lag, displacement-only
half-cycle steering, response-release gate, envelope redistribution, and final
acceleration projection. Add one smooth recovery qualifier: normalized
rearward body-longitudinal target geometry multiplies the existing lateral
route input before its bounded `tanh`. It is exactly inactive while the target
is ahead, lateral geometry still owns turn sign, and the directly-astern
ambiguity remains continuous rather than receiving an arbitrary fixed turn.
The expected effect is unchanged target-ahead capture topology plus stronger
mean curvature after a miss, when lateral direction cosine would otherwise
decay. Reject the mechanism if it changes target-ahead trajectories, produces
astern sign chatter, destroys either coherent wake view, or still yields the
same near-miss/left-domain topology.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and burst redirect
source_mechanism: strengthen bounded curvature for large observed bearing error, then release as correcting response develops
transferable_invariant: route geometry may qualify mean-turn authority without replacing the rhythmic propulsive carrier
nontransferable_details: published gains, clocked CPG phases, species-specific kinematics, actuator hardware, and task routes
policy_translation: multiply normalized body-lateral target error by a smooth factor from the normalized rearward body-longitudinal component before bounded curvature; retain response release and two-joint traveling-bend feedback
falsification: reject if target-ahead capture changes, direct-astern sign chatter appears, wake coherence or actuator stability worsens, or the post-miss left exit repeats
```
