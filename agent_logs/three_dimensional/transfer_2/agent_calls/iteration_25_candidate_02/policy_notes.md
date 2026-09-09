# Phase-preserving carrier-energy governor candidate

## Evidence read before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, stable finite
  moving-window transport, and `capture` termination. There is no sampled
  non-capture in this batch, so the required contrast uses the strongest
  finite capture and the weakest, most trajectory-informative capture rather
  than inventing a failure class.
- Both rows of the combined keyframe sheets were inspected, with the strongest
  rate-governed sample `solver_435f3fac7d39` compared against the weakest
  response-released sample `solver_e26b4eb5ad01` and cross-checked against the
  assigned parent `solver_2dfe05597921`. Their top-down rows show propulsion
  from blank quiescent water, an organized alternating wake, continuous
  target-directed translation, and the same late hook into capture. Their
  oblique rows show compact three-dimensional Lambda2 structures shed behind
  the caudal region, without passive advection, wake collapse, collision, or
  instability. The visible topology therefore supports preserving the
  traveling-wave and route/capture scaffold.
- The sampled per-joint whole-command rate governor creates a useful new
  trajectory: it captures at `18.755T` with distance integral `2.04031L`,
  versus `19.162T/2.06924L` for the strongest unguarded response-aware sample
  and `19.3545T/2.07892L` for the assigned distance-only parent. Its `10/8/6L`
  milestones are also earlier at `6.760/9.416/11.979T` versus
  `6.897/9.658/12.210T` for the strongest unguarded response-aware sample.
- That governor only partly validates its stated actuator mechanism. It cuts
  sampled outward action-velocity impulse above 99% of the rate bound from
  `12742/5589` to `5666/2041` in the anterior/posterior joints and reduces
  posterior greater-than-99%-rate residence from `4.36%` to `3.28%`, but
  anterior residence changes only from `8.35%` to `8.07%`. More importantly,
  independent attenuation of each complete joint command lengthens head path
  from `12.309L` to `12.421L` and raises peak planar force/yaw moment from
  `0.02537/0.01356` to `0.02686/0.01397`. This exceeds the inherited repeat
  envelope and contradicts the original short-path/load falsification even
  though timing and integral improve.
- The inherited optimizer notes explain the likely architectural mismatch:
  the intended test was a common carrier governor that preserved the
  two-joint wave and steering, while the evaluated implementation attenuated
  each complete raw command independently. The present candidate tests the
  intended separation rather than retuning the successful scalar threshold.

## One-candidate architecture and falsification

Start from the evaluated response-aware far-amplitude/near-lag capture
scaffold. Decompose each exact raw acceleration into a zero-mean rhythmic
carrier and a steering residual. Form one normalized carrier-power signal from
the dot product of the two carrier accelerations with their measured joint
velocities. When the maximum normalized joint rate approaches its owned hard
envelope and total carrier power is positive, smoothly attenuate both carrier
accelerations by the same bounded factor. Add the steering residuals back
unchanged, so body-frame route response, mean curvature, approach relief, and
reversal authority are not independently clipped and the posterior/anterior
carrier relationship remains intact. Below the inherited rate threshold or
when carrier power is non-positive, the candidate is algebraically identical
to the supported response-aware controller.

Expected signature: retain the rate-governed sample's earlier milestones,
capture-time and distance-integral improvement while recovering the unguarded
response-aware `12.30--12.31L` short-path and approximately
`0.0254/0.0136` load class; also retain its lower outward impulse and posterior
rate residence, zero angle-limit residence, and coherent two-view wake.
Falsify the mechanism if timing/integral return to the inherited repeat band,
the longer hook or elevated loads persist, rate-bound outward impulse returns,
capture or wake coherence is lost, or command/rate/angle residence worsens.
Do not respond by tuning only the rate threshold; restore the unguarded
response-aware scaffold or test a different observation-conditioned mechanism.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation with sensor feedback and classical phase-related traveling-wave propulsion
source_mechanism: modulate a coupled rhythmic command from measured actuator response while retaining the locomotor wave and independent directional feedback
transferable_invariant: withdraw positive rhythmic energy with one bounded state-feedback scale near a normalized actuator boundary, while preserving the carrier relationship and target-conditioned steering residual
nontransferable_details: published CPG gains, clock phase, dimensional cadence, robot motor models, species-specific envelopes, full-body kinematics, exact vortex phase, world coordinates, and task-specific routes
policy_translation: decompose the exact two-joint commands into traveling carrier and body-frame steering residuals, derive one smooth gate from normalized maximum joint rate and carrier action-velocity power, scale both carriers together, and restore both steering residuals unchanged
falsification: reject unless the earlier timing and integral coexist with recovered short path and load class, lower rate-bound outward impulse, preserved joint margin, capture, and coherent top-down and oblique wakes

## Post-edit non-CFD validation

- The required guidance checker passes after removing one duplicated
  `copied to guidance/` marker for the same assigned parent in the rendered
  workspace `README.md`; the evidence-backed guidance revision is material.
- The solver editable-boundary checker passes. No solver file other than
  `candidate_target_policy.jl` differs from the frozen baseline, and no sibling
  candidate was created.
- Static comparison finds a returned field for every direct `params.FIELD`
  reference. A delimiter/string audit also passes, and the policy contains no
  time, step, random-number, or file-I/O calls.
- The Julia executable is absent from this worker environment, so the required
  check-runner could not execute its lightweight finite-action runtime
  contract. No CFD was run; only the later evaluator can test the closed-loop
  trajectory and the stated falsification.
