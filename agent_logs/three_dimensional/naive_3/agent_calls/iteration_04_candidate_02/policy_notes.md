# Wake-policy candidate notes

## Evidence diagnosis before editing

- All four sampled evaluations are valid direct-uniform still-water rollouts
  (`U_infinity=0`, no prewarm). Their top-down vorticity and oblique Lambda2
  sheets show self-propulsion with a coherent alternating wake; none is passive
  advection or a flow-initialization artifact.
- The prefilled bearing-gated curvature policy is the strongest sampled finite
  trajectory: it reduced distance from `12.3277L` to `2.4431L`, survived to
  `31.097T`, and then left through the lower boundary. At closest approach
  (`17.869T`) it was still translating at about `(-0.628,-0.272) U`; the
  target was already strongly lateral in the body frame. The visual sheets
  show the powered wake continuing through the miss rather than a propulsion
  collapse.
- Its anterior acceleration was clamped at the candidate's `28 rad/T^2`
  reserve for about `74.6%` of samples, while either joint rate occupied the
  `260 deg/T` hard limit for about `17.9%`. Candidate command effort therefore
  leaves little phase authority for late steering.
- Full target-direction gating retained nearly the same lower-exit topology
  (`2.4939L` minimum), so repairing the acute-bearing fold alone was
  insufficient. Distance-only approach-energy relief worsened the minimum to
  `2.8455L`, and a toward-bend half-cycle acceleration boost increased clamp
  residence and worsened it to `3.5871L`. Those results argue against stronger
  static curvature, extra acceleration on the saturated useful half-cycle, or
  drive relief triggered by distance alone.
- Inherited optimizer evidence agrees that restrained 7-degree anterior mean
  curvature and posterior gating are the useful scaffold, while stronger
  bends can destroy propulsion. It specifically leaves a phase-shaped release
  or brake as the untested control capability for this coherent powered miss.

## Policy hypothesis

Preserve the 7-degree target-relative mean bend and lagged posterior carrier.
Use full body-frame target direction only to blend the anterior dynamics from
the propulsive state-feedback oscillator into a damped set-point tracker of
that same mean bend during gross misalignment; attenuate the posterior wave by
the same alignment measure. Alignment continuously restores the traveling
wave, so there is no clock, stage counter, route, or coordinate dependence.
This is intended to shed oscillatory momentum and clamp residence during the
late redirect without weakening the well-aligned early approach.

Falsify the mechanism if evaluation loses the coherent early wake, produces a
wrong-sign or tight initial turn, fails to reduce anterior clamp/rate-limit
residence, or retains the same approximately `2.4--2.5L` lower-boundary miss.
A closer approach with delayed or changed termination is necessary but not
sufficient; the target criterion remains capture within `0.75L`.

```text
bookshelf_consulted: true
source_domain: biological C-start redirects and sensor-modulated robotic-fish CPG control
source_mechanism: large observed direction error gates rhythmic propulsion into a bounded redirect and releases back to a traveling beat after heading response
transferable_invariant: separate gross reorientation from aligned propulsion using continuous geometry feedback while preserving posterior lag
nontransferable_details: species-specific C-bend amplitudes, published oscillator gains, prescribed timing, exact phases, and task-specific routes
policy_translation: blend the joint-state oscillator into a damped tracker of the bounded body-frame target curvature as full target-direction error grows, and restore both joint waves on alignment
falsification: reject if early propulsion collapses, turn sign is wrong, clamp residence does not fall, or closest approach and lower-exit topology do not improve
```

## Dry validation

The mandated guidance, lightweight Julia contract/schema, and repository
boundary checks pass. A counterfactual action replay on the completed `2.4431L`
trajectory (not a CFD rollout and not outcome evidence) reduced anterior-command
clamp incidence from `74.46%` for the parent law to `66.75%` for this law and
reduced mean absolute anterior command from `24.45` to `23.41 rad/T^2`.
Reflection-paired synthetic states produced exactly sign-reflected joint
commands. These checks confirm that the intended mechanism is active and
contract-compatible; only the later formal CFD evaluation can accept or reject
the trajectory hypothesis.
