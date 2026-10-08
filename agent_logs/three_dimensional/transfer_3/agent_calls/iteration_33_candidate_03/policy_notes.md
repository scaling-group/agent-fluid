# Course-consented terminal redirect candidate

## Evidence and visual diagnosis before the policy edit

- All four sampled solver rollouts satisfy the frozen Phase-2 contract:
  direct uniform initialization in still water with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window
  dynamics, and `capture` termination. Their trajectory files and combined
  keyframe sheets are byte-identical despite one policy carrying a dormant
  course/yaw branch. They therefore reproduce the current
  `v40_intercept_supported_terminal_posture` baseline rather than providing
  four independent mechanism contrasts.
- I inspected the full combined sheets for a reproduced `v40` rollout and the
  inherited, twice evaluated `v43_response_energy_intercept_posture`
  regression, including every top-down mid-plane-vorticity frame and oblique
  body/Lambda2 frame from release through capture. Both fish visibly
  self-propel from quiescent water along the same compact upper-side arc,
  shed a coherent alternating posterior wake, and retain finite localized
  three-dimensional structures. Neither shows passive advection, a loop,
  collision, boundary-exit precursor, wake collapse, out-of-plane motion, or
  instability. Their visually indistinguishable wake families and identical
  `4/3/2 L` crossings localize the useful contrast to late target-course
  control rather than propulsion or wake formation.
- The four sampled `v40` trajectories reproduce capture at `19.684490 T`,
  score `-0.261384287`, and mean/final distance
  `2.151092787/0.748302400 L`. The path is `12.9511 L`; below `4 L` it has
  `229/302` anterior/posterior commands above `30 rad/T^2`, `39/57` rate-cap
  contacts, no joint-stop dwell, and finite lateral-force/yaw-moment maxima
  about `0.027533/0.015673`.
- The assigned parent's inherited logs contain two byte-identical completed
  evaluations of `v43`. Adding posture share while the coupled joint response
  is already reducing posture error remains active but delays capture one
  solver step to `19.689989 T` and regresses score, mean distance, and final
  distance to `-0.261806754`, `2.151448039 L`, and `0.748693466 L`. It changes
  only the terminal trajectory, shortens the path slightly to `12.9407 L`, and
  leaves load maxima nearly level, so neither a shorter path nor lower load is
  evidence for more handoff. Together with the completed outward-response
  variants, this rejects joint-response sign in both directions as a selector
  for changing the validated flat posture allocation.
- The inherited outer phase-lag governor is the complementary control failure:
  it preserves finite self-propulsion but turns the compact approach into a
  `31.01 L` loop and delays capture to `46.145020 T`. Thus posterior phase is
  not a safe remaining knob. The stable `v40` traveling-bend phase relation,
  coupled limiter, terminal posture share, and carrier floor should remain
  unchanged.
- Replaying the direct body-frame observations on the completed `v40` trace
  exposes a disjoint locus. Between roughly `1.77` and `4.00 L`, the existing
  signed geometry/course agreement sometimes reports a substantial
  translation miss while the geometry-only large-angle redirect is still
  weak or inactive and the center intercept is unsupported. The policy
  currently uses that consent only in its outer saturation allocator; it does
  not let the same directly observed course evidence establish a small
  low-frequency redirect floor inside the terminal band.

## Policy hypothesis

Start from the four-times reproduced `v40` controller. Preserve its
state-feedback traveling bend, derivative-defined posterior lag,
geometry/course outer allocator, center-intercept posture handoff, closure
preview, mean-bend targets, response-conditioned coupled limiter, target
residual, carrier floor, and command cap. Add one course-consented terminal
redirect floor: inside the existing actual-distance band, with positive
closure and an unsupported center intercept, allow the already computed
signed geometry/course agreement to raise the geometry-owned redirect weight
continuously to at most `0.18`. Combine it with the original angle redirect by
`max`, so course translation cannot reverse the turn, stack authority, change
the redirect equilibrium, or act alone.

This is a new observation-to-allocation mechanism rather than a scalar change
to the validated handoff. It uses direct normalized body-frame target and
center-velocity vectors, not heading-rate reconstruction, instantaneous force,
joint-response sign, beat/vortex phase, a clock, or a memorized route. The
expected effect is identical motion outside `4 L`, followed by earlier use of
the already bounded mean-curvature redirect only where target geometry and
realized translation agree that the current intercept is poor. Falsify it if
the branch is dormant or effectively constant, changes any state at or beyond
`4 L`, acts without positive closure or when the center intercept is supported,
changes turn sign or authority bounds, delays or loses capture, worsens the
distance integral, adds joint-stop dwell or material load, produces a loop or
instability, or degrades either wake view. Formal CFD occurs only after this
worker exits and is not claimed here.

bookshelf_consulted: true
source_domain: closed-loop CPG robotic-fish direction tracking and continuous middle-to-terminal approach control
source_mechanism: preserve the high-frequency traveling wave while a target-relative low-frequency mean-curvature command corrects accumulated course displacement
transferable_invariant: when the propulsive wave is already coherent, directly observed target geometry and center translation may consent to a bounded mean-turn response, but neither signal should reverse or independently replace the established wave
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, full-body waveforms, exact beat or vortex phase, actuator models, target coordinates, capture radius, and task-specific routes
policy_translation: inside the existing normalized proximity and positive-closure gate, use the established signed body-frame geometry/course agreement and loss of center-intercept support to set one small floor on the existing redirect weight; combine by maximum and leave the bend equilibrium and carrier law unchanged
falsification: reject on dormancy or constant activation, action outside the gated terminal miss, changed turn sign or authority, slower or lost capture, worse distance integral, joint-stop dwell, material load growth, looping, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- Loading evaluated `v40` and the final candidate in separate Julia modules
  and replaying reconstructed body-frame states from the completed `v40` trace
  changes `155/3579` stored states. All changes are confined to approximately
  `1.768--3.997 L`, have positive measured closure, and occur only where the
  course-consented floor exceeds the original angle redirect. The realized
  floor varies from near zero to about `0.0951`, and the maximum equal-state
  two-joint command difference is about `3.993 rad/T^2`. Replaying the
  inherited response-energy trajectory gives the same selectivity pattern
  (`157/3580` changed states, `1.771--3.997 L`) rather than depending on one
  exact terminal trace.
- A deterministic `340200`-state grid spanning target range and angle, center
  course and speed, closure, both joint positions, and both joint rates finds
  `7616` active differences from evaluated `v40`. No state at or beyond `4 L`,
  with nonpositive closure, without signed geometry/course consent, or where
  the new floor fails to exceed the original redirect changes. Every output is
  finite and within the declared acceleration cap; the largest synthetic-state
  component difference is about `19.025 rad/T^2`. These checks establish
  boundedness and gate activity only, not coupled-flow improvement.
- The mandated guidance check, lightweight Julia public-contract check, and
  solver edit-boundary check all pass. The schema audit resolves all `89`
  direct `params.FIELD` references against the `90` fields returned by
  `target_policy_params()`; only the version label is intentionally unused.
  Candidate SHA-256 is
  `0ea409db02471d4d91bc7845efbd942a2a34980ee7786f3c1bc8dc9666bb0b31`.
  The prescribed check-runner was invoked after both required files changed,
  but its pinned `gpt-5.4-mini` model is unsupported on this ChatGPT account
  and failed before running commands, so its three exact checks were run
  directly and separately. No formal CFD was run in this workspace.
