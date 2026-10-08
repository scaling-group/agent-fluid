# Body-alignment-confirmed coordinated carrier release

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen physical contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, active moving-window transport, and finite capture from
  `12.32772L` at about `25.11T`.
- I inspected the combined and view-specific sheets for the strongest finite
  sample (`solver_b79884a946b7`) and the distinct weaker comparator
  (`solver_6a46e49f8216`) from release through capture. The top-down rows show
  self-propulsion along the same compact target-directed arc: an organized
  alternating posterior wake persists through `20T`, then gives way to a
  smooth C-shaped approach into the capture circle. The strong sample's
  oblique row confirms finite three-dimensional Lambda2 structures through the
  outer arc and a low-wake terminal handoff, with no collision, domain-exit
  precursor, or instability. Most comparator oblique panels are black and
  therefore missing evidence, not evidence of a missing 3D wake; its complete
  top-down row and finite diagnostics support only the same planar topology.
- Three sampled policies are byte-identical coordinated response-release
  copies. Each scores `-0.5283387731`, captures at `25.11852T`, reaches
  `0.746410L`, has mean distance `2.429293780L`, and remains finite with
  inside-`4L` peak lateral-force/yaw-moment coefficients near
  `0.01547/0.00800`. The phase-selective comparator captures one step earlier
  but is marginally worse in score (`-0.5283756345`), mean distance
  (`2.429298361L`), and crossing depth (`0.746517L`); its lower loads do not
  establish better target control.
- The assigned parent's newly completed body-yaw-rate completion mechanism is
  a concrete negative result. It preserves capture and the visible outer wake
  but regresses to score `-0.5292783936`, mean distance `2.430028480L`, and
  final distance `0.747435L`. An inherited direction-aware release veto changes
  a different response quantity yet converges on the same regression:
  `-0.5292956571`, `2.430035779L`, and `0.747430L`. Together with the earlier
  response-partitioned (`-0.5309900794`) and posterior-only
  (`-0.5302882262`) failures, this rules out another phase gate, joint-role
  split, or mechanism that retains extra curvature after the validated
  two-joint equilibrium has settled.
- The coordinated-release parent still crosses with useful speed
  (`0.65387L/T`), no joint-stop dwell, and acceleration maxima of only
  `29.60/26.72 rad/T^2`. Its body-frame redirect angle was reported to fall
  monotonically out of the clipped large-error regime while the joints settle.
  The remaining testable direction is therefore to use that observed body
  alignment to release a little more of both joints into the existing
  posterior-lag carrier, rather than commanding more curvature or broad
  braking. The inherited `51.645T` low-drive orbit continues to prohibit
  coasting or generic terminal drive relief.

## Policy hypothesis

Preserve the evaluated outer carrier, closure preview, body-frame redirect,
two-joint curvature equilibrium, response-settling trigger, and all actuator
limits. Inside the existing range-, closure-, and redirect-gated terminal
allocator, add one disjoint response-completion signal: after both joint
targets have settled, smoothly recognize that the absolute normalized
body-frame redirect angle has left the large-error regime and reduce the
curvature allocation for both joints together. This recovers only a bounded
additional share of the already centered posterior-lag carrier; it cannot
change the outer path, bend sign, joint roles, or act before both joint and
body response are present.

The mechanism tests the direction implied by the evaluated sequence from full
terminal hold to coordinated response release, while avoiding the two newly
observed regressions from restoring hold. Expected evidence is an unchanged
outer wake and threshold history, a crossing at least as deep as `0.746410L`,
no later capture, and terminal loads and saturation comparable to the parent.
Reject it if capture is delayed or lost, the pre-terminal trajectory changes,
the target angle stops improving, a low-drive loop appears, or joint stops,
command clipping, force, or moment increase materially.

bookshelf_consulted: true
source_domain: biological C-start release into swimming and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: release a strong target-directed mean bend into coordinated rhythmic propulsion only after observed joint configuration and body alignment both show redirect response
transferable_invariant: when steering and propulsion share limited joints, use normalized joint and body response to hand both joints continuously from mean curvature back to a traveling carrier rather than using elapsed time or prescribed phase
nontransferable_details: published gains, dimensional cadence, species-specific C-bend timing and envelope, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: inside the existing normalized range/closure/redirect gate, joint settling and reduced absolute body-frame redirect angle jointly recover one bounded additional carrier share for both joints around the unchanged target-relative mean bend
falsification: reject if outer commands or wake change, compact capture or mean distance regresses, body alignment worsens, or terminal saturation, load growth, instability, or low-drive loitering returns

## Non-CFD implementation audit

The deterministic schema scan resolves all 71 direct `params.FIELD`
references in the returned 72-field parameter object, and the lightweight
multi-wake contract state returns two finite bounded commands. Paired synthetic
evaluation against the sampled coordinated-release parent is command-exact for
an outer `6L` state, a terminal state still in the large-error body regime, and
a body-aligned terminal state whose joint targets remain unsettled. Only the
settled-and-body-aligned state changes: the parent command
`(0.00987,0.10573)` becomes `(0.01005,0.11699) rad/T^2`, with body-release gate
`0.8784` and additional carrier share `0.08724`, far inside the command limit.
This establishes schema completeness, activation, boundedness, and the intended
disjoint noninterference only; it is not coupled-flow evidence.

The new CFD evaluation occurs after this worker exits and is not claimed here.
