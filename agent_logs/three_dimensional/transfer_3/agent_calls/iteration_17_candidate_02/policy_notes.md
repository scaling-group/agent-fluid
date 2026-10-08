# Reproduced intercept-corridor terminal-release candidate

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and capture from
  `12.327720 L` at `25.118523 T` after 268 storage-window shifts.
- The two byte-identical intercept-corridor policies are the strongest finite
  examples and reproduce exactly across independent evaluations: score
  `-0.5280772274`, mean distance `2.4290872138 L`, and final distance
  `0.7461352944 L`. The assigned-parent log reports the earlier v28
  course-angle release at `-0.5281032175`, `2.4291077322 L`, and
  `0.7461626530 L`, so predicted cross-track miss is the surviving semantic
  improvement rather than another increase in release magnitude.
- The force-vetoed intercept refinement is the most informative current failed
  mechanism: it preserves the capture step but regresses slightly to score
  `-0.5280778498`, mean distance `2.4290877051 L`, and final distance
  `0.7461359501 L`. The prefilled force-vetoed course policy is worse again at
  `-0.5280861775`, `2.4290942804 L`, and `0.7461447120 L`. Instantaneous
  target-opposing lateral force therefore does not earn control authority or a
  veto over the validated geometric response in this direct-still-water pass.
- I inspected the complete combined keyframe sheets for all four samples,
  including both the top-down vorticity and oblique body/Lambda2 rows. They are
  visually coincident at sheet resolution: the fish self-propels along the
  same compact target-directed arc, sheds an organized alternating planar wake
  and finite 3D vortex packets, then enters a quiet held-bend glide before
  capture. There is no passive advection, collision, late loop, boundary-exit
  precursor, out-of-plane excursion, or numerical instability. Thus the force
  veto's failure is a subtle terminal response-allocation regression, not a
  wake-collapse failure.
- Telemetry supports preserving the intercept policy. Below `1.6 L` its action
  maxima are only `0.09772/0.24610 rad/T^2`, peak force norm is `0.002193`,
  peak moment magnitude is `0.0005650`, and posterior angle remains below
  `0.2172 rad`. The force-vetoed intercept changes none of the outer clipped
  carrier history or joint extrema and does not improve the terminal result.
  The inherited shared-mean-unloading regression (`-0.5295583`) is an
  additional boundary: lower command alone is not evidence for unloading the
  common terminal bend.

## Policy hypothesis

Replace the prefilled adverse-force-vetoed course policy with the twice
reproduced intercept-corridor policy as the single candidate. Preserve its
state-feedback oscillator, posterior lag, target-angle redirect, closure
preview, two-joint mean-curvature equilibrium, helpful-crossflow response
gate, command limits, and all outer commands. During only the existing late,
closing, settled response regime, use normalized body-frame target and velocity
vectors to estimate constant-velocity cross-track miss; a miss within the
declared corridor earns at most the inherited `3.5%` paired release toward the
same mean-centered carrier.

This is a measured-response approach-hold mechanism, not a clock, route,
beat-side selector, joint-role split, force cancellation, or scalar-only gain
tuning. The next evaluation should reproduce the sampled capture, score, and
two-view wake. Falsify the promotion if it changes the outer path, delays or
loses capture, worsens mean/final distance or predicted miss, introduces a late
loop, restores terminal oscillation or joint-stop dwell, raises loads, becomes
unstable, or degrades either wake view.

bookshelf_consulted: true
source_domain: biological burst-response release and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: release corrective rhythmic allocation only after measured target-relative translation demonstrates a viable intercept while retaining the propulsive rhythm
transferable_invariant: preserve a proven traveling-bend scaffold and continuously reduce corrective allocation only under bounded normalized geometric response
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, duty ratios, clock or vortex phase, capture radius, and task-specific routes
policy_translation: normalized body-frame target and velocity vectors form a bounded predicted-miss gate for the inherited small coupled terminal release while proximity, closure, helpful crossflow, and settled two-joint response remain mandatory
falsification: reject on non-reproduction, outer-path change, delayed or lost capture, worse miss or distance, changed mean bend or phase, renewed terminal oscillation or joint stops, load growth, instability, or wake loss

The current candidate's CFD evaluation occurs only after this worker exits and
is not claimed as evidence here.

## Non-CFD implementation audit

- The candidate is byte-identical to both independently evaluated intercept
  samples (LF SHA-256
  `67cf1fcf45dd9c17c96011b6f030a17951e1b05456054974dd2ecc577c1b3bca`).
- The required guidance semantic-difference check passes after removal of a
  duplicate assigned-parent marker in the rendered workspace README.
- The lightweight Julia contract returns two finite accelerations. The
  deterministic schema audit finds all 77 direct `params.FIELD` references in
  the 78-field parameter object; the unreferenced field is the version label.
- The solver boundary check passes, confirming that only
  `candidate_target_policy.jl` differs inside the downstream solver tree. No
  formal CFD was run in this workspace.
