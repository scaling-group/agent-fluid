# Multi-Wake Candidate Diagnosis and Hypothesis

## Evidence diagnosis

- The assigned parent guidance treats the target-blind seed's early upstream
  motion as propulsion evidence only and positive body-frame bearing curvature
  as a conditional direction signal. The inherited optimizer notes further
  require a finite bearing-only loop before adding derivative feedback. The
  latest sampled rollout supplies that missing finite boundary, but not a
  navigation success.
- The shared prewarm sheet shows the same held upper-right fish and four
  developed, overlapping vortex streets for every candidate. In all released
  sheets the fish remains to the right of the useful wake/target region, so the
  available evidence concerns far-field propulsion, course control, and
  stability rather than wake exploitation or capture.
- The target-blind `0.55`-period seed visibly self-propels left at first, then
  rotates into a near-vertical lower-boundary exit. Its head displacement is
  `(-3.55,-13.30)L`; mean lateral velocity `-0.263` nearly matches local flow
  `-0.241`, and both joint speed and acceleration caps are reached. Its
  `8.61L` transient minimum distance is therefore not controlled wake entry.
- The `0.75`-period, `22 deg` positive-bearing angle-only oscillator is still
  the only sampled controller with material active upstream travel. The sheet
  shows a nearly horizontal upstream leg before terminal body folding; head x
  moves `-3.59L`, mean velocity x is `-0.149` versus local flow `-0.077`, and
  progress reaches `0.259`. The final fold agrees with both acceleration caps,
  the joint-one speed cap, and RMS force/moment `20024/314391`, so the gait and
  steering direction are useful only when separated from that late yaw/energy
  growth.
- The latest positive-bearing angle-only policy adds local angle/speed guards
  and a smooth action bound. Its released sheet remains orderly much longer,
  then traces a broad turn upward and back to the right without entering the
  wake corridor. It is finite for `63.55` time and stays below the hard limits
  (maximum joint angles `0.589/0.462rad`, speeds `3.965/2.887rad/time`, and
  accelerations `27.18/23.06rad/time^2`), but head displacement
  `(+0.43,+1.80)L`, progress `-0.090`, and mean velocity x `0.00174` versus
  local flow x `0.00926` show that stabilization alone did not preserve active
  upstream propulsion.
- The slower radial-phase policy with a `0.04` turn-rate damping gain is also
  finite and low-load, yet it is almost purely advected: head x moves `+2.27L`
  and mean velocity x `0.0523` nearly equals local flow x `0.0540`. Because
  radial regulation, period, amplitude, and turn damping changed together,
  this is negative evidence for that compound architecture, not an isolated
  rejection of a small turn-rate term.

## One candidate hypothesis

Use the sampled `0.75`-period, `22 deg` angle-only oscillator and posterior lag
that produced the sole active upstream leg. Keep the latest candidate's
reduced `12 deg` positive-bearing limit and its policy-owned angle, speed, and
smooth acceleration guards, which converted the folded-body instability into
a finite rollout. Add only the sampled `0.04` opposing recent-turn-rate term
inside the bounded steering request. This isolates turn damping from the
unsuccessful radial regulator and should arrest the broad late turn while
leaving small-error bearing curvature and the state-encoded propulsion rhythm
intact.

The law uses body-frame bearing, recent turn rate, and joint state only; it does
not encode coordinates, target identity, a route, a clock, prescribed inflow,
or remote wake probes. The next CFD evaluation supports the hypothesis only if
the head again has negative x displacement, retains a useful negative-y
component toward the target, stays finite beyond the `33.06` instability time,
and avoids hard cap contact and a folded terminal body. It is falsified if the
fish is again flow-carried or loops outside the wake like the latest finite
sample, if turn damping suppresses the traveling gait, or if restoring the
faster rhythm recreates growing joint/load excursions despite the guards. No
outcome for this unevaluated candidate is claimed here.
