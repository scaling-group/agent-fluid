# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- The assigned parent, all four sampled evaluations, and inherited optimizer
  logs use direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm snapshot, and finite
  dynamics. The visible translation is self-propulsion, not advection or an
  initialization artifact.
- I inspected both the top-down mid-plane-vorticity and oblique body/Lambda2
  rows for the strongest score sample (`2.443L` minimum), the clearest
  slip-phase failure (`2.822L`), and the assigned parent (`2.187L`). All keep
  long alternating mid-plane streets and compact three-dimensional wake
  structures through the approach. They remain powered after passing below
  the target and exit through the lower boundary; the limiting failure is
  terminal course control rather than wake collapse or instability.
- The assigned parent's wrong-side posterior counter-bend is a positive but
  incomplete mechanism result. Relative to the alignment-gated carrier it
  improves minimum distance from `2.443L` to `2.187L` and mean distance from
  `6.781L` to `6.683L`, with similar peak force/moment (`0.0304/0.0153`
  versus `0.0287/0.0148`) and a coherent wake. It nevertheless retains the
  lower exit, while posterior clamp residence rises from `35.4%` to `38.1%`.
  This supports retaining its sign and bounded equilibrium channel, but not
  simply increasing its gain.
- At the parent's inbound `8L` and `6L` crossings, its one-sided guard is off
  because lateral velocity already shares the target's side. Yet the
  normalized target-ray cross-velocity residual remains `0.144U` and
  `0.219U`; at `3L`, `2.5L`, and the `2.187L` closest approach it grows to
  `0.321U`, `0.648U`, and `0.659U`. Thus same-side motion is not necessarily
  target-directed motion. The prior unrestricted course-angle controller is
  not a counterexample to a terminal residual: it altered anterior curvature
  from the release, curled upward, and reached only `12.150L`.

## Policy hypothesis

Preserve the assigned parent's oscillator, mean-curvature/yaw-rate reflex,
alignment-gated posterior wave, frequency, amplitude, phase lag, command
reserve, and evidenced wrong-side posterior counter-bend. Add one compatible
terminal mechanism in the same posterior equilibrium channel: compute the
signed cross product of normalized body-frame target direction and measured
body velocity, then apply its bounded correction through a continuous
distance approach envelope. Clamp the sum to the parent's existing `7 deg`
posterior counter-bend envelope, so this changes feedback information and
when the existing authority is used rather than raising authority.

Replay on completed parent observations, without claiming a new hydrodynamic
result, adds only about `0.15/0.18/0.72 deg` at the inbound `10/8/6L`
crossings, then `0.94/4.20/5.92/6.27 deg` at `4/3/2.5L` and closest
approach. The total remains at or below `7 deg`. Expected evidence is the
parent's coherent far-field wake and early progress followed by a materially
more target-directed terminal velocity, a closest approach below `2.187L`,
and ideally capture or a different useful termination. Falsify if the release
route changes materially, wake coherence or closing degrades, posterior
limit/load residence rises sharply, a tight curl appears, or the same powered
lower exit persists without a useful trajectory improvement.

```text
bookshelf_consulted: true
source_domain: terminal capture control and sensor-modulated robotic-fish direction tracking
source_mechanism: preserve a propulsive state-feedback rhythm while measured target-relative course error modulates a bounded posterior steering channel during approach
transferable_invariant: a near-target controller can reduce velocity perpendicular to the normalized target ray without replacing the propulsive carrier or increasing its steering envelope
nontransferable_details: published gains, dimensional frequencies, robot or species kinematics, exact vortex phases, prescribed routes, approach distances, and duty ratios
policy_translation: add a distance-enveloped signed cross product of normalized target_body_L and velocity_body_U to the inherited posterior counter-bend, with their sum clamped to the existing equilibrium limit
falsification: reject on altered release, wake or progress loss, increased posterior limit/load residence, a terminal curl, failure to beat 2.187L, or an unchanged powered lower exit
```

## Implemented candidate and pre-CFD checks

The candidate implements only the terminal target-ray course residual above,
in addition to the assigned parent's retained counter-bend. Every active
quantity is owned by `target_policy_params`; the approach term and inherited
term share the prior `7 deg` posterior equilibrium limit, and the joint
acceleration clamp remains `28 rad/T^2`.

The required guidance/notes semantic check, lightweight Julia policy
contract, and solver edit-boundary check all pass. Exact reflected synthetic
states produce sign-reflected finite commands, extreme finite observations
remain inside the command clamp, and the full `324`-assertion repository test
suite passes. Formal CFD remains deferred to the evaluator.
