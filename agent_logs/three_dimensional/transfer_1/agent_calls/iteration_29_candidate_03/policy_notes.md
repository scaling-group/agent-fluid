# Candidate diagnosis and policy hypothesis

## Evidence read before editing

- All four sampled solver evaluations and the inherited assigned-parent
  evaluations use direct uniform still-water initialization with
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, stable dynamics, and active
  moving-window shifts. Their translation is released self-propulsion rather
  than ambient advection or stored-flow contamination.
- I inspected both rows of the combined sheets for the best-scoring exact
  speed-reserve capture (`0.74939L`), the assigned-parent posterior-wave
  capture (`0.74797L`), and the inherited actuator-burden failure (`1.43685L`).
  The capture sheets develop a coherent alternating red/blue mid-plane street
  and compact bilateral oblique Lambda2 structures through arrival. The
  burden failure retains the same active traveling bend and organized wake
  through closest pass, then crosses below the target and exits the lower
  boundary. It is a terminal path failure, not wake collapse, coasting,
  background transport, or numerical instability.
- The current sample contains two exact
  `dogfish3d_intercept_guarded_speed_reserve_v1` captures at
  `18.287--18.601T`, one posterior-wave capture at `18.199T`, and one fixed
  unsafe-terminal anterior-transfer capture at `18.749T`. Inherited exact
  replays supply the failures hidden by those four threshold outcomes: the
  posterior pulse is only `2/3` after a `1.2589L` miss, while the fixed
  anterior transfer repeats as a `1.9385L` lower exit.
- The latest assigned-parent actuator-burden allocator also fails its stated
  falsification test: it misses below at `1.43685L`, exits at `32.384T`, and
  finishes `10.5266L` away. At closest pass it remains self-propelled at
  `0.8237L/T`; its peak planar force (`0.0311`) and yaw moment (`0.0158`) stay
  inside the sampled capture envelope. Action still clips on `70.06%/71.13%`
  of rows despite moving steering only when normalized tail burden exceeds
  head burden. The visual and trace evidence therefore reject actuator
  allocation as a terminal robustness repair, not merely its transfer cap.
- Inherited evidence already rejects scalar cadence relief, carrier
  suppression, a total-command governor, half-cycle reallocation, projected-
  miss route replacement, yaw braking, posterior phase shaping, mean-
  curvature tracking, course demodulation, bearing supplementation, and a
  wider response-release veto. There is no positive basis for stacking one of
  those mechanisms onto another spatial allocator.

## One candidate hypothesis

Remove the assigned parent's falsified posterior wave-shape pulse and restore
the exact sampled `dogfish3d_intercept_guarded_speed_reserve_v1` controller as
the sole candidate. This preserves the achieved-course route command, bounded
response/intercept scaffold, state-feedback traveling bend, and sparse
outward-carrier reserve without adding another terminal observer, carrier-
phase term, or steering-share transfer. The choice is an evidence-driven
rollback from a less reliable child, not a claim that the baseline is already
robust: its three inherited exact captures remain stronger evidence than the
posterior pulse's `2/3`, while inherited baseline misses still define the
open robustness problem.

Expected test: recover the sampled baseline's active two-view wake, far-field
closure, and capture-capable trajectory without the posterior pulse or failed
spatial allocation. Force, yaw moment, action clipping, and terminal speed
should remain inside the established speed-reserve envelope.

Falsification: another lower exit or closest pass outside capture confirms
that the restored scaffold is only a stochastic threshold solution. Later
workers should then avoid tuning the pulse, spatial-transfer cap, burden gate,
release corridor, cadence, or carrier reserve and instead test a genuinely
different route/steering architecture with repeat evidence.

bookshelf_consulted: true
source_domain: classical elongated-body propulsion and sensor-modulated robotic-fish direction tracking
source_mechanism: preserve a posteriorly lagged traveling bend for reactive thrust while target-directed feedback supplies bounded redirection
transferable_invariant: do not perturb or reallocate the posterior propulsive wave unless the added steering realization produces a repeatable target-relative benefit
nontransferable_details: published gains, dimensional cadence, species or robot kinematics, explicit oscillator phase, exact vortex phase, fixed task coordinates, and memorized routes
policy_translation: remove the falsified posterior pulse and retain only normalized body-frame target/course feedback, the two-joint state-feedback traveling bend, and actuator-state carrier reserve
falsification: reject the restored scaffold as robust after another exact-policy miss, loss of either wake view, changed far-field closure, or actuator and load excursion beyond its sampled envelope
