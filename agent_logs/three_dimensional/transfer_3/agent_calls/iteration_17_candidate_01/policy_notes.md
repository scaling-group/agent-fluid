# Reproduced intercept-corridor response release

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window dynamics, and capture at `25.118523 T` from
  `12.327720 L`. Two byte-identical intercept-corridor policies independently
  reproduce the best score `-0.5280772274`, mean distance `2.429087214 L`, and
  final distance `0.746135294 L`. The force-vetoed intercept composition is
  slightly worse at `-0.5280778498` and `0.746135950 L`; the assigned prefill,
  which force-vetoes a course-angle release, is worse again at
  `-0.5280861775` and `0.746144712 L`. All cross the capture threshold on the
  same solver step, so these are terminal-response differences, not new paths.
- I inspected the complete combined top-down vorticity and oblique Lambda2
  sheets for the best reproduced intercept policy, the assigned prefill, and
  the inherited informative mean-bend-unloading regression. Each fish is
  self-propelled rather than advected: a coherent alternating wake develops
  behind the posterior body, follows the same compact target-directed arc, and
  subsides into a quiet held-bend glide near capture. There is no visible loop,
  collision, domain-exit precursor, out-of-plane instability, or wasteful
  terminal thrashing. The sheets are visually indistinguishable at their
  resolution, so telemetry rather than vortex appearance ranks the terminal
  mechanisms.
- Telemetry supports preserving the outer controller and using predicted miss
  only as an achieved-intercept response. In the best policy's `1.6 L` band,
  speed remains about `0.650 L/T`, constant-velocity cross-track miss contracts
  monotonically from about `0.685 L` to `0.228 L`, terminal action maxima are
  only about `0.09772/0.24610 rad/T^2`, and there is no joint-stop dwell or
  command above `30 rad/T^2`. The inherited mean-bend-unloading regression
  retains the same visible wake and capture step but worsens score to
  `-0.5295582789`, mean distance to `2.430256795 L`, and final distance to
  `0.747692645 L`; lower command/load alone therefore does not justify changing
  shared mean curvature.
- The assigned-parent logs predicted that combining the intercept corridor
  with an adverse-force veto would preserve the intercept benefit while
  reducing load. The completed combination is active but instead regresses by
  about `6.22e-7` in score and `6.56e-7 L` in final distance relative to both
  reproduced intercept-only rollouts. This is small but deterministic evidence
  against stacking that veto in the same optional terminal-release branch.

## Policy hypothesis

Promote the twice-reproduced intercept-corridor policy as the single candidate.
Preserve its state-feedback oscillator, posterior lag, target-angle redirect,
closure preview, two-joint mean-curvature equilibrium, helpful-crossflow
response gate, coupled carrier release, and command limits. Use normalized
body-frame target and velocity vectors to compute constant-velocity cross-track
miss, and permit no more than the inherited `3.5%` paired release as that miss
enters the compact corridor. Positive closure, late proximity, helpful
relative crossflow, and settled joint response remain mandatory independent
gates. Remove the adverse-force veto from this branch because completed
rollouts show the intercept-only mechanism is better twice, while the combined
veto adds no semantic success, earlier capture, or useful trajectory change.

This is evidence-backed promotion of one response-conditioned approach-release
mechanism, not scalar-only gain tuning. It does not alter mean bend, beat side,
joint roles, oscillator phase, or outer commands. Falsify the promotion if a
later evaluation fails to reproduce capture, changes the compact outer path,
increases predicted miss or distance, produces a terminal loop, or restores
oscillation, saturation, joint-stop dwell, force/moment growth, instability, or
wake degradation.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish rhythmic control and biological burst-response release
source_mechanism: preserve the traveling propulsive rhythm and relax corrective allocation continuously only after observed target-relative translation demonstrates an adequate intercept
transferable_invariant: a bounded redirect may be released when normalized body-frame target geometry and velocity predict a small cross-track miss under positive closure
nontransferable_details: published gains, dimensional cadence, species-specific bend envelopes, duty ratios, clock or vortex phase, exact capture radius, and task-specific routes
policy_translation: normalized body-frame target and velocity vectors form a bounded predicted-miss corridor for the inherited small coupled carrier release; proximity, closure, helpful crossflow, and settled two-joint response remain required
falsification: reject on non-reproduction, changed outer motion, increased release authority, changed mean bend or phase, delayed or lost capture, worse miss or distance, renewed joint stops or saturation, load growth, instability, or wake loss

The current candidate's CFD evaluation occurs only after this worker exits and
is not claimed as evidence here.
