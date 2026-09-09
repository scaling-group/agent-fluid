# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- The assigned parent guidance, all four sampled solver evaluations, and the
  available inherited optimizer notes and scores were read before selecting a
  controller mechanism. Every sampled rollout reports direct-uniform still
  water with `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and
  finite dynamics. The moving-window shifts therefore do not explain the
  trajectory differences.
- I inspected both the top-down vorticity and oblique body/Lambda2 rows in the
  combined sheets for the strongest finite sample `solver_2e1178a92e4c` and
  the informative weaker redirect `solver_51d3a6e4c279`. Both visibly
  self-propel, shed long alternating three-dimensional wakes, approach from
  the upper right, pass below the target, rotate into a downward track, and
  remain powered until lower-boundary exit near `31T`. The stronger sample
  reaches `2.4431L` at `17.869T`; the higher-curvature closing-response
  redirect reaches only `2.7294L` at `17.859T`. This is a steering-response
  failure rather than passive advection, wake collapse, instability, or a
  missing propulsion rhythm.
- The other sampled variants preserve the same topology: full-direction
  gating reaches `2.4939L` and anterior return-half-cycle braking reaches
  `2.5009L`. Inherited completed results further reject three plausible
  repairs: posterior half-cycle asymmetry worsens closest approach to
  `3.6615L`, the assigned parent's target-versus-course controller worsens it
  to `3.2805L`, and a late response-gated C-bend reaches `2.4678L` without
  changing `left_domain` termination. Stronger static curvature, isolated
  half-cycle effort, direct course-angle substitution, and late redirects are
  therefore poor candidates for another iteration.
- The parent's instantaneous yaw release is demonstrably a tailbeat signal,
  not a slow navigation response. Before `18T`, least-squares reconstruction
  from measured joint rates gives `heading_rate ~= -0.70*phi_dot1 -
  0.188*phi_dot2` and explains `97.2--97.4%` of yaw-rate energy independently
  in all four sampled trajectories. This stable cross-policy relation is much
  stronger evidence for phase separation than interpreting raw yaw or the
  failed instantaneous velocity-course angle as mean turn response.

## Policy hypothesis

Preserve the evidenced `0.55T`, 28-degree joint-state oscillator, restrained
7-degree full-direction mean-curvature scaffold, posterior lag and alignment
gate, and `28 rad/T^2` command reserve. Replace only the raw yaw-rate release
with a joint-state-compensated residual: subtract the repeatable yaw component
predicted by the two measured joint rates, then use the bounded residual as the
turn-response release. Target direction remains normalized and body-relative;
oscillator phase remains entirely in joint state. This should keep a
persistent correct-sign pre-pass bend without raising curvature or effort,
while true residual body turning can still release the request.

The expected signature is the parent's coherent early wake and target
progress, fewer tailbeat-scale steering sign reversals, and an earlier
sustained course redirect that beats `2.4431L` or changes the lower-exit class.
Falsify the mechanism if early propulsion degrades, a tight curl replaces the
long approach, the same powered pass-below persists, joint-rate/command
residence worsens, or the compensated residual fails to distinguish mean turn
from the propulsive rhythm.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and classical target-to-curvature steering
source_mechanism: superpose a slow bounded navigation bend on a propulsive rhythm while separating rhythmic body response from persistent target error
transferable_invariant: joint-state-correlated beat-scale yaw should not release a body-frame target turn request; only residual turn response should oppose the bounded navigation bend
nontransferable_details: published CPG gains, clocked phase, robot geometry, species-specific kinematics, dimensional beat settings, exact vortex phases, and task-specific routes
policy_translation: reconstruct the evidenced rhythmic yaw component from normalized two-joint rates, subtract it from measured heading rate, and feed only the bounded residual into the existing full-direction mean-curvature carrier
falsification: reject if early wake continuity or target progress degrades, a tight curl appears, closest approach does not beat 2.4431L, the lower exit persists, or actuator-limit residence worsens
```

## Pre-CFD contract sanity

Replaying the completed sampled states through the observation transform
without advancing their dynamics leaves only `2.6--2.8%` of raw pre-pass yaw
energy in the compensated residual and reduces wrong-sign steering requests
from `23.2--23.9%` to `3.1--3.3%` across all four traces. A mirrored target,
joint state, joint rate, and heading rate produce exactly sign-mirrored finite
commands. These checks establish the intended phase separation and symmetry;
they are not evidence of a new hydrodynamic outcome.
