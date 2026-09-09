# Candidate diagnosis and policy hypothesis

## Evidence read before editing

- All four sampled rollouts and the inherited failures use direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders, and
  active moving-window shifts. Their motion is released self-propulsion, not
  ambient advection or a prewarmed-flow artifact.
- The two exact speed-reserve samples capture at `0.7485--0.7494L`, and the two
  posterior-pulse samples capture at `0.7480--0.7492L`. I inspected both rows
  of all four combined sheets. Each fish lays down an organized alternating
  red/blue top-down street and compact bilateral oblique Lambda2 structures
  through arrival; the posterior pulse has no visible propulsion or stability
  advantage and inherited exact-repeat evidence already rejects it at `2/3`.
- I also inspected both rows for the assigned parent's target-bearing recovery
  failure and the sibling full-band release-veto failure. Both retain the same
  active traveling wake through closest pass and lower exit. The bearing
  residual misses at `1.8004L` and exits at `10.1819L`; the release veto reaches
  `1.3725L` but still exits at `10.6694L`. Metrics and diagnostics report finite
  stable motion, direct uniform initialization, and no carrier collapse, so
  neither outcome supports another inner-terminal observation or release edit.
- The assigned-parent result directly falsifies its premise that a slow body-
  frame bearing residual would repair the phase-sensitive course loop. At the
  first `4L` and `3L` crossings its bearing and raw course error already have
  the same positive sign (`+0.562/+0.358` and `+0.672/+0.296 rad`), yet the
  route remains below the successful family. Adding bearing therefore
  reinforces an already-correct request rather than recovering a vanished one.
- The useful separation appears before the current `4L` terminal gate. At the
  first `5L` crossing the current captures have head `y=11.386--11.501L`,
  projected miss `1.712--2.194L`, and approach alignment `0.898--0.940`. The
  two exact-baseline failures and assigned-parent failure are already lower at
  `y=11.023--11.127L`, with projected miss `2.769--2.988L` and alignment
  `0.802--0.832`. At those rows one or both returned accelerations are clamped
  and one joint is often at `0.94--1.00` of the speed limit, while the existing
  sparse carrier reserve cannot act because it is gated to zero outside `4L`.

## One candidate hypothesis

Restore the exact speed-reserve route and actuation equations, with no bearing
residual and no full-band release veto. Add one geometry-to-actuator coupling:
between `6L` and the existing terminal region, let poor target/velocity
alignment open the already evaluated sparse carrier-reserve mechanism. The
reserve still requires joint speed near its limit, a previously saturated
outward action, and current outward carrier acceleration; it neither increases
steering gain nor attenuates restoring carrier effort. The mechanism therefore
acts only when mid-approach geometry is unsafe and actuator state says outward
carrier work is consuming steering headroom, then hands back to the unchanged
terminal reserve.

Expected test: preserve motion outside `6L`, raw achieved-course steering, the
posteriorly lagged traveling bend, and both coherent wake views, while reducing
the already-visible lower branch before `4L`. Falsify the mechanism if it loses
capture, retains the same `5L`/`4L` lower separation, weakens either wake,
coasts, or moves speed residence, clipping, force, or moment outside the
sampled speed-reserve envelope. The new CFD evaluation occurs after this
worker exits and is not evidence in these notes.

bookshelf_consulted: true
source_domain: observed-response C-start redirection and sensor-modulated robotic-fish direction tracking
source_mechanism: preserve rhythmic propulsion but transiently prioritize a redirect when observed target-relative motion is unsafe, releasing it when the response becomes compatible
transferable_invariant: route geometry should gate a bounded actuator-allocation change, while the posterior traveling bend and measured target/course feedback remain intact
nontransferable_details: biological burst magnitude and timing, robot morphology, published gains, dimensional cadence, exact oscillator or vortex phase, task coordinates, and source-specific routes
policy_translation: use normalized body-frame target/velocity alignment in a smooth middle-distance band to enable the existing joint-state outward-carrier reserve without changing the two-joint steering law
falsification: reject if far-field closure or wake coherence changes, capture is lost, the lower branch remains, carrier collapse appears, or actuator and load metrics leave the evaluated baseline envelope

## Non-CFD implementation cross-check

Replaying only the new context-gate equation over recorded trajectories makes
it identically zero at and beyond `6L`. On the inbound `6--4L` segment it is
active on `9.3--13.8%` of rows in the four current captures, with mean gate
`0.005--0.010` and maximum `0.300--0.364`; in the two exact-baseline failures
and assigned-parent bearing failure it is active on `20.2--24.8%`, with mean
`0.103--0.147` and maximum `1.0`. The joint-speed, previous-action, and outward-
carrier tests then further restrict actual relief. This is a recorded-trace
selectivity and contract check, not a claim about the unevaluated closed-loop
CFD result.
