# Candidate diagnosis and hypothesis

## Evidence read before the edit

- The assigned parent is the completion-gated redirect capture.  Each of the
  four sampled evaluations terminates in capture at `0.7496068 L` and
  `26.4110 T`, with score `-0.7105018`, distance integral `2.6134025 L`, and
  direct uniform still-water initialization.  Three samples use byte-identical
  policy code; the fourth adds only a policy-side acceleration clamp and has
  the same non-command trajectory and byte-identical keyframe sheet.  The
  inherited optimizer score logs also repeat this capture through completed
  iterations 2--5, so this is a genuine performance plateau rather than a
  single noisy observation.
- Both views in the combined and view-specific keyframe sheets were inspected.
  The top-down row shows a compact startup wake becoming a long, coherent
  alternating sheet by `5--10 T`; that sheet remains attached through the
  broad target-signed bend and curves cleanly into the capture circle.  The
  oblique Lambda2 row likewise shows self-propelled, spanwise 3D structures
  rather than passive advection from the zero background flow.  There is no
  visible collision, wake breakup, or terminal instability.
- The sampled set contains no visual failure: all four combined sheets are
  byte-identical captures.  The informative failure comparison is therefore
  limited to inherited quantified evidence: response-only redirect release
  missed at `2.4625 L`, terminal drive relief missed at `1.2329 L`, and an
  outward joint-speed guard delayed otherwise identical capture by `0.4015 T`.
  These results argue against changing the proven redirect release, globally
  relieving the carrier, or attenuating productive outward acceleration.
- The captured trajectory exposes a narrower opportunity.  Distance falls by
  only `0.66 L` in the first `5 T` while body-frame forward speed grows from
  zero to about `0.4 L/T`; it later settles near `0.55--0.62 L/T` and peaks at
  only `0.667 L/T`.  During the early buildup the body-frame target angle is
  small (`0.155 rad` initially, about `0.11 rad` at `2 T`, and approximately
  zero at `4 T`).  It exceeds the redirect threshold later, so propulsion can
  be augmented during aligned startup without asking the carrier to fight the
  large-angle turn.

## One-candidate policy hypothesis

Retain the captured completion-gated redirect, posterior-lag carrier, approach
logic, and actuator output unchanged.  Add one bounded, state-feedback speed
recovery mechanism to cadence: measured normalized forward-speed deficit can
add cadence only while the normalized body-frame target angle is within a
narrow alignment window; the contribution vanishes continuously as cruise
speed is reached, alignment is lost, or turn load rises.  This is intended to
shorten the low-progress startup segment while leaving the middle redirect and
terminal capture topology unchanged.  It is not a global frequency increase
and does not use elapsed time, a route, or world coordinates.

Expected evidence: earlier distance contraction and capture than `26.4110 T`,
with the same coherent alternating wake and without materially exceeding the
parent's `0.667 L/T` peak speed, joint-limit residence, or load envelope.
Falsify the candidate if it delays or loses capture, makes the target angle
grow sooner, causes a different boundary-exit topology, breaks wake coherence,
or produces persistent speed/action saturation or larger force/moment peaks.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and swimming-efficiency scaling
source_mechanism: sensor-gated modulation of a rhythmic propulsive oscillator
transferable_invariant: change propulsive authority from measured locomotion state, and preserve the traveling posterior wave and steering authority while the target is misaligned
nontransferable_details: published CPG gains, dimensional cadence, animal Strouhal values, species kinematics, exact vortex phases, and task-specific routes
policy_translation: add a bounded cadence residual from normalized body-frame forward-speed deficit, body-frame target alignment, distance approach gain, and turn load to the existing two-joint state-feedback oscillator
falsification: reject if startup closure or arrival does not improve, redirect geometry changes adversely, the coherent 3D wake degrades, or speed, action, force, or moment limits become persistent
