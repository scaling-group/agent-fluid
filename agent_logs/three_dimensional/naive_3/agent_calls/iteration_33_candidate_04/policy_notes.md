# Closure-windowed active half-cycle candidate

## Evidence diagnosis before the policy edit

- All four sampled solver rollouts and the three completed inherited step-32
  rollouts satisfy the frozen Phase 2 contract: direct uniform initialization
  at `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics, and
  `horizon` termination at `100T`. I inspected the top-down mid-plane-vorticity
  and oblique body/Lambda2 rows of every combined keyframe sheet. All seven
  fish self-propel and retain coherent curved wakes through repeated loops;
  passive advection, wake collapse, collision, boundary exit, and numerical
  instability do not explain the misses.
- The completed terminal-course-hold scaffold remains the strongest sampled
  baseline: `1.241/4.157/2.082L` minimum/mean/final distance, `0.473T` inside
  `1.25L`, and the visibly tightest late return among the sampled solver
  examples. At its minimum it still travels at `0.669U`, has target-ray/course
  error `1.692 rad` and course dot `-0.121`, retains an active anterior stroke
  (`phi_dot_1=-0.260 rad/T`), and uses modest unclipped commands. Its miss is a
  powered tangential pass, not lost propulsion or exhausted authority.
- The sampled rear-selector, equilibrium-unbend, and signed low-activity
  restart descendants reach only `2.366L`, `2.215L`, and `2.369L`; all settle
  into the broad-loop, nearly stationary common-C-bend topology described by
  the assigned parent guidance. The assigned parent's inherited odd-in-velocity
  low-activity energy recovery changes that topology but still reaches only
  `1.631/3.937/3.654L` minimum/mean/final distance and never enters `1.5L`.
  This closes another parked-state restart, equilibrium release, rear-side
  selector, posterior stroke, or scalar gate/authority retune.
- The inherited `1.5 rad/T^2` active anterior half-cycle is the one partial
  positive mechanism. It reaches `1.228L`, increases residence inside `1.25L`
  from `0.473T` to `0.808T`, remains active at the minimum
  (`phi_dot=(0.135,0.289) rad/T`), and retains comparable `95%` force/moment
  magnitudes and posterior clamp residence. Its top-down and oblique sheets
  show a coherent traveling wake and a closer late arc rather than a parked
  bend. The improvement is small and does not capture; mean/final distance
  regress to `4.045/3.368L` and anterior clamp residence falls rather than
  rises (`0.222` versus `0.329`). A sibling half-cycle parameterization reaches
  only `1.702L`, so the primitive is conditionally useful rather than a scalar
  monotonic trend.
- Frozen reconstruction on the completed `1.228L` trace identifies a release
  defect. Inside `2L`, the original pulse has mean magnitude
  `0.164 rad/T^2` before the closest pass but `0.275 rad/T^2` afterward, when
  normalized closure is negative. Multiplying it by a smooth positive-closure
  selector preserves `0.138 rad/T^2` mean action on closing states but reduces
  mean action on nonclosing states to `0.009 rad/T^2` and post-minimum action
  to `0.011 rad/T^2`. At the minimum itself the measured half-cycle selector is
  already zero. This supports a response-based maneuver release, not more
  pulse magnitude.

## Policy hypothesis

Start from the completed `1.228L` active-wave half-cycle policy, preserving its
cruise oscillator, body-frame geometry selectors, C-turn equilibria,
course-response reserve, terminal hold, posterior state-feedback lag, wave
envelope, steering magnitudes, and command bound. Add one semantic selector:
apply the existing active anterior half-cycle pulse only in the window where
the target course is still positively closing but not yet aligned. Use the
sign of normalized target-ray/course dot for response release and the existing
terminal course scale for a smooth transition. Once motion becomes tangential
or receding the pulse vanishes, while the unmodified terminal course hold and
traveling-wave carrier remain; a later closing return can engage it again.

Support requires preserving the coherent first recovery and the `1.228L`
close pass while capturing, increasing residence inside `1.25L`, or improving
final/mean distance through a smaller post-pass loop with comparable
clamp/load residence. Reject if the closing arc opens, closest approach returns
above `1.241L`, the fish parks in a common bend, the wake loses its traveling
structure, action/load residence increases materially, or post-pass distance
does not improve. Frozen replay establishes selector semantics and bounds only;
the coupled CFD outcome becomes evidence after this worker exits.

```text
bookshelf_consulted: true
source_domain: biological burst redirect and sensor-modulated robotic-fish asymmetric flapping
source_mechanism: add steering energy on the useful moving half-cycle, then release the nonsteady maneuver when measured motion-to-target response ceases to close
transferable_invariant: retain the anterior-to-posterior traveling carrier while gating extra half-cycle steering by observed target response rather than elapsed phase or a held curvature
nontransferable_details: species-specific C-start stages, robot duty ratios, published gains, dimensional beat frequency, full-body kinematics, exact vortex phase, target coordinates, capture radius, and prescribed routes
policy_translation: normalized body-frame target-ray/course dot smoothly windows the evidenced anterior half-cycle pulse; measured anterior velocity selects its phase, and the unchanged posterior joint-state lag propagates the bend
falsification: reject if the close approach or active traveling wave is lost, if the release creates a parked or one-sided bend, if clamp/load margins worsen, or if near-target residence and post-pass distance do not improve
```

## Evaluation boundary

No formal CFD is run in this workspace. The candidate's coupled evaluation is
unavailable until this worker exits and must not be claimed as current
evidence.

## Implemented candidate and non-CFD probes

The candidate starts from the completed `1.228L` active-wave half-cycle
policy and adds only the proposed positive-closure response window. It changes
no oscillator setting, curvature equilibrium or magnitude, posterior target,
lag, wave envelope, brake, half-cycle magnitude, or `+/-28 rad/T^2` command
reserve. The new selector reuses the owned terminal course-dot scale; every
active propulsion and steering value remains in `target_policy_params()`.

Full frozen-state replay over all `18182` completed active-half-cycle states is
finite and within the declared command reserve. Relative to that scaffold, the
maximum-joint action difference has mean/maximum
`0.000027/0.001735 rad/T^2` beyond `3L`, but `0.133/0.782 rad/T^2` inside
`1.5L`. Inside `2L`, the difference is `0.082 rad/T^2` before the minimum and
`0.264 rad/T^2` after it, confirming that the candidate materially removes the
post-pass pulse while leaving the far carrier effectively unchanged. A
mirrored terminal state negates both actions with zero numerical residual.
These checks establish locality, response release, boundedness, and reflection
equivariance, not coupled-flow improvement.

The required semantic guidance comparison, deterministic parameter-schema
guard, lightweight Julia policy contract, and solver editable-boundary check
all pass. Shell startup emitted irrelevant missing-workspace-SSH-file warnings
during Julia probes; Julia exited successfully. No formal CFD was run.
