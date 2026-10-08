# Terminal opposed-stroke reallocation candidate

## Visual diagnosis before the policy edit

- All four sampled rollouts are byte-identical v41 phase-allocation results.
  They satisfy the frozen direct-uniform still-water contract
  (`U_infinity=[0,0,0]`, no cylinders or prewarm), capture at `24.640015T`
  and `0.748356L`, have mean distance `2.347937L` and score `-0.448328283`,
  and use `284` moving-window shifts.  Thus the sample is four deterministic
  replications, not four distinct controller comparisons.
- The combined keyframe sheet was inspected from release through termination
  in both views.  The top-down row begins wake-free, then shows self-propelled
  diagonal progress with a coherent alternating vortex street and a compact
  transverse hook into the capture disk.  The oblique row retains compact
  three-dimensional Lambda2 structures through capture.  Nothing indicates
  passive advection, out-of-plane escape, or numerical instability.
- No failed-rollout keyframe exists in the current sample.  The informative
  failure boundary is therefore inherited textual evidence, not an invented
  visual comparison: posterior reference-velocity feedforward altered the far
  route by `8T`, missed at `0.993183L`, and exited left despite a coherent wake;
  broad dual-joint rate barriers also lost capture.  Those failures rule out a
  widespread phase correction, synthesized follower acceleration, and another
  attempt to regulate the anterior phase anchor.
- Relative to the replicated v40 parent recorded in inherited logs, v41 moves
  capture forward by `0.021999T`, reduces mean distance by `0.000236L`, and
  lowers projected terminal miss from `0.637713L` to `0.631929L`, while leaving
  the visible route, coherent-wake class, zero posterior hard-stop occupancy,
  roughly `13.9%` exact-rate exposure, and the low peak planar load class
  unchanged.  Four identical current replications establish repeatability, but
  the gain remains nonsemantic and closes the branch of merely retaining or
  scaling the direct terminal pulse.
- The sampled local-flow cross-stream component reaches only about `0.012U`
  near capture, whereas body-frame lateral velocity is roughly `0.50U` RMS in
  the final distance bands.  A relative-flow or slip damper would therefore
  oppose the successful body motion rather than reject evidenced ambient-wake
  advection.  The next edit must preserve that motion and use joint phase, not
  treat it as a disturbance.

## Policy hypothesis

Start from v41 and change exactly one actuator mechanism inside the established
`2.10L` terminal neighborhood.  Remove the terminal collision-course residual
from direct coupled joint acceleration.  Use its normalized body-frame sign and
magnitude only to attenuate the existing posterior carrier on the observed
lagged-wave half-cycle opposed to the requested turn.  Leave the aligned
half-cycle, anterior state-feedback oscillator, posterior lag, route steering,
cadence, predicted-miss corridor, stroke braking, posterior coast guard, and
all far behavior unchanged.  This is a veto of already-generated carrier
effort, not a new acceleration source.

The test asks whether a target-derived average turning moment can be obtained
by asymmetric posterior work while retaining the productive traveling bend.
On reconstructed v41 states the source residual is terminal-local and bounded;
the new gate must be exactly zero at and beyond `2.10L`, mirror equivariant, and
unable to increase carrier amplitude.  Post-exit CFD should retain capture and
the coherent wake while producing a meaningfully straighter or earlier terminal
intercept than the direct-pulse family.  Reject it if capture is lost, the far
route changes, posterior hard-stop occupancy returns, command/load/rate classes
regress, or the result is another same-hook perturbation without a semantic
gain.  No same-worker CFD result is claimed.

bookshelf_consulted: true
source_domain: asymmetric robotic-fish turning and sensor-modulated coupled-oscillator control
source_mechanism: half-cycle amplitude asymmetry creates a turn by changing posterior work allocation while preserving a traveling body wave
transferable_invariant: infer beat side from observed joint state and use a bounded target-derived request to withdraw effort only from the half-cycle that opposes the requested turn
nontransferable_details: published gains, dimensional cadence, prescribed duty ratios, robot or species kinematics, full-body waveforms, exact vortex phases, Strouhal targets, capture geometry, and task-specific routes
policy_translation: retain v41's normalized body-frame predicted-miss residual, but replace its direct joint-acceleration pulse with mirror-equivariant attenuation of the opposed lagged posterior carrier half-cycle inside the established terminal gate
falsification: reject if the edit changes commands outside 2.10L, increases posterior carrier magnitude, loses capture or coherent self-propulsion, restores hard-stop loading, worsens rate or load class, or merely reproduces the same terminal hook without meaningful improvement

## Pre-evaluation validation

- Pure-function reconstruction over all `4480` completed v41 states returns
  finite actions.  Relative to v41, v42 changes `399` same-state outputs, first
  at `21.983505T` and `2.098608L`, with zero changes at or beyond `2.10L` and a
  maximum acceleration difference of `0.800660 rad/T^2`.  These are static
  locality checks, not a hydrodynamic rollout.
- The opposed-stroke relief is active on `156` reconstructed states, peaks at
  `0.163742`, and never increases posterior carrier amplitude.  An isolated
  reflected-state audit gives equal relief and opposite remaining carrier
  waves, confirming that the new allocation itself is mirror equivariant even
  though inherited route terms have their own evidenced asymmetries.
- The exact Julia public-contract probe returns two finite accelerations
  (`-14.3858335`, `0.0005062`).  The deterministic schema audit resolves all
  `87` direct `params.FIELD` references among the `89` fields returned by
  `target_policy_params()`.
- The configured check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account.  Its three prescribed no-CFD checks were run
  directly: guidance semantics passes after removing the duplicated assigned-
  parent marker from the rendered README, the exact Julia contract passes, and
  the solver editable-boundary audit passes.  No formal CFD was run.
