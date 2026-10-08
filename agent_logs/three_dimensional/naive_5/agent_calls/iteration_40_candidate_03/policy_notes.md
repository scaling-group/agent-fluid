# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the frozen contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, and inertial moving-window transport. All capture without angle,
  rate, or applied-acceleration contact. Three samples
  (`solver_b3cc38ade37a`, `solver_7e2b89182e53`, and
  `solver_071e142a4dfe`) byte-match the prefilled policy and combined visual
  sheet. They reproduce `0.748598L` capture at `25.5090T`, mean distance
  `2.457773L`, and distances `10.308/8.172/5.898/1.475L` at
  `8/12/16/24T`. This is deterministic fixed-pose evidence, not trajectory
  diversity or held-out robustness.
- I inspected the replicated parent and `solver_edce799cc5f9` combined sheets
  from release through capture in both the top-down mid-plane vorticity/body
  row and the oblique body/Lambda2 row. The fish self-propels from rest, sheds
  an orderly alternating wake, retains compact three-dimensional vortices,
  and follows a smooth shallow target-side hook. Neither comparison shows
  passive advection, wake breakup, a boundary precursor, numerical
  instability, or moving-window-induced rotation. The `edce799cc5f9` middle
  posterior-reaction variant is the informative mechanism failure: it captures
  `0.1595T` earlier and changes mean distance by only `0.000866L`, but both
  visual rows and the `8/12/16T` distances are unchanged and the crossing
  depth changes by only `0.000013L`. That is a finite tie inside the same route
  family, not a new useful trajectory.
- The replicated parent is viable but its upstream translational course is
  still poor: normalized course error is about `0.645/0.736/0.683` and
  projected miss about `6.65/6.01/4.03L` at `8/12/16T`. Its peak joint angle,
  rate, and requested acceleration are `0.77093 rad`, `4.51769 rad/T`, and
  `29.86795 rad/T^2`; peak planar force/yaw moment is
  `0.02063/0.01065`. Thus the coherent carrier and downstream viability guards
  should remain, while another middle threshold, terminal pulse, scalar duty
  increase, or global propulsion increase is unsupported.
- A phase audit of the parent trace supplies a distinct upstream hypothesis.
  From `2--18T`, rows with posterior velocity directed toward the body-frame
  course request have mean request-aligned course rotation about
  `+1.747 rad/T` and target-normal force `+0.00507`; rows moving away have
  about `-1.510 rad/T` and `-0.00465`. These are correlations, not proof of
  causality, but they separate a measured posterior sweep phase without using
  instantaneous force as route authority. Inherited logs also show that adding
  a weaker opposite-bend posterior residence bias slowed capture from
  `25.509T` to `25.608T` and worsened every progress checkpoint without visual
  separation. A useful test must therefore boost only the already favorable
  sweep, not propagate the anterior duty bias across both tail half-cycles.

## One-candidate policy hypothesis

Preserve the prefilled state-feedback oscillator, anterior course-duty
mechanism, damped posterior traveling-wave lag, course/miss redirect,
target-line response, bounded middle and capture residuals, coordinated soft
acceleration envelope, and angle/rate viability guards. Add one upstream
posterior sweep-phase primitive: when translation is observable and closing,
course error materially exceeds body aim, the target is outside the existing
middle handoff, and the redirect is released, use the sign of
`course_side * phi_dot[2]` to engage a smooth gate only while joint 2 is
already sweeping toward the requested side. A small same-direction posterior
acceleration then concentrates effort in the empirically favorable stroke;
the opposite stroke and the posterior equilibrium target remain unchanged.

The falsifiable expectation is a visibly different upstream centerline and a
lower course error or projected miss by `8/12/16T`, while retaining capture,
the coherent wake in both views, zero actuator contacts, and approximately the
parent's `0.02063/0.01065` load regime. Reject the mechanism if the early route
does not separate, if it merely increases tail speed or loads, if the
posterior wave loses lag/coherence, if any hard-limit contact appears, or if
capture/progress regresses. Formal CFD occurs only after handoff, so this
worker cannot claim that outcome.

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG asymmetric flapping and classical reactive tail propulsion
source_mechanism: concentrate bounded actuation in one observed propulsive half-cycle while preserving the traveling-wave carrier
transferable_invariant: persistent body-frame route error may select a measured posterior sweep phase for asymmetric effort without prescribing a clock phase or changing the opposite half-cycle
nontransferable_details: published gains, dimensional frequencies, robot linkage geometry, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: normalized target/course geometry owns turn side and engagement; the reflection-equivariant product of that side with posterior joint velocity gates one bounded same-direction acceleration during the upstream targetward sweep
falsification: reject on unchanged 8--16T course response, mere speed or load growth, lost or slower capture, incoherent wake, posterior lag collapse, or any actuator contact
```

## Non-CFD audit after the policy edit

- All 67 direct `params.FIELD` references are owned by the object returned by
  `target_policy_params()`, including the two new sweep-phase parameters. The
  prescribed public-contract state returns two finite accelerations.
- A deterministic 60,000-state audit spanning both lateral reflections,
  far/middle/near target geometry, zero and nonzero translation, negative and
  positive closing response, beyond-limit joint angles and rates, and varied
  loads remains finite and within the `30 rad/T^2` policy envelope. Paired
  reflection command error is exactly zero.
- Re-evaluating the parent and candidate on all 4,638 reconstructed parent
  trace states changes 497 post-guard command pairs, 313 by more than
  `0.05 rad/T^2`, with maximum separation `0.75740 rad/T^2`. Activation is
  confined to `0.429--16.775T` and `12.340--5.454L`; all states at or inside
  the established `4.5L` middle handoff pass through exactly. The candidate's
  peak frozen-state command remains `29.86795 rad/T^2`. This establishes a
  material bounded upstream mechanism test, not CFD evidence of improvement.
- The required check runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable on this ChatGPT account. Its three prescribed commands were run
  separately as the inherited fallback: the material-guidance check, exact
  lightweight Julia contract check, and solver editable-boundary check all
  pass. The guidance checker initially found the assigned parent marked twice
  in the rendered workspace `README.md`; removing only the duplicate marker
  restored an unambiguous parent. No formal CFD was run.
