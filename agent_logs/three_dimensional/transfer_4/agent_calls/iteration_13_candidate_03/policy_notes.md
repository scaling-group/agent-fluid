# Two-joint energy-qualified posterior reserve candidate

## Evidence and visual diagnosis before editing

- I reviewed the assigned parent guidance; all four sampled scores, policies,
  observations, metrics, diagnostics, trajectories, and combined keyframe
  sheets; and the inherited step-12 optimizer notes and completed evaluations.
  Every compared rollout uses direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders or prewarm, stable dynamics, and capture.
- I inspected both the release-to-capture top-down vorticity and oblique
  Lambda2 rows for the replicated error-qualified baseline, the strongest
  sampled posterior-reserve rollout, and the assigned parent's closure-gated
  rollout as the most informative negative control. All three self-propel from
  rest, build a coherent alternating mid-plane street, and retain compact
  three-dimensional posterior structures through capture. There is no passive
  advection, collision, wake breakup, or out-of-plane instability, so the
  discriminating evidence is early propulsion and route state rather than wake
  existence.
- Three sampled policies reproduce the baseline at `17.7265T`, score
  `-0.08139542`, score-mean distance `1.967391L`, center path `12.8468L`, and
  maximum head cross-track `0.5120L`. The sampled low-anterior-energy
  posterior reserve is a genuine semantic improvement: it lowers early
  `0--3T` mean distance from `12.230072L` to `12.214443L`, raises early mean
  speed from `0.2395U` to `0.2523U`, and improves score/mean distance to
  `-0.07395193/1.960279L` while preserving the coherent wake and capture.
- That positive mechanism has a clear boundary. It captures later at
  `17.9740T`, lengthens center path to `13.0672L`, raises maximum cross-track
  to `0.6630L`, lowers approach/final course alignment from
  `0.899/0.601` to `0.740/0.132`, and raises posterior acceleration-ceiling
  residence from `64.82%` to `65.94%`. Thus a global posterior gain is not
  supported; the reserve should remain a transient state-qualified recovery
  mechanism and should release when the posterior response is already present.
- Reconstructing nominal phase-plane energy from the sampled joint histories
  sharpens that hypothesis. The anterior-only reserve gate has mean activity
  about `0.235` during the first `3T`; qualifying it by a posterior angle-rate
  deficit reduces the joint gate to about `0.172` while keeping its strongest
  release transient. This adds an observed posterior-response condition rather
  than retuning the reserve gain or scheduling it by elapsed time.
- The assigned parent's completed closure-gate evaluation is a concrete
  negative result: it retains capture at `17.7265T` but regresses to
  `-0.08181857/1.967732L`. Although its inherited hypothesis called the signal
  co-windowed, the formal moving-window adapter does not return
  `window_closing_speed_L`; the policy's `hasproperty` branch therefore used
  single-step `closing_speed_L`. That result does not support another approach
  cadence intervention and demonstrates that fallback semantics must be
  audited against the actual observation tuple.

## One policy hypothesis

Start from the sampled low-energy posterior reserve while preserving the
error-qualified far/middle route observer, ordinary approach controller, odd
mean-curvature plus beat-synchronous steering, anterior phase-plane carrier,
posterior lag/emphasis, cadence schedule, and reversal-preserving rate
governor. Add one compatible feedback condition: compute normalized posterior
angle-rate phase-plane energy from `phi[2]` and `phi_dot[2]`, and multiply the
existing anterior-energy deficit gate by a smooth posterior-response deficit
gate. Extra posterior lagged-wave target is therefore available only while
both ends of the two-joint traveling response are weak. It releases when the
anterior carrier recovers, when posterior motion is already established, or
when steering curvature itself has loaded the posterior joint. The mechanism
uses normalized joint state only; it adds no clock, route memory, coordinates,
target identity, randomness, or mutable state.

Expected evidence is retention of the sampled reserve's lower early distance
and improved score-mean distance, with center path and cross-track moving back
toward the replicated baseline, approach/final alignment recovering, and no
increase in posterior acceleration/rate residence or force/moment class.
Falsify the candidate if early closure returns to the baseline, score or
capture regresses, the combined gate remains materially active after the
traveling response is established, route/terminal state stays as poor as the
anterior-only reserve, actuator residence worsens, reflection symmetry is
lost, or either visual view loses the coherent posteriorly lagged wake.

bookshelf_consulted: true
source_domain: Lighthill-style elongated-body propulsion and low-dimensional state-feedback robotic-fish oscillators
source_mechanism: posterior kinematics provide reactive thrust while observed oscillator energy regulates establishment and recovery of a traveling bend
transferable_invariant: allocate extra posterior traveling-wave demand only while observed joint-state energy shows that both the carrier and posterior response are deficient, then release it continuously when either response is established
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phases, target coordinates, task routes, and clock-driven startup schedules
policy_translation: multiply the sampled anterior phase-plane deficit gate by a smooth normalized posterior angle-rate deficit gate before scaling the lagged posterior wave, leaving body-frame target steering unchanged
falsification: reject if early target closure and score-mean distance do not improve without the anterior-only reserve's longer path, cross-track, terminal misalignment, extra actuator residence, reflection loss, or degraded top-down and oblique wake coherence
