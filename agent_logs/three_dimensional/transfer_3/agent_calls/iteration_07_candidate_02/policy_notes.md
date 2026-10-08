# Symmetric response-release candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders,
  no prewarm snapshot, and finite capture from `12.3277 L` at about `25.11 T`.
- I inspected every combined sheet from release through capture. The top-down
  rows show self-propulsion with a coherent alternating wake through the broad
  target-directed arc, followed by a smooth curved first crossing. The usable
  oblique rows confirm a finite three-dimensional Lambda2 chain and no
  collision, boundary-exit precursor, or instability. Most oblique panels for
  the phase-selective sample are black; its numeric rollout is valid, but those
  missing panels are not evidence about its wake quality.
- The prefilled v22 closure-preview policy captures at `25.1130 T`, scores
  `-0.53006032`, and has mean distance `2.43063592 L`. Its coherent wake and
  successful route should be preserved. The sampled symmetric response-release
  policy has two deterministic copies: both score `-0.52833877`, lower mean
  distance to `2.42929378 L`, and cross at `25.1185 T`. Before `4 L`, their
  threshold-crossing times and peak speed match v22; inside `4 L` they retain
  zero acceleration incidence above `30 rad/T^2` and no joint-stop dwell.
- The phase-selective allocation also improves on v22 (`-0.52837563`, mean
  distance `2.42929836 L`) and retains its `25.1130 T` crossing, but its scalar
  and distance-integral advantage is slightly smaller than the symmetric
  response release. The sampled differences are confined to terminal
  allocation rather than the outer carrier or route.
- The assigned parent's inherited step-6 posterior-only response release is a
  concrete negative result: it retains capture but falls to `-0.53028823` with
  final distance `0.748419 L`, worse than both symmetric response release and
  v22. Preferentially restoring only posterior carrier therefore does not
  preserve the benefit of the two-joint response-conditioned allocation.

## Policy hypothesis

Replace only the prefilled v22 terminal allocation with the already evaluated
symmetric response release. Keep its closure preview, normalized body-frame
geometry redirect, carrier, curvature equilibria, limits, and all outer
feedback unchanged. Normalize the maximum current two-joint equilibrium error
by the declared carrier amplitude; retain the full damped curvature allocation
while the requested bend is unsettled, then recover a bounded share of the
same mean-centered posterior-lag carrier after both joints respond. This uses
joint state rather than time or a memorized route and avoids the failed
anterior/posterior allocation split.

The existing sampled CFD result is evidence for selecting this candidate; no
new rollout is claimed. A later evaluation should reject it if it fails to
reproduce capture near `25.1185 T`, loses the small mean-distance advantage,
changes the pre-terminal trajectory or coherent wake, or restores terminal
clipping, joint-stop dwell, or materially larger force/moment loads.

bookshelf_consulted: true
source_domain: biological C-start release and sensor-modulated robotic-fish CPG control
source_mechanism: release a strong target-relative curvature response into rhythmic propulsion only after observed joint state shows that the requested bend has formed
transferable_invariant: separate mean curvature from the traveling carrier and condition their allocation continuously on measured response rather than elapsed time or fixed phase
nontransferable_details: species-specific C-bend kinematics, published oscillator gains, dimensional cadence, full-body waveforms, exact vortex phases, and task-specific routes
policy_translation: use drive-amplitude-normalized two-joint equilibrium error to retain the closure-previewed bend while unsettled and recover one bounded carrier share around the same body-frame target curvature after settling
falsification: reject if capture or mean-distance performance regresses, the pre-terminal path changes, wake coherence is lost, or terminal saturation and load spikes return

## Non-CFD implementation audit

The candidate differs functionally from the twice-evaluated symmetric v23
policy only in its version label; all control expressions and parameter values
are identical. The mandated guidance, Julia contract, and solver-boundary
checks pass. A separate deterministic schema scan resolves all 68 direct
`params.FIELD` references in the returned 69-field object, and the full
multi-wake synthetic observation returns two finite commands inside the
declared limit. These checks establish contract equivalence and boundedness,
not a new coupled-flow result.
