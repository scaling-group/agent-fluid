# Intercept-conditioned cadence-recovery candidate

## Evidence and visual diagnosis before the policy edit

- All four sampled solver rollouts satisfy the frozen Phase-2 contract:
  direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window
  dynamics, and capture from `12.327720 L` at `25.118523 T` after 268 window
  shifts. Their policies and combined keyframe sheets are byte-identical and
  reproduce score `-0.5280772274`, mean distance `2.429087214 L`, and final
  distance `0.746135294 L`. The assigned parent's separately completed result
  is identical, so the center-velocity intercept mechanism has four current
  sampled reproductions plus its inherited parent reproduction.
- I inspected the complete combined sheet for the reproduced winner and the
  inherited head-point-predictor regression, including the top-down mid-plane
  vorticity row and oblique body/Lambda2 row from release to termination. Both
  fish self-propel along the same compact target-directed arc, shed a coherent
  alternating planar wake and finite three-dimensional vortex packets, and
  enter a quiet held-bend glide before capture. Neither view shows passive
  advection, a loop, collision, boundary-exit precursor, out-of-plane
  instability, wake collapse, or terminal thrashing. The images are
  indistinguishable at sheet resolution, so the policy distinction must be
  judged from terminal telemetry.
- The inherited head-point predictor is the informative completed negative
  result. Replacing center-velocity miss with head range/line-of-sight
  kinematics preserves the capture step and outer extrema but regresses to
  score `-0.5281959396`, mean distance `2.429180928 L`, and final distance
  `0.746260285 L`. Below `1.6 L`, its mean speed falls from the reproduced
  winner's `0.649624` to `0.649603 L/T`, final speed from `0.654015` to
  `0.653932 L/T`, and final action magnitudes from about
  `0.09772/0.24610` to `0.09533/0.23936 rad/T^2`. Matching the predictor to
  the scored head point therefore does not survive coupled-flow evidence;
  lower terminal command and load are not improvements when progress worsens.
- In the reproduced winner, the center-velocity miss contracts monotonically
  from about `0.685 L` to `0.228 L` below `1.6 L`, while course error falls
  from about `0.443` to `0.310 rad`, closing speed rises from about `0.684` to
  `0.712 L/T`, and speed stays within `0.6464--0.6540 L/T`. Its terminal
  commands remain below `0.098/0.247 rad/T^2`, with no joint-stop dwell or
  saturation and force/moment maxima only about `0.002193/0.000565` in the
  normalized diagnostics. This supports retaining its geometry, equilibrium,
  and allocation release while testing propulsion at a separate actuator
  locus with a narrow authority budget.

## Policy hypothesis

Preserve the reproduced state-feedback oscillator, posterior lag,
target-angle redirect, scalar closure preview, shared two-joint
mean-curvature equilibrium, helpful-crossflow and settled-response gates,
center-velocity intercept corridor, `3.5%` coupled carrier release, and all
command limits. Add one response-conditioned cadence-recovery mechanism:
after the same normalized body-frame intercept, proximity, positive closure,
helpful crossflow, and settled two-joint response are simultaneously present,
recover at most `3%` of the gap between the redirected cadence and the nominal
cadence. The recovery is zero when cadence is already at or above nominal and
is evaluated independently from the existing allocation release, so it
cannot alter mean curvature, turn sign, beat side, or joint roles.

The stored trajectory predicts exact noninterference outside the existing
late response regime and a smooth, small cadence recovery inside it. The next
CFD evaluation should test whether retaining slightly more of the proven
traveling-bend propulsion improves mean/final distance without changing the
compact path. Falsify the mechanism if capture is delayed or lost, outer
commands change, the intercept miss or distance worsens, terminal speed does
not improve, the held-bend glide becomes oscillatory, command/load maxima
grow materially, joint stops or saturation return, instability appears, or
either wake view degrades.

bookshelf_consulted: true
source_domain: biological burst-redirect response and sensor-modulated robotic-fish CPG control
source_mechanism: preserve a traveling propulsive rhythm, apply bounded redirect under large target error, and restore rhythmic propulsion continuously only after measured target-relative response establishes a viable intercept
transferable_invariant: an established redirect can release a bounded portion of cadence relief when normalized body-frame geometry and motion show stable positive closure, without changing the mean bend or posterior lag
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, duty ratios, clock or vortex phase, exact capture radius, and task-specific routes
policy_translation: the existing normalized center-velocity miss, proximity, closure, helpful-relative-crossflow, and settled-joint gates recover a small fraction of only the below-nominal cadence gap while the two-joint equilibrium and coupled allocation release remain unchanged
falsification: reject on outer-path interference, delayed or lost capture, worse miss or distance, absent speed benefit, renewed terminal oscillation, saturation or joint stops, material load growth, instability, or wake degradation

The new candidate's CFD evaluation occurs only after this worker exits and is
not claimed as evidence here.

## Non-CFD implementation audit

- Replaying the evaluated parent's stored states through the parent and
  candidate algebra gives exactly zero command difference at and beyond
  `1.6 L`. Inside that band, cadence recovery is active on 160 of 226 states;
  the normalized cadence increment averages about `0.00413` and peaks at
  `0.01011`, leaving recovered cadence below `0.643` of nominal on this path.
- On those same fixed states, mean absolute command changes are about
  `0.00143/0.00456 rad/T^2`, maxima are about
  `0.00540/0.01722 rad/T^2`, and candidate terminal command magnitudes remain
  below about `0.105/0.267 rad/T^2`. This establishes active observation use,
  bounded authority, and exact outer noninterference only; it does not predict
  coupled-flow capture, score, speed, load, trajectory, or wake outcomes.
