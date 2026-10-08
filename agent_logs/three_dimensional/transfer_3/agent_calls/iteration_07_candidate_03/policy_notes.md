# Complementary response-scheduled terminal allocation candidate

## Evidence diagnosis before the policy edit

- Every sampled rollout satisfies the frozen physical contract: direct uniform
  still water with `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite
  dynamics, and capture near `25.11T`. The assigned prefill
  `solver_d5c9dea468e1` is the closure-preview baseline (score `-0.53006032`,
  mean distance `2.43063592L`, capture at `25.1130T`).
- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  for the strongest sampled response-release capture
  `solver_89a97c83567b`, the assigned prefill, and the inherited
  posterior-only release `solver_1e6b9b4c3b62`. All three are visibly
  self-propelled: a coherent alternating posterior wake and organized 3D
  Lambda2 chain accompany the same compact target-directed arc, followed by a
  smooth terminal bend into the capture circle. There is no boundary-exit,
  collision, advection, or instability precursor. Their visual equivalence at
  the sampled cadence localizes policy differences to the narrow terminal
  allocation rather than the outer route or wake-forming mechanism.
- Metrics resolve that narrow difference. Relative to the preview baseline,
  phase-selective suppression of equilibrium-departing carrier motion
  (`solver_6a46e49f8216`) improves mean distance to `2.42929836L`, preserves
  capture at `25.1130T`, and lowers inside-`4L` force/yaw-moment coefficient
  maxima from about `0.01547/0.00800` to `0.01426/0.00757`. Settled-response
  release on both joints (`solver_89a97c83567b`) gives the best sampled score
  (`-0.52833877`) and mean distance (`2.42929378L`), though capture occurs one
  `0.0055T` step later. Neither mechanism reaches the acceleration cap inside
  `4L`; both preserve the common outer trajectory and maximum speed.
- The inherited `solver_1e6b9b4c3b62` evaluation is a concrete negative
  joint-role test. Holding the anterior joint at full curvature allocation
  while releasing only the posterior carrier captures later at `25.1240T`,
  raises mean distance to `2.43085240L`, and scores `-0.53028823`, worse than
  both the coordinated response release and the preview baseline. Generic
  posterior-thrust intuition is therefore insufficient here: the observed
  terminal benefit requires coordinated two-joint allocation.
- The informative earlier failure remains the broad approach-hold controller
  recorded in inherited notes. It preserved a coherent early wake but drove a
  large orbit and captured only at `51.645T`. This excludes generic terminal
  braking or low-drive holding; the candidate must preserve the evidenced
  carrier floor and operate only within the geometry-and-closure-qualified
  terminal blend.

## Policy hypothesis

Start from the best evaluated coordinated response-release controller. During
the partial carrier-to-curvature transition only, add the separately evaluated
phase-selective pressure from positive curvature-error growth
`(q-q_target)*q_dot`: motion away from either joint's requested equilibrium
advances allocation, while returning motion keeps the closure-previewed base
blend. Once the two-joint bend has formed, the existing normalized tracking
response recovers the same bounded carrier share on both joints. Thus one
continuous state-feedback allocation uses departure response while unsettled
and settled tracking error afterward; body-frame target geometry and measured
closure retain entry, sign, and release authority.

The two components have complementary activation regions and each improved the
preview baseline in completed CFD. Expected evidence is unchanged outer
commands and coherent wake, the phase-selective candidate's lower transition
loads and `25.1130T` capture timing, plus the coordinated response-release
candidate's lower mean-distance integral after the bend settles. Reject the
combination if it changes the outer trajectory, loses or delays capture beyond
`25.1185T`, returns terminal clipping or joint-stop dwell, exceeds the sampled
inside-band load maxima, or cannot beat the best parent by more than numerical
repeat variation.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping together with sensor-modulated biological burst redirect
source_mechanism: use observed joint response to suppress the rhythm while it opposes a requested bend and release back into coordinated beating after the bend forms
transferable_invariant: target geometry should set the mean bend, while normalized motion toward or away from that two-joint equilibrium schedules shared rhythmic-versus-curvature authority
nontransferable_details: published gains, dimensional frequencies, species-specific C-bend envelopes, prescribed routes, full-body waveforms, and exact vortex phase
policy_translation: retain the existing normalized body-frame geometry and closure gates; during their partial terminal blend, positive two-joint curvature-error growth advances reallocation, and after normalized two-joint tracking error settles, bounded carrier authority is restored symmetrically
falsification: reject if pre-terminal commands or wake change, capture regresses, coordinated release loses its mean-distance benefit, phase-selective load reduction disappears, or terminal saturation and orbiting return

The current worker's CFD outcome is not claimed here; it becomes evidence only
after external evaluation.

## Non-CFD implementation audit

The deterministic policy contract returns two finite commands within the
declared acceleration envelope. Synthetic state comparisons confirm exact
command equality with the preview baseline while the terminal gate is zero,
exact equality with the evaluated phase-selective controller during an
unsettled, equilibrium-departing partial blend, and exact equality with the
evaluated coordinated response-release controller after both joints settle.
These are activation and noninterference checks only, not coupled-flow
evidence.
