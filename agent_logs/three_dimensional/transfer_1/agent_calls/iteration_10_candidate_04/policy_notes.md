# Common-mode gait-rejection candidate

## Evidence and visual diagnosis before editing

- All four sampled rollouts satisfy the experiment contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no prewarm, no cylinders, finite
  dynamics, and semantic `capture`.  Three independent samples of the current
  phase-neutral/allocation controller reproduce exactly at `23.9305 T`, score
  `-0.55178099`, and distance integral `2.45000 L`.  This improves the sampled
  allocation-only parent at `25.9545 T`, score `-0.64778945`, and integral
  `2.55008 L`; the combination is therefore a deterministic positive result,
  not a packaging difference.
- I inspected the combined top-down vorticity and oblique Lambda2 sheets for
  the best repeated controller and its allocation-only parent.  Both are
  visibly self-propelled from quiescent water: compact startup structures grow
  into a coherent alternating posterior wake and bend with a continuous
  target-signed route through capture.  The current controller turns and
  closes more aggressively after `8 T`; its more separated late wake packets
  agree with higher mean/max speed (`0.546/0.784` versus
  `0.510/0.667 L/T`) and are not, by appearance alone, an efficiency gain.
  There is no sampled semantic failure sheet in this generation.  The
  inherited informative failure remains the response-only redirect release
  that passed above-left at `2.4625 L` and exited left; completion-gated
  redirect release and the posterior traveling-wave carrier remain protected.
- Metrics confirm both the improvement and the residual weakness.  The
  current controller is slightly farther away at `8 T` (`10.548` versus
  `10.468 L`) but leads by `0.212 L` at `12 T`, `0.507 L` at `16 T`, and
  `0.946 L` at `20 T`.  Its any-joint acceleration-limit residence rises from
  `33.95%` to `45.62%` (head/tail `31.60/14.02%`), while peak normalized
  force/moment remain unchanged at `0.02974/0.01484`.  Thus the useful change
  is route-scale turn interpretation, but the combined controller still
  injects avoidable gait-frequency steering and action.
- Reconstructing the evaluator's seven-step body-frame bearing window from
  `trajectory.csv` exposes the inconsistency.  In the repeated best rollout,
  raw bearing trend has standard deviation `1.472 rad/T` and correlation
  `-0.959` with observed `phi_dot[1]`; the existing kinematic correction
  `+0.40*phi_dot[1]` reduces its sampled standard deviation to `0.476 rad/T`.
  The same operation reduces the allocation parent's bearing-trend deviation
  from `1.311` to `0.336 rad/T`.  The current guidance applies this correction
  to recent body yaw but not to body-frame target-bearing trend, even though
  both contain the same observed carrier recoil.

## One-candidate policy hypothesis

Retain the captured traveling-wave carrier, completion-gated redirect,
progress-gated posterior lag, phase-neutral route yaw, and carrier-first
steering allocation.  Add one consistency mechanism: form a phase-neutral
body-frame bearing trend by adding the same observed joint-state carrier-yaw
estimate already used to correct recent body yaw.  Use that corrected trend in
both bearing-rate anticipation and centerline sweep damping.  This is a
kinematic common-mode rejection of the fish's own beat from two coupled
guidance signals; it introduces no gain change, clock, stored phase, global
direction, task route, or new propulsion command.

The expected outcome is to keep the current controller's `12--24 T` lead and
capture while reducing countersteering, tail saturation, and peak speed toward
the allocation-only envelope.  Falsify the mechanism if capture is lost or
later than `23.9305 T`, the distance integral exceeds `2.45000 L`, the lead
after `12 T` shrinks, the target-signed arc or alternating wake loses
coherence, or action-limit residence, speed, force, or moment increases.  The
new candidate has no same-worker CFD evidence; formal evaluation after exit
must decide whether the reconstructed phase cancellation transfers online.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG direction tracking and separation of rhythmic locomotion from persistent route response
source_mechanism: reject observed gait-synchronous motion from target feedback while retaining the state-feedback propulsive carrier
transferable_invariant: guidance derivatives that share a carrier-induced body rotation should remove the same observed joint-state common mode before commanding route-scale steering
nontransferable_details: published oscillator gains, clocked CPG phase, robot geometry, species-specific kinematics, dimensional cadence, exact vortex phase, and prescribed task routes
policy_translation: add the existing bounded `carrier_yaw_rate_gain*phi_dot[1]` estimate to both recent yaw and body-frame bearing trend, then retain normalized target guidance and two-joint carrier-first residual projection
falsification: reject if common-mode correction does not preserve or improve capture and route integral, fails to reduce oscillatory steering or saturation, or worsens wake coherence, speed, normalized load, or the inherited left-exit boundary

## Evidence boundary

All numerical and visual claims above come from completed sampled CFD and
inherited logs.  The policy edit below is an unevaluated transfer hypothesis.
