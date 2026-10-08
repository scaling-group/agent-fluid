# Complementary terminal authority handoff candidate

## Evidence diagnosis before the edit

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=[0,0,0]`, no prewarm or cylinders, finite dynamics, capture at
  `16.054375T`, and 239 moving-window shifts. The motion is self-propelled,
  not background advection.
- I inspected both rows of the combined sheet for the highest-scoring finite
  sample (`solver_ecbe2be01c45`) and the duplicated assigned-parent contrast
  (`solver_31b486aa171c`/`solver_7f16af08a4bf`). The top-down views show the
  same smooth target-directed arc and coherent alternating vorticity street
  from release through capture. The oblique views retain compact alternating
  Lambda2 structures behind the caudal region, with no wake breakup,
  collision, domain exit, or out-of-plane instability. There is no sampled
  failure termination; the informative negative boundary is instead that all
  terminal variants remain visually indistinguishable and arrive on the same
  step, so the evidence does not support changing the carrier or claiming a
  new semantic success.
- Metrics resolve the terminal response. The two exact parent copies capture
  at `0.746212L`, distance integral `1.930147L`, and score `-0.047281`.
  Alignment-conditioned handoff of only the excess redirect curvature keeps
  every `8/6/4/2/1.25L` milestone and actuator/load maximum unchanged while
  improving to `0.746070L`, `1.930028L`, and `-0.047133`. The distinct bounded
  terminal yaw damper also preserves those milestones and improves slightly
  further to `0.746051L`, `1.930012L`, and `-0.047113`, with mean posterior
  command falling from `24.598` to `24.590 rad/T^2`. These are positive but
  trace-scale terminal changes, not evidence for scalar gain optimization.
- The assigned-parent guidance and inherited step-20/21 notes establish the
  boundary: preserve the response-conditioned redirect, posterior traveling
  wave, one-sided relief, and anterior corridor release; active broad
  counter-curvature and corridor-only steering release had regressed. A
  counterfactual evaluation on the sampled yaw-damper states shows why the two
  current positive mechanisms are compatible rather than redundant. The
  alignment handoff reaches about `9.5 deg` of curvature relief near
  `0.813L` and fades to zero as bearing leaves its small alignment cone,
  whereas the safe-corridor yaw damper grows from about `0.35 deg` there to
  `1.89 deg` at capture. This action-support calculation is not a closed-loop
  claim.

## One candidate mechanism

Form a single complementary terminal authority schedule from the two sampled
positive mechanisms. Retain the current alignment-turnaround handoff from
high-authority redirect to cruise curvature, and add the sampled bounded yaw
damper only inside the closing predicted-intercept corridor while measured yaw
and bearing reopening agree. Both act on posterior mean curvature, but over
different portions of the terminal response; neither changes the anterior
oscillator, posterior traveling wave, raw redirect direction, wave selector,
or far-field route. The yaw term is capped well below cruise curvature, so the
combination sheds excess target-signed turning without commanding the broad
opposite bend rejected by inherited evidence.

Expected evidence is the same capture step and coherent two-view wake, with a
smaller terminal distance integral or deeper crossing than `-0.047113` and no
material rise in limiting or loads. Falsify the combination if it changes any
pre-terminal milestone, delays or loses capture, disrupts wake coherence,
reverses needed steering as bearing grows, or merely lowers command effort
without improving trajectory geometry.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and biological terminal capture control
source_mechanism: preserve rhythmic propulsion while sensory response continuously hands excess steering authority to a lower-authority mode and damps remaining terminal yaw
transferable_invariant: separate the productive traveling-wave carrier from bounded response corrections, and reduce only excess correction as measured alignment and endpoint response become reliable
nontransferable_details: published gains, species-specific kinematics, dimensional frequencies, exact vortex phases, morphology-specific envelopes, and source-task routes
policy_translation: in normalized body-frame feedback, combine alignment-turnaround handoff of the high-minus-cruise posterior curvature with safe-closing-corridor damping of normalized measured yaw; retain the two-joint carrier, redirect sign, posterior wave, relief allocator, and anterior release
falsification: reject if cruise milestones or wake coherence change, capture regresses, the combined correction reverses required steering, or terminal distance and load evidence do not improve over the sampled yaw-damping policy

## Non-CFD verification after the edit

- Candidate SHA-256:
  `3cdfa4ca88affce836dd2f3a7acb5f0e7f3088c8fc88ac9b79c1edc1a38099fe`.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini`
  model is unavailable for this account. Its three prescribed commands were
  then run directly and separately. The material guidance/notes check, Julia
  policy contract and parameter-schema check, and editable-boundary check all
  pass. The rendered `README.md` contained the same assigned-parent marker
  twice; the exact duplicate was removed so the prescribed checker could
  resolve the unchanged parent.
- A deterministic `20,000`-state sweep spanning joint state, target side and
  distance, body-frame course, bearing rate, and yaw response returned finite
  commands within `31.416 rad/T^2`, exact lateral-reflection equivariance, a
  finite non-finite-observation fallback, and no outward acceleration at the
  exact joint-speed boundary.
- Counterfactual replay changes only posterior action and only within the
  terminal support. Relative to the sampled handoff, the added damper changes
  16 commands from `0.836L` through capture with maximum difference
  `4.300 rad/T^2`; relative to the sampled damper, the added handoff changes
  seven commands between `0.848L` and `0.752L` with maximum difference
  `4.351 rad/T^2`. Relative to the duplicated parent, the combination changes
  18 commands inside `0.848L`, with maximum difference `8.592 rad/T^2`.
  These checks establish scope and boundedness only; no formal CFD was run and
  the combined closed-loop hypothesis remains unevaluated.
