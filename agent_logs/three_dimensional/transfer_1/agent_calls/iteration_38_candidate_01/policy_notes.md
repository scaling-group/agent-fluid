# Step 38 target-policy diagnosis

## Evidence read before candidate selection

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. They capture at
  `0.74923--0.74986L` after `18.4525--18.7495T`. In the best-scoring
  outer-terminal qualifier and the slowest anterior-transfer capture, the
  top-down row shows a persistent alternating vorticity street and the oblique
  row shows organized bilateral Lambda2 structures from release to capture.
  The fish is self-propelled rather than advected, and neither view supports
  replacing or suppressing the posteriorly lagged traveling carrier.
- The assigned parent is an exact-byte replay of the prefilled speed-reserve
  baseline (SHA `567de354e2bf646dce0776b20e284aabc896c7816eafff848839efa2937b9dac`).
  Contrary to its three inherited and two current sampled captures, this
  direct-uniform replay passes at `1.02599L`, exits the lower boundary, and
  finishes at `11.14865L`. Its top-down and oblique rows retain the organized
  carrier wake through the first pass and after departure, so the failure is
  terminal interception geometry rather than advection, instability, weak
  propulsion, or carrier collapse.
- Offline reconstruction from the exact production observations shows a
  pre-pass discriminator rather than only a post-pass progress signal. Below
  `1.25L`, every assigned-parent row has adverse signed LOS rate
  `max(-turn_command*inertial_los_rate,0)>0.18` and mean normalized
  target/velocity approach alignment `0.226`. Across the four captures, mean
  alignment over the same range is `0.622--0.791`; the adverse-LOS plus
  alignment-below-`0.75` condition occupies `36--60%`, not `100%`, of rows.
  At the failed run's `1.25L` crossing, signed LOS miss is about `0.63` and
  alignment about `0.37`, while the two exact-baseline captures have signed
  LOS miss about `0.01/0.04` and alignment about `0.99`. The current
  intercept guard observes these quantities but can only veto steering
  release; it cannot add a redirect when full baseline steering is already
  geometrically insufficient.
- The inherited post-pass symmetric burst engaged only after its closest pass
  and did not recover. The corridor-certified release worsened the pass to
  `1.6783L`; fixed anterior/posterior transfer and a bearing qualifier each
  have only isolated captures and failed or slower repeats. This rules out
  another release veto, post-pass burst, fixed allocation, or scalar cadence
  edit as the present test.

## Candidate hypothesis

Retain the exact intercept-guarded speed-reserve controller, including raw
achieved-course feedback, sparse outward-only carrier relief, fixed baseline
steering shares, and the active posterior lag. Add one pre-pass
response-gated redirect: inside `1.60L`, smoothly add bounded anterior-joint
steering only when the current turn request has an adverse inertial LOS rate
and target/velocity approach alignment is poor. The product gate must release
when either LOS response or alignment recovers. The posterior joint receives
no redirect so its evaluated traveling-wave role remains unchanged.

This should intervene before the assigned parent's first minimum while being
intermittent or absent on capture-compatible phases. It is a new response
architecture, not a claim of offline capture. Falsify it if the lower pass
remains, any sampled-like first pass loses capture, the redirect becomes a
persistent static bend, the top-down or oblique wake weakens, or clipping,
joint-speed residence, force, or moment leaves the inherited repeat-backed
envelope.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-feedback robotic-fish direction tracking
source_mechanism: response-gated redirect superposed on a separately sustained rhythmic carrier
transferable_invariant: a bounded redirect should engage from an observed adverse trajectory response before the miss and release as useful target response returns without replacing the propulsive wave
nontransferable_details: species-specific bend angles, published gains, dimensional burst timing, clocked CPG phase, robot morphology, exact vortex phase, and task-specific routes
policy_translation: combine normalized body-frame LOS divergence and target/velocity approach alignment to gate a bounded anterior-joint acceleration residual inside terminal range while preserving the posterior-lagged two-joint carrier
falsification: reject if it cannot improve the exact-baseline lower pass, perturbs capture-compatible closure, creates persistent curvature, weakens either wake view, or worsens actuator and load metrics beyond the established envelope

## Non-CFD checks

- Counterfactual replay over the saved trajectories confirms that the strict
  product gate is selective and material, not that the unevaluated policy will
  capture. Its integrated activation is `0.597T` on the assigned-parent miss,
  versus `0.020/0.112T` on the two exact-baseline captures and
  `0.227/0.235T` on the two different-policy captures. The failed replay has
  141 active rows before its closest pass, compared with 24 and 50 for the
  exact-baseline captures. The redirect stays within its configured
  `6 rad/T^2` bound.
- Static inspection finds every direct `params.FIELD` reference in the returned
  parameter tuple. The exact lightweight Julia contract check passes with the
  workspace-documented Julia 1.12.6 binary, including finite two-joint output;
  the guidance semantic-difference and solver editable-boundary checks also
  pass.
