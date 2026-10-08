# Saturation-separated target-residual allocation

## Evidence and visual diagnosis before the policy edit

- The assigned parent guidance protects the center-velocity intercept terminal
  glide and identifies outer actuator coordination as the independent test
  locus. Its sampled direction-conditioned limiter is now reproduced exactly
  by three policies: each starts from verified direct-uniform still water,
  captures at `21.912008 T`, scores `-0.3246592933`, has mean distance
  `2.218947189 L`, and ends at `0.747680604 L`. This is stronger evidence than
  another terminal cadence, rate reconstruction, force veto, mean unloading,
  or joint-role change, all of which were already neutral or regressive in the
  inherited logs.
- I inspected the strongest and informative-regression combined keyframe
  sheets from release through capture, including both their top-down
  mid-plane-vorticity rows and oblique body/Lambda2 rows. Both show
  self-propulsion from quiescent flow, a compact target-directed curved path,
  coherent alternating posterior shedding, finite localized 3D structures,
  and a quiet held-bend capture. There is no visible passive advection, loop,
  collision, boundary-exit precursor, wake collapse, or instability. The
  sheets do not resolve the modest timing difference, so trajectory and load
  telemetry are the deciding evidence.
- The reproduced winner captures with no acceleration above `30 rad/T^2`
  inside `4 L`; its global force/moment maxima remain finite at about
  `0.02988/0.01558`, and its below-`4 L` maxima are about
  `0.01271/0.00713`. It nevertheless spends `1190/1757` of `3984` stored
  anterior/posterior commands above `30 rad/T^2`, so the outer saturation
  allocator is materially active while the validated terminal regime is
  separable.
- The sibling that stacked a `5%` common outward-rate attenuation on the same
  winning limiter is the informative negative result. It preserves capture
  and the visible topology but delays arrival to `22.038506 T`, regresses
  score to `-0.3276334301`, and ends at `0.748224 L`. It also does not remove
  observed rate-envelope contact (`399/414` samples above `4.4 rad/T`, versus
  `390/406` for the faster parent). Lowering both rhythmic commands when one
  joint approaches a rate boundary therefore suppresses useful propulsion
  without establishing recovery.

## Policy hypothesis

Preserve the reproduced normalized body-frame guidance, state-feedback
oscillator, posterior lag, redirect equilibrium, terminal mean bend,
crossflow/intercept support, paired terminal release, and the existing
direction-conditioned common limiter. Change only how the outer overloaded
command is composed: calculate a drive-first allocation by applying the proven
direction-conditioned limiter to the rhythmic vector before adding the already
bounded target-feedback turn residual in the remaining per-joint acceleration
envelope. Move smoothly from the reproduced combined allocation toward that
drive-first result only in proportion to the normalized overload magnitude and
direction distortion. When neither allocation is overloaded, or at and below
the `4 L` terminal boundary, the algebra is identical to the parent. This tests
a distinct residual-allocation mechanism, not another limiter gain or a
rate-headroom attenuation.

The expected benefit is that saturation can no longer erase or rotate the
slow target correction merely because it shares a command vector with the
larger rhythmic carrier, while the carrier itself retains the reproduced
anterior-to-posterior direction-preserving limit. Falsify the candidate if it
does not act on overloaded outer states, changes any command at or below
`4 L`, delays or loses capture, worsens mean distance, changes the compact
approach or terminal bend, weakens either wake view, introduces joint-stop
dwell, materially increases force/moment loads, or becomes unstable.

bookshelf_consulted: true
source_domain: sensor-modulated coupled-oscillator robotic-fish path following together with classical traveling-wave propulsion
source_mechanism: retain a coordinated rhythmic carrier while applying target-response modulation as a separately observable bounded residual
transferable_invariant: when a low-frequency target correction and a larger traveling-bend carrier share a bounded actuator, enforce the carrier's inter-joint coordination before allocating the target residual so saturation does not silently erase route feedback
nontransferable_details: published gains, dimensional cadence, species-specific kinematics and envelopes, full-body waveforms, exact phase or vortex timing, learned task routes, capture geometry, and world coordinates
policy_translation: outside the normalized terminal band, compute a drive-first direction-conditioned limit and use normalized overload magnitude and clipping-angle distortion to blend toward adding the existing body-frame target turn residual within each joint's declared acceleration envelope
falsification: reject on dormant outer behavior, terminal-command interference, slower or lost capture, worse distance integral, changed compact path or held bend, renewed joint stops, material load growth, instability, or degraded top-down or oblique wake coherence

The new candidate's CFD evaluation occurs only after this worker exits and is
not claimed as evidence here.

## Non-CFD implementation audit

- Reconstructing policy observations from the reproduced winner's stored trace
  shows that the candidate changes `2688/2928` outer states. The mean absolute
  per-joint difference is about `0.644 rad/T^2` and the maximum is about
  `3.299 rad/T^2`, while all `1056` states at or below `4 L` are bit-identical
  to the sampled parent. A separate `1620`-state terminal grid also gives zero
  difference, and a `10000`-state outer grid confirms finite output within the
  declared acceleration envelope. These are activation, boundedness, and
  noninterference checks on stored or synthetic states, not coupled-flow
  evidence.
- The deterministic schema audit resolves all `81` direct `params.FIELD`
  references in the candidate to the `82` fields returned by
  `target_policy_params()`; only the version label is intentionally unused by
  the controller algebra. The material-guidance check, finite two-acceleration
  Julia contract, and solver edit-boundary check all pass. The rendered root
  `README.md` initially marked the same assigned parent twice; removing only
  the duplicate marker allowed the prescribed guidance check to resolve the
  actual parent.
- The configured `check-runner` was invoked, but its pinned `gpt-5.4-mini`
  model is unsupported for this ChatGPT account and failed before running a
  command. Its three declared checks were therefore run directly and
  separately as reported above. No formal CFD was run in this workspace. The
  final candidate SHA-256 is
  `b9336ecaa402c04717760d32c42c8b0b0b12c56de57045beff08c4723434aa81`.
