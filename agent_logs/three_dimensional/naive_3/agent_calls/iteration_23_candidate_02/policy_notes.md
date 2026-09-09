# One-sided posterior phase-reset candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts are valid direct-uniform still-water evaluations:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics, and
  `left_domain` termination. Their scores and diagnostics therefore describe
  self-propulsion rather than background advection.
- I inspected both rows of the combined keyframe sheets for the strongest
  finite phase-lag sample (`solver_0620d96874f3`, minimum/mean distance
  `2.326/8.424L`) and the informative differential-equilibrium S-bend failure
  (`solver_5140ef46529a`, `2.469/8.439L`), then cross-checked the response
  brake (`2.385/8.436L`) and anterior-duty result (`2.433/8.434L`). In both
  selected sheets, the top-down row develops a long alternating vortex street
  from quiescent release and the oblique row retains compact three-dimensional
  Lambda2 structures through the approach. Neither wake collapse, collision,
  passive advection, nor instability precedes failure. The fish instead makes
  a powered lateral pass and continues down through the lower boundary near
  `31--32T`.
- The fixed-proximity phase-lag modulation is the only sampled mechanism here
  that improves both the brake's minimum (`2.385` to `2.326L`) and mean
  (`8.436` to `8.424L`) distance while retaining a coherent wake. The static
  differential S-bend and anterior duty allocation worsen closest approach
  without changing the lower-exit class, so another equilibrium bend, drive
  gain, or threshold retune is unsupported.
- Inherited completed logs close two nearby branches: earlier forming-miss
  activation regressed to `2.684/8.474L`, and notching the posterior wave
  half-cycle regressed to `2.738/8.473L`; both kept the same powered lower
  exit. The assigned parent instead isolates timing: replay of the sampled
  phase trace reports nearly balanced signed lag shifts inside `3L`, while the
  state at its best minimum selects a lag reduction from `0.8` to `0.613`.
  This motivates changing phase topology while preserving the fixed-proximity
  selector and full posterior-wave amplitude.

## Policy hypothesis

Start from the sampled `2.326L` phase-lag controller, including its oscillator,
bearing/yaw cruise curvature, alignment envelope, response-selected posterior
brake, fixed proximity/course-error gate, and command reserve. Rectify only
the signed posterior-lag modulation: normalized body-frame target-ray/course
error and measured anterior joint velocity may reduce lag on the half-cycle
present at the sampled minimum, but the opposite half-cycle remains at the
carrier lag. This is a bounded state-selected phase reset, not a static bend,
amplitude notch, earlier selector, scalar gain tune, clock phase, or route.

Support requires the coherent inbound wake plus capture, a target-return leg,
a useful new termination class, or a material closest-approach improvement
below `2.326L` without worse mean distance or actuator/load residence. Reject
the mechanism if release changes materially, wake coherence degrades, a tight
curl appears, posterior limit/load residence rises, or the same powered lower
exit remains without a material minimum-distance gain.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and classical posteriorly lagged traveling-wave swimming
source_mechanism: measured directional error and oscillator state apply a bounded phase reset while retaining a propulsive traveling wave
transferable_invariant: steer a productive rhythm by changing posterior timing on one selected half-cycle while preserving wave direction, posterior amplitude, and the opposite carrier half-cycle
nontransferable_details: published gains, clock phases, duty ratios, dimensional frequencies, species envelopes, prescribed waveforms, exact vortex phases, capture radii, and task-specific routes
policy_translation: normalized body-frame target-ray/course error and measured anterior joint velocity select a reflection-equivariant nonpositive posterior-lag shift inside the evidenced proximity envelope under the two-joint acceleration contract
falsification: reject if cruise or wake coherence changes, posterior clamp/load residence rises, a tight curl appears, or the result cannot improve on 2.326L or change the powered lower-exit class

## Evaluation boundary

The new candidate receives coupled CFD only after this worker exits. Local
replay and contract probes can establish activation, bounds, and symmetry, but
cannot establish hydrodynamic improvement.

## Implemented candidate and non-CFD verification

Relative to the completed `2.326L` phase controller, the executable change is
only `lag_shift = min(signed_lag_shift, 0)`: the distance/course selector,
carrier, brake, posterior-wave amplitude, and command reserve are unchanged.
The configured guidance-semantic check, Julia policy-contract check, and solver
editable-boundary check pass. All `27` direct parameter fields are declared;
representative zero-speed, extreme finite, and mirrored state probes remain
finite within `+/-28 rad/T^2`, with mirror residual `0.0`. These checks do not
claim a coupled-flow outcome, and no formal CFD was run.
