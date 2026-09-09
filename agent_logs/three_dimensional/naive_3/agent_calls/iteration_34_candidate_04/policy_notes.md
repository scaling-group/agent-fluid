# Realized-closure active-half-cycle candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts and the two completed inherited descendants used
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite dynamics, and `horizon` termination at `100T`.
  I inspected both the top-down mid-plane-vorticity and oblique body/Lambda2
  rows of their combined keyframe sheets. Every fish self-propels and retains
  an alternating curved wake with compact three-dimensional structures. The
  misses are controlled powered return loops, not advection, wake collapse,
  collision, boundary exit, or numerical instability.
- The sampled terminal course hold (`solver_6eb170b0d70a`) is the strongest
  finite scaffold despite its lower scalar score: it makes the visibly
  tightest sampled return, reaches `1.241/4.158/2.082L` minimum/mean/final
  distance, and remains active and unclipped near its minimum. The assigned
  parent's course-signed low-activity restart (`solver_2cc56ad90762`) instead
  reaches only `2.369/3.869/3.455L`; its keyframes show a broader loop and its
  joints park near a common C-bend. The inherited velocity-odd activity
  regulator improves minimum distance to `1.631L` but ends at `3.654L`, so
  another parked-state kick or two-sided scalar energy term is unsupported.
- The inherited moving, course-signed anterior half-cycle is the only new
  mechanism with a semantic terminal gain: at `1.5 rad/T^2` it reaches
  `1.228L` and increases residence inside `1.25L` from `0.473T` to `0.808T`
  while retaining an active traveling wake. Leaving that pulse on during
  recession regresses its final distance to `3.368L`. Gating it by positive
  instantaneous target-ray/course dot improves final distance to `2.484L`
  but releases too early and regresses minimum distance to `1.274L`.
- The completed traces identify why course orientation is the wrong release
  observation. At the `1.241L` scaffold minimum, course dot is `-0.121` even
  though the eight-state window still reports `+0.007 L/T` realized closure;
  at the inherited closure-gated candidate's `1.274L` minimum the corresponding
  values are `-0.099` and `+0.007 L/T`. Within `2L`, that candidate's median
  window closure is `+0.078 L/T` before the minimum and `-0.266 L/T` after it.
  Thus a tangential course is not yet a receding range response, while measured
  window closure separates the two regimes without a hidden stage variable.

## Policy hypothesis

Start from the completed `1.228L` useful-half-cycle mechanism and preserve the
course-hold scaffold's oscillator, body-frame curvature equilibria,
target-behind C-turn, course-response reserve, terminal hold, posterior brake,
joint-state lag, wave envelope, half-cycle magnitude, and command bound. Change
one semantic selector: window the existing anterior pulse with normalized
`state.window_closing_speed_L` instead of instantaneous course dot. The pulse
therefore remains available while measured head-to-target range is still
closing through a tangential course and releases continuously once the range
window is actually opening. This is response-based release, not a scalar
increase in steering or propulsion.

Support requires preservation of the coherent first recovery and active
traveling wake plus capture, a pass below `1.228L`, longer residence inside
`1.25L`, or a smaller final return without losing the `1.241L` class. Reject
if the release opens the close arc, retains the post-pass pulse and broad loop,
parks both joints in a common bend, disrupts the anterior-to-posterior wake,
or materially raises command/clamp or force/moment residence. Frozen replay
can establish selector semantics and bounds only; coupled CFD evidence becomes
available after this worker exits.

```text
bookshelf_consulted: true
source_domain: biological burst redirect and sensor-modulated robotic-fish asymmetric flapping
source_mechanism: strengthen the useful moving half-cycle of a traveling bend, then release the nonsteady action from measured task response rather than nominal course orientation or elapsed phase
transferable_invariant: terminal steering support should preserve anterior-to-posterior wave propagation and persist only while the realized target-range response remains useful
nontransferable_details: species-specific C-start stages, robot duty ratios, published gains, dimensional beat frequency, full-body kinematics, exact vortex phase, target coordinates, capture radius, and prescribed routes
policy_translation: full target-behind body-frame geometry and the existing terminal selector gate a velocity-selected anterior half-cycle; normalized finite-window closing speed smoothly releases that pulse when measured range begins opening, while the posterior joint remains under the established state-feedback lag
falsification: reject if the first recovery changes, the close arc or traveling wake is lost, actual post-pass recession does not release the pulse, clamp/load margins worsen, or closest, near-target-residence, and final-distance statistics do not jointly improve
```

## Evaluation boundary

No formal CFD will be run in this workspace. The new coupled result must not be
claimed as current evidence.

## Implemented candidate and non-CFD probes

The candidate replaces the assigned parent's failed signed low-activity restart
with the inherited bounded useful-half-cycle action and one owned response
scale. The only semantic change from the completed instantaneous-course release
is that `window_closing_speed_L` now controls pulse release. Mean curvatures,
distance gates, course reserve, oscillator, posterior target and lag, wave
envelope, half-cycle magnitude, and the `+/-28 rad/T^2` command reserve are
unchanged.

Exact Julia replay over all `18182` states of the inherited `1.274L`
closure-gated trace is finite. Relative to that policy, the candidate's
maximum-joint action difference has mean/maximum
`0.0000015/0.000532 rad/T^2` beyond `3L` and
`0.0343/0.440 rad/T^2` inside `1.5L`; both policies attain the same declared
`28 rad/T^2` clamp bound. At the trace minimum both actions are identical
because the measured anterior half-cycle selector is momentarily zero, so the
test changes neighboring moving phases rather than imposing a bend at the
minimum. A mirrored terminal probe negates both candidate actions with zero
numerical residual.

The required material-guidance/schema check, lightweight Julia contract, and
solver editable-boundary check all pass. These checks establish parameter
ownership, finiteness, boundedness, reflection equivariance, and terminal
locality only; they do not predict coupled-flow improvement.
