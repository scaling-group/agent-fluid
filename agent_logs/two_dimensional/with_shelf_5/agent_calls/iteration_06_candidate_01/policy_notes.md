# Multi-wake target-policy candidate notes

## Evidence-first visual diagnosis

The shared prewarm sheet shows the common held fish above and downstream of
four developed, interacting vortex streets. It is the fixed initial condition,
not candidate-specific evidence.

The strongest sampled controller and the prefill are byte-identical. Their
released sheets show an immediate targetward redirect followed by a relatively
straight, self-propelled diagonal traverse into the merged wake and the target.
They reach the `0.75L` boundary after `43.9505`, with `2.139L` mean distance.
Mean velocity `(-0.247,-0.102)` differs materially from mean local flow
`(-0.134,-0.156)`, so upstream closure is controlled swimming rather than
passive advection. In contrast, the bearing-rate alternative follows a broad
dogleg, needs `93.0266`, and has `4.031L` mean distance. Its RMS lateral
force/moment are `95.4/1146`, versus `49.4/701` for the faster controller.

The decisive difference is posterior actuator allocation: the fast policy
retains the anterior carrier but moves part of posterior steering onto the
target-favored, joint-state-defined half-cycle. The sampled clean ablation that
removes only the terminal amplitude taper still reaches in `43.9505`, with a
small score and mean-distance regression (`-0.26184`, `2.141L` versus
`-0.25925`, `2.139L`). Thus the phase-gated posterior curvature causes the
useful topology, while the taper is at most a weak refinement and is retained.

The remaining limitation is cap-dominated actuation: the fast trajectory still
reaches both joint-rate and acceleration limits and uses `1208` mean command
energy. Inherited failures rule out blunt relief. A larger static bias and a
globally slower/narrower carrier exited right within `18` time, and direct
terminal acceleration relief missed capture before becoming unstable with very
large force and moment. The new edit must therefore preserve both the early
asymmetric redirect and the restorative carrier.

## Policy hypothesis

Add one response-conditioned release to the proven posterior half-cycle
steering. Use the sign product of bounded body-frame bearing demand and the
observed bearing-window rate to distinguish an improving turn from a worsening
one. When the angular error is already shrinking, smoothly fade only part of
the target-favored posterior boost; when history is unavailable, bearing is
not converging, or the error grows, preserve the evaluated boost exactly. The
anterior oscillator, always-on curvature shares, posterior lag, approach
envelope, and all zero-bearing behavior remain unchanged.

This translates a burst-redirect-and-release invariant: establish the turn
with asymmetric tail beats, then return toward the symmetric traveling wave as
the observed response aligns the fish. Expected evidence is the same early
direct diagonal and target capture no later than the sampled `43.9505`, with
less late asymmetric action and preferably lower distance integral or
instantaneous load. Falsify it if capture is delayed or lost, the broad
`93`-time dogleg returns, the early redirect weakens, or cap/load measures do
not improve. Because the available compact evidence lacks sign-resolved wake
events, this candidate does not add force, moment, or crossflow feedback.

bookshelf_consulted: true
source_domain: biological burst turning and closed-loop robotic-fish CPG turning
source_mechanism: target-directed asymmetric tail beats followed by sensor-conditioned release into the propulsive rhythm
transferable_invariant: preserve strong bounded half-cycle steering until body-frame target error is observed to converge, then release only the asymmetric component while retaining the traveling-wave carrier
nontransferable_details: published gains and duty ratios, species or robot kinematics, dimensional timing, clock phase, exact vortex phase, cylinder coordinates, and task-specific routes
policy_translation: combine bounded bearing with normalized bearing-window rate to detect improving alignment and smoothly attenuate only the parameter-owned posterior half-cycle boost in the two-joint state-feedback policy
falsification: reject if the direct early redirect or target capture is delayed or lost, the slow dogleg returns, or saturation and load remain unchanged despite the release
