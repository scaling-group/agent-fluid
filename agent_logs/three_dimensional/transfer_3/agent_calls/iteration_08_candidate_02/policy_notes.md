# Direction-aware coordinated response-release candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen physical contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no prewarm,
  no cylinders, active moving-window transport, and finite capture from
  `12.32772 L` at about `25.11 T`.
- I inspected the combined and view-specific sheets from release to capture,
  including the top-down mid-plane vorticity row and the oblique body/Lambda2
  row. The three identical strongest rollouts show self-propulsion along one
  compact target-directed arc, a coherent alternating posterior wake, finite
  three-dimensional shed structures in the available oblique panels, and no
  collision, domain-exit precursor, or instability. The phase-selective
  comparator has the same top-down path, while most of its oblique panels are
  blank; those blanks are missing visual evidence rather than evidence of a
  missing wake. The inherited `51.645 T` approach-hold rollout remains the
  informative control failure recorded by prior workers: broad drive relief
  preserved an early wake but produced a large target orbit. No currently
  sampled rollout is a termination failure.
- The prefilled coordinated response release is reproduced exactly by three
  independent sampled evaluations: score `-0.5283387731`, capture at
  `25.11852 T`, final distance `0.746410 L`, and mean distance
  `2.429293780 L`. The phase-selective departure allocator captures one solver
  step earlier at `25.11302 T` and lowers inside-`4 L` maximum force/moment
  coefficients from about `0.01547/0.00800` to `0.01426/0.00757`, but is
  marginally worse in score (`-0.5283756345`) and mean distance
  (`2.429298361 L`). Both preserve wake coherence and avoid joint-stop dwell.
- The inherited response-partitioned combination is a concrete negative
  result: adding departure-pressure reallocation during the unsettled partial
  transition regressed to score `-0.5309900794`, mean distance
  `2.431336802 L`, and final distance `0.749287 L`. Posterior-only settled
  release also regressed to `-0.5302882262`. These results support keeping a
  coordinated two-joint release and prohibit simply stacking the sampled
  departure boost onto it.
- The remaining testable distinction is direction, not range or joint role.
  The current allocator recovers carrier whenever maximum normalized tracking
  error is small, even if the observed joint motion has just begun increasing
  that error. Conversely, the failed combination applied departure pressure
  while the bend was still unsettled. A disjoint gate can protect only a
  settled-but-departing response and be exactly inactive while the bend forms.

## Policy hypothesis

Preserve the evaluated outer carrier, body-frame target redirect, closure
preview, two-joint equilibrium, carrier floor, and all actuator limits. Within
the existing terminal gate, retain the full curvature allocation while either
joint is unsettled. Once both joints have settled enough to permit coordinated
carrier recovery, compute the positive derivative of squared equilibrium
error, `(q-q_target)*q_dot`, normalized by the declared carrier amplitude and
state-feedback frequency. Permit the existing bounded carrier recovery when
the joints return toward equilibrium, but smoothly restore curvature hold when
either settled joint moves away from it.

This is one response-direction mechanism: it does not amplify the terminal
range gate, assign different roles to the two joints, or modify the outer
trajectory. Expected evidence is the same compact wake and capture, no new
command clipping or joint-stop dwell, and a terminal load/arrival tradeoff at
least as good as the sampled symmetric and phase-selective parents. Reject it
if pre-terminal commands change, capture is delayed or lost, score/mean
distance regresses toward the failed response-partitioned result, or terminal
force and moment exceed the coordinated-release parent.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG turning and biological C-start release into rhythmic propulsion
source_mechanism: condition the handoff from a target-directed mean bend to coordinated rhythmic propulsion on the observed direction of joint response
transferable_invariant: when steering and propulsion share limited joints, separate mean curvature from the traveling carrier and recover the carrier only when normalized joint state is returning toward the requested bend
nontransferable_details: published gains, dimensional cadence, duty ratios, species-specific C-bend timing and envelope, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: use positive normalized equilibrium-error growth only to veto settled two-joint carrier recovery inside the existing closure- and body-frame-geometry-gated terminal allocator; retain full curvature allocation while unsettled and preserve the validated outer carrier
falsification: reject if outer commands or wake change, compact capture is delayed or lost, the result regresses like the prior unsettled departure stack, or terminal saturation and load spikes return

The new CFD evaluation occurs after this worker exits and is not claimed here.

## Non-CFD implementation audit

The lightweight Julia contract returns two finite commands, and the
deterministic schema scan resolves all 69 direct `params.FIELD` references in
the returned 70-field parameter object. Synthetic paired evaluation against
the sampled symmetric-release parent gives exact command equality outside the
terminal band, while the bend is unsettled, and for a settled response moving
toward equilibrium; only the settled-and-departing case changes. An approximate
replay of the inherited trajectory finds that disjoint condition active in 92
inside-`4 L` samples, so the mechanism is not a dormant predicate. This audit
establishes bounded activation and noninterference only, not a coupled-flow
improvement.
