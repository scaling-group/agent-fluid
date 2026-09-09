# Step 37 target-policy diagnosis

## Evidence read before the edit

- All sampled and inherited evaluations used direct uniform still-water
  initialization at `U_infinity=(0,0,0)`, without cylinders or a prewarm
  snapshot. The four sampled solvers capture at `0.7492--0.7499L`; the best
  sampled score is `-0.14991` at `18.6560T`.
- The combined top-down and oblique sheets for that best capture and the newest
  inherited failure both show self-propulsion. The capture lays down a coherent
  alternating vorticity street and bilateral Lambda2 structures through the
  target crossing. The failure retains the traveling motion and an organized
  wake through closest pass, then sharply redirects below the target and keeps
  swimming toward the lower boundary. There is no collision, numerical
  instability, or passive advection to repair.
- The assigned parent's outer-terminal bearing qualifier missed at `1.1846L`.
  A sampled sibling exact repeat also missed at `1.4731L`, despite its one
  sampled `0.7499L` capture. The qualifier therefore has no robust semantic
  advantage that justifies replaying or scalar-tuning it.
- The newest inherited progress-loss burst redirect also retained the lower
  exit: minimum distance improved only from `1.1846L` to `1.1608L`, final
  distance was `9.8423L`, and the run stayed stable. Its lower head/tail action
  clipping (`53.1%/51.0%`) did not produce recovery or capture. Moreover, the
  policy requested `state.window_closing_speed_L`, but the released observation
  schema exposes only `closing_speed_L`; its fallback was therefore the
  instantaneous one-step signal, not the eight-row discriminator claimed by
  its offline replay. This invalidates that selectivity argument and rejects
  another post-pass mean-curvature response.
- Before the first `2.75L` crossing, the relevant captured speed-reserve and
  bearing-qualified traces have normalized projected misses of about
  `0.60--0.88L`, whereas the three current inherited lower-exit traces are
  already at `1.37--1.95L`. The current response-release guard cannot use that
  separation at the crossing because its distance blend is exactly zero there;
  it only grows between `2.75L` and `2.0L`. The failures still approach at
  `0.82--0.91L/T` and keep the correct saturated course-command sign, so this
  is a release-certification problem rather than weak propulsion or route gain.

## Candidate hypothesis

Preserve the evaluated posterior-lagged carrier, raw achieved-course feedback,
additive head/tail steering shares, LOS safeguard, and sparse outward-only
speed reserve. Replace the delayed distance blend in the turn-response release
with a continuous capture-corridor certificate throughout the existing
terminal region: correct-sign yaw may reduce steering only while the normalized
target/velocity projection is inside the `0.75L` capture corridor and the
velocity still points toward the target. The certificate reaches full release
only with an inward projection margin; it does not create a new route command,
change cadence, suppress the carrier, or act outside the existing terminal
response gate.

This tests a feedback mechanism, not a gain sweep. Falsify it if an exact
sample-like approach loses capture, if the lower branch remains, if full
steering outside the certified corridor worsens clipping or speed residence,
or if either wake view, terminal speed, force, or moment leaves the sampled
speed-reserve envelope.

bookshelf_consulted: true
source_domain: sensor-feedback robotic-fish direction tracking over a rhythmic locomotor carrier
source_mechanism: response-conditioned steering release while the propulsive rhythm remains independently active
transferable_invariant: observed turn response alone is insufficient for releasing target steering; the achieved trajectory must also remain compatible with the task corridor
nontransferable_details: published gains, dimensional cadence, clocked CPG phase, robot morphology, species kinematics, exact vortex phase, and task-specific routes
policy_translation: retain the normalized body-frame achieved-course servo and two-joint traveling bend, but permit response release only when target/velocity projection and approach alignment certify a capture-compatible pass
falsification: reject if it loses sampled first-pass capture, retains the coherent-wake lower exit, increases saturation or loads beyond the baseline envelope, or weakens either wake view

## Non-CFD checks

- Counterfactual trace replay confirms this is a material intervention, not a
  claim of offline capture: mean response release inside `4L` changes from
  `0.096--0.122` to `0.041--0.062` on the three relevant sampled captures and
  from `0.023--0.038` to `0.001--0.004` on the three inherited failures. Only
  CFD can determine whether retaining that steering closes the projected miss.
- A static schema scan finds no direct `params.FIELD` reference absent from
  `target_policy_params()`, and the solver editable-boundary check passes.
- The required guidance checker cannot resolve the assigned parent because the
  rendered immutable `README.md` contains the same copied-parent marker twice;
  the material guidance diff was therefore also checked directly against
  `optimizer_d9a915c8a8d5`.
