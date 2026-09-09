# Wake-policy candidate notes

## Evidence diagnosis before editing

- The assigned parent guidance and inherited worker logs establish that the
  naive joint-state oscillator self-propels and sheds a coherent alternating
  three-dimensional wake, but has no route control. All sampled and inherited
  rollouts used direct-uniform still water (`U_infinity=(0,0,0)`), no
  cylinders, and no prewarm snapshot.
- I inspected both the top-down vorticity and oblique Lambda2 rows for the
  strongest sampled finite rollout and the severe sampled failure. The
  posterior-heavy 14-degree curvature split has a short, weak wake, reaches
  only `12.2908L`, and exits near `9.66T`. The prefilled half-cycle controller
  retains a long wake and reaches `3.5871L`, but still crosses below the target
  and exits the lower boundary at `25.872T`.
- The strongest sample uses the restrained 7-degree, full-anterior curvature
  carrier plus bearing-gated posterior propulsion. Its long coherent wake and
  left/down route reduce distance from `12.3277L` to `2.4431L` and extend the
  episode to `31.097T`; this is a meaningful mechanism improvement over the
  `4.0671L` plain-curvature and `3.5871L` half-cycle variants. It nevertheless
  passes below the target and exits the lower boundary.
- Reconstructing body-frame target geometry from that trajectory exposes a
  semantic alias in `state.bearing`: at closest approach (`17.87T`) the target
  is still just forward with about `1.42 rad` error, but by `24T` it is behind
  with full direction error about `2.69 rad` while the acute bearing reported
  to the policy has fallen to about `0.45 rad`. The sampled policy therefore
  restores posterior wave authority after overshoot even though the fish is
  less, not more, aligned. The visible wake and continued downward speed agree
  with this diagnosis.
- The inherited large-error redirect tried increasing curvature from 7 to 12
  degrees and changing yaw-response sign. Its top-down and oblique sheets show
  a weak short wake and tight wrong-route curl; it regressed to `12.3044L`
  minimum distance and exited at `9.36T`. Stronger static bend or a
  theory-driven yaw-sign flip is therefore contradicted by completed CFD.

## Candidate hypothesis

Preserve the strongest sample's 7-degree full-anterior oscillator, posterior
lag, evidenced yaw-rate sign, and acceleration reserve. Replace only the
aliased acute-angle steering/gait signal with the full signed target direction
computed from normalized `target_body_L`, whose forward axis is negative body
x. While the target remains forward, this is identical to the existing
bearing. Once it moves behind, the direction error continues toward pi, so the
controller keeps bounded curvature and low posterior wave authority instead of
accelerating away. This is a body-frame observation correction, not a stronger
gain, world route, or hidden stage.

Expected evidence is unchanged early wake coherence and approach through the
`2.4431L` comparator neighborhood, followed by sustained redirect rather than
posterior-thrust restoration and a lower-boundary exit. Falsify the candidate
if early progress or the alternating wake weakens, the target-ahead portion of
the trajectory changes materially, the same pass-below/bottom-exit topology
persists, a tight U-turn replaces it, or joint-limit residence worsens.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction tracking and biological burst redirect
source_mechanism: persistent full directional error maintains a bounded redirect while propulsive authority is reduced, then releases back into the traveling rhythm after alignment
transferable_invariant: distinguish target-ahead alignment from target-behind overshoot using full body-frame geometry while preserving the state-feedback traveling bend
nontransferable_details: published gains, clocked CPG phase, biological C-start timing, species kinematics, exact vortex phases, and task-specific routes
policy_translation: compute signed direction with `atan(target_body_y, -target_body_x)`, use its bounded value for the existing mean-curvature reflex, and use its magnitude for posterior-wave gating
falsification: reject if early target progress or wake continuity changes, full-angle gating does not prevent posterior-thrust restoration after pass-behind, closest approach does not improve on `2.4431L`, or saturation and loads worsen
