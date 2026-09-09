# Candidate diagnosis and policy hypothesis

## Evidence read before editing

- All four current solver examples and the inherited optimizer evaluations use
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders, and no prewarm. Their translation and wakes are released-swimmer
  behavior rather than ambient advection or a stored-flow artifact.
- I inspected both rows of the combined sheets for the best-scoring sampled
  capture (`solver_6b0e320e2f55`, `0.74939L`), the assigned-parent bearing-
  recovery failure (`solver_75af5e6ee82e`, `1.80040L`), and the sampled
  full-band intercept-release failure (`solver_82903e203dca`, `1.37249L`).
  Each fish self-propels with a persistent alternating top-down vortex street
  and compact bilateral oblique Lambda2 structures. Both failures continue
  beating after closest pass and leave through the lower boundary; neither is
  a carrier-collapse, background-transport, or numerical-instability event.
- The current examples contain two exact speed-reserve captures and two
  posterior-pulse captures. Inherited exact replays make both less robust than
  those four threshold outcomes suggest: baseline replays miss at
  `1.4642--1.6463L`, while the posterior pulse is already rejected after a
  `1.2589L` miss. The assigned-parent chain also rejects offline phase-sway
  compensation (`1.5445L`) and target-bearing recovery (`1.8004L`).
- The full-band geometry veto tested the latest response-release hypothesis.
  It preserved the active wake and moved closest approach to `1.3725L`, but
  still missed below and exited at `32.571T`. Therefore expanding or tuning
  the release corridor is not a supported next step. Across the coherent
  speed-reserve family, posterior action clips slightly more often than
  anterior action (about `70.6--72.0%` versus `68.5--70.6%` in the cited
  capture/failure diagnostics), while the evaluated steering residual is
  tail-dominant (`head_steering_share=0.45`, `tail_steering_share=1.00`).
- This combination points to control realization rather than route sensing or
  propulsion: terminal target steering is competing most strongly with the
  posterior traveling-wave actuator that the two visual views show should be
  preserved.

## One candidate hypothesis

Restore the exact intercept-guarded speed-reserve scaffold and remove the
falsified posterior pulse. Add one bounded spatial steering-allocation
mechanism: only inside the existing `4L` terminal band, and only while raw
body-frame target/velocity projection is not capture-compatible, transfer a
fixed fraction of additive steering from the posterior joint to the anterior
joint. Keep the sum of the two steering shares constant. As the projected
intercept becomes compatible, smoothly return to the evaluated `0.45/1.00`
allocation. The carrier, posterior lag, cadence, route command, response
release, steering magnitude, and actuator-state speed reserve remain
unchanged.

Expected test: preserve the far-field trajectory exactly outside `4L` and
retain the active two-view traveling wake, while using the less-clipped
anterior channel for the unsafe terminal redirect and shielding posterior
propulsive phase from most of that residual. This is a spatial control-
allocation primitive, not scalar route/cadence/steering gain tuning.

Falsification: reject the anterior transfer if another rollout misses, the
top-down street or oblique Lambda2 wake weakens, terminal speed falls outside
the sampled capture range, the miss flips above the target, or clipping,
force, or yaw moment leaves the speed-reserve envelope. Do not answer failure
by increasing the transfer fraction or stacking the rejected phase observer,
bearing recovery, full-band release veto, posterior pulse, or mean-curvature
servo.

bookshelf_consulted: true
source_domain: classical elongated-body propulsion, robotic-fish turning, and observed-response burst redirection
source_mechanism: use anterior bending to redirect a swimmer while preserving a posteriorly lagged propulsive wave, then release the redirect as measured target-relative motion becomes compatible
transferable_invariant: separate the spatial actuator role that realizes target redirection from the posterior joint role that sustains reactive thrust, without suppressing the traveling rhythm
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, explicit oscillator phase, exact vortex phase, fixed task coordinates, and memorized routes
policy_translation: use normalized body-frame projected-miss and approach gates to transfer only unsafe-terminal additive steering from the posterior joint to the anterior joint, while retaining the state-feedback carrier and constant total steering authority
falsification: reject if far-field closure changes, either wake view weakens, capture is lost, the miss changes side, or actuator and load metrics leave the evaluated speed-reserve envelope
