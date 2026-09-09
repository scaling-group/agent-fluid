# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before the policy edit

- The shared prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting vortex streets. It is the common initial wake,
  not candidate-specific evidence. The strongest sampled released sheet shows
  an immediate targetward rotation, a persistent body-generated traveling wake,
  and a compact diagonal crossing into the capture circle. It reaches the target
  at `35.0625` released time with `1.73388L` mean distance; the trajectory does
  not show passive downstream advection, collision approach, or a late near
  miss.
- The strongest sample differs structurally from the filtered `40/60` prefill
  only by shifting as much as five percentage points of the unchanged steering-
  curvature budget from the anterior to the posterior joint when the magnitude
  of filtered body-frame bearing is large. Relative to two deterministic prefill
  evaluations, it improves capture from `35.6895` to `35.0625`, mean distance
  from `1.76192L` to `1.73388L`, and score from `0.112158` to `0.140088`. It also
  lowers total command energy from `50,871` to `50,175`, lateral-force RMS from
  `59.28` to `56.57`, and moment RMS from `821.23` to `793.76`. The released
  sheets retain the same useful diagonal topology, so the scheduled posterior
  allocation is promoted as completed evidence rather than extrapolated again.
- This is still an envelope-contact gait: both samples reach the `260/1800`
  degree-based velocity/acceleration limits, and the scheduled policy reaches
  `0.528/0.583 rad` peak anterior/posterior excursion. The observed improvement
  therefore supports wave-shape allocation at this common wake phase, not
  efficiency, robustness, or more unbounded posterior command.
- The informative inherited failure is the additive bearing-trend policy. From
  the same prewarm it never develops a sustained traveling bend, moves
  downstream, makes negative progress, and exits after `16.956`; metrics show
  only `0.140/0.163 rad` peak joint excursions, `8.64` mean command energy, and
  a `12.424L` closest approach. Its low load is propulsion collapse, so this
  candidate does not insert bearing rate, force, moment, or crossflow into the
  oscillator-center path.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping, interpreted through elongated-body posterior reactive propulsion
source_mechanism: strengthen only the target-helping half-cycle of a posteriorly lagged traveling wave while persistent target geometry continues to set bounded mean curvature
transferable_invariant: after target-signed mean curvature establishes the turn, observed joint phase may apply a small sign-symmetric posterior half-cycle asymmetry without replacing the traveling wave or using an external clock
nontransferable_details: published gains, duty ratios, dimensional frequencies, species or robot kinematics, exact vortex phases, actuator envelopes, and source-task routes
policy_translation: promote the sampled bearing-magnitude posterior-allocation schedule, infer posterior wave phase only from filtered body-frame bearing and current anterior joint state, and smoothly scale the target-helping posterior half-cycle by a small owned bound that vanishes at alignment
falsification: reject the half-cycle mechanism if target capture is lost or later than 35.0625, mean distance is not below 1.73388L, the direct diagonal trajectory curls or drifts downstream, or posterior saturation and force or moment increase without a navigation gain

## Candidate hypothesis

Promote the strongest completed policy, then add exactly one new controller
mechanism: bounded target-signed posterior half-cycle asymmetry. The existing
filtered bearing still sets the `12 deg` total mean-curvature request and its
smooth `40/60 -> 35/65` allocation. The new state-feedback path identifies the
posterior wave component already implied by anterior angle and velocity and
admits at most an `8%` scale increase only on the half-cycle whose sign agrees
with the current turn request. It is continuously gated by bearing magnitude,
so the evaluated scheduled policy is recovered exactly as the fish aligns.

The `0.55`-period, `28 deg` oscillator, nonlinear drive, posterior lag, damping,
bearing-history estimator, total curvature, and allocation schedule otherwise
remain unchanged. The expected downstream result is slightly faster early
redirection without adding a static-curvature scalar or cancellation-capable
route derivative. The half-cycle translation is unevaluated; no new CFD benefit
is claimed by this worker.
