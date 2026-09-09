# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled rollouts and both completed assigned-parent rollouts satisfy
  the Phase 2 evidence contract: direct uniform still-water initialization
  with `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics, and
  `left_domain` termination. I inspected the combined sheets from release to
  termination for the strongest sampled phase-lag policy (`2.326L` minimum),
  the weaker sampled differential S-bend (`2.469L`), and the parent's two
  later failures (`2.738L` and `2.457L`). In both the top-down mid-plane
  vorticity rows and the oblique body/Lambda2 rows, the fish self-propel along
  nearly the same diagonal inbound path, shed a long alternating planar wake
  with compact coherent three-dimensional structures, pass outside the
  `0.75L` target, and remain powered on a steep lower-boundary exit around
  `31T`. There is no ambient advection, wake collapse, collision, or numerical
  instability to repair.
- The sampled fixed-proximity phase-lag policy remains the strongest scaffold:
  minimum/mean distance is `2.326/8.424L`, versus `2.385/8.436L` for the
  response-selected brake, `2.433/8.434L` for anterior duty asymmetry, and
  `2.469/8.439L` for an inbound differential equilibrium S-bend. At its
  minimum near `17.91T`, speed is still `0.687U`; anterior/posterior command
  clamp residence is about `0.749/0.355`. The visible wake and these metrics
  identify a powered lateral overshoot, not weak propulsion.
- Completed inherited evidence closes the phase/amplitude branch. Attenuating
  the presumed harmful posterior half-cycle regressed to `2.738/8.473L`, and
  preserving amplitude while rectifying the lag modulation into a one-sided
  phase reset regressed to `2.457/8.436L`; both retained the coherent wake and
  lower exit. Thus neither another scalar gate nor another phase-half-cycle
  edit is evidence-backed.
- Replay of body-frame target geometry on the `2.326L` trace exposes an
  untested semantic boundary. At the minimum the target remains ahead-side
  (`target_forward=0.212`), but by `18.65T` it crosses behind-side and by
  `18.69T` is clearly behind (`target_forward=-0.107`) while distance has
  increased only to `2.370L`. The acute bearing used by cruise folds ahead and
  behind together, so all sampled policies continue their powered carrier
  rather than forming a recovery turn. Prior target-behind differential and
  damping actions failed; a same-sign two-joint nonsteady C-turn with
  geometry-based release has not been tested.

## Policy hypothesis

Preserve the complete sampled `2.326L` cruise/approach scaffold, including its
state-feedback oscillator, acute-bearing mean curvature, alignment envelope,
response-selected posterior brake, fixed-proximity phase modulation, and
command reserve. Add one continuous recovery mode selected only by the full
body-frame target direction. When the normalized forward projection of the
target becomes negative, blend toward a stronger opposite-sign same-curvature
bend at both joints and contract, but do not eliminate, the traveling-wave
carrier. This translates a C-start/burst redirect into memoryless state
feedback: the fish continues generating hydrodynamic authority while curved,
and the selector releases automatically as body rotation brings the target
ahead again. The action is effectively absent on the evidenced release and at
the first-pass minimum, so it tests a return-leg topology rather than retuning
the already useful inbound trajectory.

Support requires the coherent inbound wake plus a target-return leg, capture,
a new useful termination class, or materially better mean/final distance
without worse limit/load residence. Reject the mechanism if it changes the
far-field release, produces a tight curl or stalled static bend, increases
actuator/load residence materially, or retains the same powered lower exit
without a return leg. Formal coupled CFD runs only after this worker exits.

```text
bookshelf_consulted: true
source_domain: biological C-start turning and sensor-modulated robotic-fish CPG control
source_mechanism: large observed directional error selects a bounded whole-body curvature transient, then measured geometric response releases back into a propulsive rhythm
transferable_invariant: use target-relative geometry to switch from productive cruise into a strong bounded two-joint redirect and release when the target returns ahead
nontransferable_details: species-specific C-start stages, published gains, dimensional beat frequencies, robot duty ratios, prescribed waveforms, exact vortex phases, capture radius, and task-specific routes
policy_translation: normalized body-frame target forward/lateral projections select a reflection-equivariant same-sign joint-curvature blend and carrier contraction under the two-joint acceleration contract
falsification: reject if release or first-pass approach changes, the fish stalls or curls tightly, limit/load residence rises, or no return leg or useful termination change appears
```

## Evaluation boundary

The candidate has no same-worker CFD evidence. After the edit, trace replay and
dry controller probes may establish only selector locality, reflection
equivariance, finite outputs, schema ownership, and command bounds.

## Implemented candidate and non-CFD probes

The candidate adds six owned recovery parameters to the sampled phase-lag
controller. Its selector uses only normalized body-frame target projections;
it blends the anterior and posterior equilibria toward the same bounded
opposite-sign curvature and contracts the carrier to a nonzero floor. There is
no clock, stage counter, mutable state, world coordinate, route, flow-file
access, or command boost.

Counterfactual selector replay on the completed `2.326L` trace gives zero
displayable activation during the first `2T`. At the sampled minimum the
redirect weight is only `0.000414`, and direct controller replay changes the
two accelerations by just `-0.023/-0.030 rad/T^2`. The selector first exceeds
one half at `18.694T`, distance `2.370L`, where target-forward projection is
`-0.107`, lateral projection is `0.994`, requested recovery curvature is
`-17.88 deg`, and the carrier scale is still `0.701`. At that same completed
state, the candidate changes the baseline action from `(28.0,-4.743)` to
`(9.171,-28.0) rad/T^2`, confirming a material topology switch after rather
than before the first pass. These measurements do not predict coupled-flow
dynamics or establish improvement.

All `33` direct `params.FIELD` references are owned by
`target_policy_params()`. Representative approach, behind-target recovery,
and zero states mirror to exactly negated actions within floating-point
precision; extreme finite inputs stay finite, and all actions respect the
declared `+/-28 rad/T^2` reserve. The Julia contract and solver editable-boundary
checks pass. The root guidance checker is obstructed by an immutable rendered
README that repeats the same copied parent twice; running the unchanged
checker against a temporary view that removes only that duplicate listing and
symlinks the actual notes, guidance, and parent evidence passes the intended
semantic comparison.
