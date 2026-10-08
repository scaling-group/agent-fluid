# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled solvers terminate in capture at `25.118522644 T` with
  score `-0.5283387731`, mean distance `2.4292937801 L`, and final/minimum
  distance `0.7464101911 L`. Three contain the byte-identical v23 policy; the
  fourth differs only in its version string and comments. Their identical
  trajectories therefore provide four reproductions of one controller
  behavior, not evidence for four mechanisms.
- The direct-uniform contract is valid in every sample: `U_infinity=(0,0,0)`,
  no prewarm, no cylinders, and no instability. No sampled termination failure
  sheet is available in this workspace, so the nearest informative negatives
  are inherited completed variants: yaw-rate-error curvature scored
  `-0.528782`/`-0.529278`, convergence-gated extra carrier scored `-0.531220`,
  and the inherited logged descendants remain below the repeated baseline at
  `-0.528581` to `-0.530398` while retaining capture.
- In both the top-down vorticity and oblique Lambda2 views, the baseline is
  self-propelled rather than advected. It forms a coherent alternating wake
  over a compact target-directed outer arc. Between `24 T` and capture the
  joint carrier and near-body vortex production visibly subside; the fish
  continues on a smooth lateral-translation/turning path into the capture
  circle without collision, domain exit, joint-stop dwell, or a terminal load
  burst.
- The trajectory cross-check supports a terminal crab rather than an isolated
  yaw defect. Below `1.6 L`, normalized body-frame target lateral component is
  `0.654--0.772`, relative crossflow is oppositely signed at roughly
  `-0.279-- -0.258 U`, and seven-sample range closure is
  `0.674--0.712 L/T`. Replaying the existing controller algebra on the logged
  states shows normalized equilibrium tracking error only `0.003--0.060` in
  that band; its settled-response weight averages `0.961`. The proposed gate
  is therefore observably active rather than another dormant safeguard.

## Architecture proposal

Preserve the complete v23 outer carrier, target-angle redirect, closure
preview, mean-curvature equilibrium, and coupled two-joint response release.
Add one late response mechanism only: after actual range falls below `1.6 L`,
compute target-helpful crossflow from the product of normalized body-frame
relative lateral flow and a smooth target-side signal. When that crossflow,
positive range closure, and settled equilibrium tracking agree, reduce the
shared terminal-equilibrium allocation by at most a small declared fraction.
This releases both joints together toward the existing mean-centered carrier;
it does not add yaw authority, choose a beat phase, split joint roles, or alter
the outer path.

Expected result: commands and trajectory are exactly inherited outside the
late range gate; inside it, useful lateral translation is retained while
slightly less static curvature is imposed. Accept only if capture is retained
and score/mean distance or arrival improves without renewed command clipping,
joint-stop dwell, force/moment spikes, or loss of the coherent two-view wake.

bookshelf_consulted: true
source_domain: organized-wake fish interaction and sensor-modulated robotic-fish control
source_mechanism: preserve useful flow-induced lateral response instead of cancelling every crossflow, while modulating an existing rhythmic controller through observed state
transferable_invariant: reduce corrective actuation only when body-frame target geometry, relative crossflow, and target-range closure agree that the lateral response is useful
nontransferable_details: published gains, species kinematics, Karman-vortex phase, cylinder layout, full-body waves, and source-task routes
policy_translation: use smooth bounded functions of normalized target lateral component, `relative_flow_velocity_body_U[2]`, `window_closing_speed_L`, distance, and current two-joint tracking error to relieve the same coupled terminal equilibrium
falsification: reject if the gate changes motion outside `1.6 L`, slows or loses capture, weakens closure when helpful crossflow is absent, creates a loop, restores saturation or joint-stop dwell, increases terminal loads, or disrupts wake coherence

## Static logged-state audit after editing

The candidate and baseline were evaluated algebraically on every stored state
from the sampled trajectory (this is not a CFD rollout). The maximum command
difference is exactly `0` for `distance_L >= 1.6`. All 226 stored states below
`1.6 L` activate the new gate; the shared-allocation relief averages `0.0768`,
peaks at `0.1305` under its declared `0.14` bound, and the maximum per-joint
command difference is `0.0678 rad/T^2`. This verifies noninterference and gate
activity only; the candidate's hydrodynamic outcome remains unevaluated.
