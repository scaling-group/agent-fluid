# Reproduced direction-conditioned limiter after rate-headroom regression

## Evidence and visual diagnosis before the candidate decision

- The assigned parent is the `v34` direction-conditioned coupled limiter. Three
  sampled evaluations are byte-identical to it (policy SHA-256
  `2c717baeab46ef4e3b148517b6fca1d8adf4b3ac3c681d11bde166550c082d45`)
  and reproduce the same direct-uniform still-water rollout exactly: capture at
  `21.912008 T`, score `-0.3246592933`, mean distance `2.218947189 L`, final
  distance `0.747680604 L`, and 260 moving-window shifts. The fourth sample is
  `v35`, which keeps `v34` and adds only a common outer attenuation when an
  outward command coincides with near-limit joint rate. It still captures, but
  at `22.038506 T`, with score `-0.3276334301`, mean distance
  `2.222065709 L`, final distance `0.748223662 L`, and 261 shifts.
- I inspected both combined sheets from quiescent release through capture for
  a reproduced `v34` winner and the informative `v35` regression. In both, the
  fish self-propels along the same compact target-directed arc, sheds a
  coherent alternating top-down wake, retains finite localized oblique
  Lambda2 structures, and settles into a quiet held-bend terminal glide. The
  sheets show no passive advection, loop, collision, boundary-exit precursor,
  wake collapse, or out-of-plane instability. The difference is a small lag
  along the same useful topology, not a new failure class: near `12 T`, `v35`
  remains at `6.98076 L` versus `6.95664 L` for `v34`, and it crosses the
  capture threshold 23 solver steps later.
- Telemetry explains why the added guard is not a reusable improvement.
  `v35` reduces anterior/posterior `|action|>30` incidence from about
  `29.87%/44.10%` to `22.74%/38.83%`, but the incidence of
  `|phi_dot|>4.4` slightly increases from `9.79%/10.19%` to
  `9.96%/10.33%`; both reach `4.53786 rad/T`. Peak force changes only from
  `0.029884` to `0.029826`, while peak moment grows from `0.015581` to
  `0.015711`. Although the rate guard is algebraically zero below `4 L`, its
  altered outer state leads to below-`4 L` action maxima of
  `30.27/30.42 rad/T^2`, versus `29.13/21.82` for `v34`. Lower cap count and
  local load are therefore insufficient when cadence, arrival, and terminal
  state all regress.

## Policy hypothesis

Promote the sampled `v34` policy unchanged as this workspace's single
candidate. Preserve the normalized body-frame target guidance, state-feedback
oscillator, anterior-to-posterior lag, target-angle equilibrium redirect,
closure preview, shared terminal mean bend, center-intercept support, paired
terminal release, the reproduced `12%` outer common-scale floor, and its
clipping-angle-conditioned six-percentage-point increment. Do not retain or
replace the failed rate-headroom attenuation, and do not optimize cap incidence
independently of target progress.

This is a consolidated evidence-backed promotion rather than a new CFD claim:
the candidate remains byte-identical to the three reproduced winners, while
its formal evaluation occurs only after this worker exits. Falsify the choice
if it fails to reproduce capture near `21.912 T` and mean distance near
`2.21895 L`, or if the compact path, terminal commands, joint-stop behavior,
loads, stability, or either wake view changes materially.

bookshelf_consulted: true
source_domain: classical traveling-wave and elongated-body swimming together with sensor-modulated coupled-oscillator robotic-fish control
source_mechanism: preserve an anterior-to-posterior traveling bend and its inter-joint coordination when bounded actuation engages
transferable_invariant: actuator handling should preserve the direction and lag of a productive coordinated joint command, while smaller commands or fewer cap contacts are not useful unless target progress and the realized gait also improve
nontransferable_details: published gains, dimensional cadence, species-specific kinematics and envelopes, full-body waveforms, exact phase lags, vortex phases, capture geometry, and task-specific routes
policy_translation: retain the reproduced normalized body-frame `v34` controller and its direction-conditioned outer common scaling; reject the sampled near-rate common attenuation because it changes the realized trajectory without reducing rate-limit incidence
falsification: reject on failed reproduction, delayed or lost capture, worse distance integral, terminal-state drift, joint-stop dwell, material load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- The selected candidate is non-empty and byte-identical to all three
  reproduced `v34` samples, with SHA-256
  `2c717baeab46ef4e3b148517b6fca1d8adf4b3ac3c681d11bde166550c082d45`.
  This establishes exact promotion, not a new CFD result.
- The prescribed checker agent was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable for this account and failed before running a command.
  Its three declared checks were then run directly and separately: the
  material guidance/notes check, finite two-acceleration Julia contract, and
  solver edit-boundary check all pass.
- A separate deterministic schema audit resolves all 81 direct
  `params.FIELD` references to fields in the 82-field object returned by
  `target_policy_params()`; only the version label is intentionally unused.
  No formal CFD was run in this workspace.
