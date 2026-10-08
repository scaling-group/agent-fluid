# Evidence-selected v31 exploitation candidate

## Visual and quantitative diagnosis before candidate selection

- I read the workspace and guidance contracts, the assigned-parent policy and
  optimizer evidence, all four sampled policies, scores, observations,
  diagnostics, trajectories, metrics, and combined keyframe sheets. The four
  sampled policy files have the same SHA-256, and their trajectory CSVs are
  byte-identical. Each is a finite direct-uniform still-water capture with
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, no passive advection, and no
  boundary or numerical termination. They are deterministic repetitions of
  one mechanism, not four independent controller improvements.
- I inspected the top-down mid-plane vorticity row and the oblique Lambda2 row
  from release through capture for the sampled v31 leader and the informative
  closing-stride anterior-envelope regression. Both visibly self-propel from
  rest, turn toward the target, maintain a coherent alternating reverse wake
  and compact three-dimensional posterior structures, and show no standing
  reciprocal wiggle, wake collapse, collision, or out-of-plane instability.
  The failed hypothesis is therefore terminal energy allocation, not the
  existence of propulsion or the sign of route steering.
- V31 reproducibly captures at `18.0125T` with score/mean distance
  `-0.0640004/1.950346L`, observed distance integral `1.336756L`, center path
  `13.2149L`, final course alignment `0.1297`, final speed `0.8806U`, final
  absolute yaw `0.8077 rad/T`, and near anterior/posterior acceleration-ceiling
  residence `69.29/75.89%`. Its weak terminal alignment and high saturation
  remain real limitations, but its closure is the best fully evidenced
  tradeoff among the assigned and sampled candidates.
- The assigned-parent history and sampled optimizer logs close the obvious
  terminal-edit family. Common closing-stride cadence reduction, common
  amplitude or energy-envelope contraction, anterior-only rate-onset relief,
  and posterior positive-work withdrawal all preserved the coherent two-view
  wake and capture but regressed score or observed closure; the completed
  anterior-rate test reached `18.0180T`, `-0.0650022`, and `1.336802L` despite
  improving only its instantaneous final alignment/yaw to
  `0.1957/0.3716 rad/T`. Slip-duty, posterior phase reset, response-triggered
  mean-bend extension, and acceleration-headroom steering transfer likewise
  failed to improve closure and terminal state together. A better final sample
  or lower limit residence alone is not evidence of better approach control.

## Single policy hypothesis

Materialize the prefilled
`dogfish_3d_course_consensus_posterior_duty_ratio_v31` unchanged as the one
candidate. It preserves the evaluated odd normalized body-frame route map,
state-derived anterior carrier, posterior lag and emphasis, phase-consistent
posterior work reserve, bounded approach envelope, conserved mean-bend
allocation, course-consensus duty surface, half-cycle steering, and
reversal-preserving rate governor.

This is evidence-led exploitation after several distinct terminal mechanisms
failed, not a claim that repetition is a new controller mechanism. Falsify the
candidate immediately if it does not reproduce the sampled capture and metric
class. A later worker should depart from it only for an orthogonal normalized
body-frame mechanism with independently reachable authority, and should reject
that departure unless capture, observed closure, path, approach-average
alignment/yaw, wake coherence, and non-migrating actuator residence improve
together.

```text
bookshelf_consulted: true
source_domain: elongated-body reactive propulsion and sensor-modulated robotic-fish rhythmic control
source_mechanism: preserve a posterior-emphasized traveling wave when repeated scalar drive relief and steering redistribution do not improve terminal approach
transferable_invariant: retain state-derived cadence, bounded body-frame steering, posterior phase lag, and posterior propulsive authority until evidence identifies an orthogonal observation-to-actuator mechanism with nonredundant authority
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, full-body kinematics, world coordinates, target location, capture radius, and task-specific routes
policy_translation: no shelf primitive is newly adopted; keep the evaluated v31 two-joint feedback law because completed cadence, amplitude, signed-work, rate-onset, duty, phase-reset, and steering-transfer variants worsened closure or terminal state
falsification: reject v31 if it fails to reproduce the sampled capture class; reject any later transfer if it changes useful transit or fails to improve capture, observed closure, path, approach-average alignment and yaw, coherent wake structure, and non-migrating joint-limit residence together
```

