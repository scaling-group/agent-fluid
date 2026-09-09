# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  developed interacting vortex streets. It is the certified common initial
  condition, not evidence that a policy selected a favorable wake phase.
- The ungated assigned parent appears twice in the sampled set with identical
  capture at `32.472` release time, `1.64761L` mean distance, score `0.224538`,
  and force/moment RMS `68.70/931.60`. Its released sheet shows immediate
  targetward redirection, a sustained posterior-traveling bend, cylinder
  clearance, and a compact diagonal crossing of the `0.75L` target circle.
  Mean fish velocity `(-0.334,-0.140)` against mean local flow
  `(-0.197,-0.189)` confirms self-propulsion rather than passive advection.
- The two new sampled step-12 mechanisms preserve that visible route and each
  improves the parent. Progress-supervised posterior headroom captures at
  `32.340`, improves mean distance to `1.63773L` and score to `0.234663`, and
  lowers force/moment RMS to `65.12/888.56`. Response-confirmed mean-curvature
  release captures fastest at `32.136`, improves mean distance to `1.63696L`
  and score to `0.234607`, and lowers force/moment RMS to `67.22/907.46`.
  Both still touch the velocity and acceleration limits, but posterior peak
  excursion falls from `0.58337 rad` to about `0.5753 rad`.
- The highest-score and fastest-arrival sheets are nearly topology-equivalent:
  both redirect before entering the developed wake, maintain a narrow
  body-generated traveling wake across the diagonal approach, clear every
  cylinder, and first cross the target circle without a visible overshoot.
  No sampled released failure sheet exists. The applicable adverse inherited
  records are therefore a blanket physical-limit gate that delayed capture to
  `33.9405`, an extra posterior burst that arrived later with higher loads,
  and unrestricted bearing-trend recentering that erased the traveling bend
  and exited downstream. The combination must remain one-sided and must never
  suppress the base oscillator or unit-gain posterior wave.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking combined with biological redirect-and-release and posterior reactive propulsion
source_mechanism: preserve a rhythmic traveling gait while measured target progress and correct-sign heading response withdraw only optional steering authority
transferable_invariant: slow body-frame target geometry owns turn direction, verified targetward response may release part of mean curvature, and coherent closure may yield a turn-congruent posterior residual without weakening the persistent traveling wave
nontransferable_details: published gains, duty ratios, dimensional rates, robot or species kinematics, exact vortex phases, actuator ratings, source-task paths, and prescribed maneuver timing
policy_translation: combine the independently successful normalized response gate on distributed mean curvature with the normalized trajectory-efficiency supervisor on direction-selective posterior headroom; both continuously restore authority during redirect, incoherent motion, or lost progress
falsification: reject if the initial redirect or traveling bend weakens, direct capture is lost, arrival exceeds the inherited `32.7305` low-load branch, mean distance exceeds `1.64927L`, or loads rise above both step-12 branches without a compensating navigation improvement

## Candidate hypothesis

Produce exactly one candidate by composing the two evidence-backed step-12
mechanisms without changing their evaluated parameters. Start from the
response-release branch: retain filtered body-frame bearing, the bounded
`12 deg` curvature envelope, bearing-conditioned `40/60 -> 35/65` allocation,
the anterior state-feedback oscillator, posterior lag and damping, and the
maximum `8%` target-helping half-cycle residual. Release at most `18%` of mean
curvature only after a developed gait exhibits both correct-sign heading
response and shrinking bearing.

Add the progress-supervised direction-selective headroom gate only around the
optional posterior residual. Recent target-vector motion must be coherent
closure before actuator-state pressure can yield that increment; early padded
history, redirection, lateral displacement, stall, or recession restores it.
Because the two gates act on different layers and each preserves base
propulsion, the formal rollout can test whether the composition retains the
response-release branch's earlier arrival while recovering the headroom
branch's load reduction. No same-worker CFD improvement or wake-phase
robustness is claimed.
