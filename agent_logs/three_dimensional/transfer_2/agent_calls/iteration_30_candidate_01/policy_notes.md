# Response-released carrier-reversal candidate

## Evidence and visual diagnosis before editing

- All four sampled episodes are valid direct-uniform still-water releases:
  `U_infinity=(0,0,0)`, no cylinders or prewarm, stable finite moving-window
  transport, and capture. There is no termination failure in this batch, so
  the predictive rate barrier is the informative semantic regression rather
  than grounds for inventing a different route.
- I inspected both rows of the combined keyframe sheets from release through
  capture for the best sample `solver_3fdd63b3fbda`, the lowest-score sample
  `solver_3cd7c6486ead`, and the prefilled load-aware sample
  `solver_df7e79c50e02`. Each top-down row starts in blank quiescent water,
  develops a compact alternating caudal wake, and follows a continuous arc
  toward the target. Each oblique row shows coherent three-dimensional
  Lambda2 structures shed behind the body. The motion is self-propelled, not
  advected, and none shows collision, wake collapse, domain exit, or numerical
  instability. The slower barrier advances less by its final sheet without a
  visibly cleaner trajectory or wake class.
- Trace metrics establish the useful baseline and its boundary. The exact
  redirect-priority controller repeats at `16.044--16.093T`, distance integral
  `1.82409--1.82848L`, and score `0.05428--0.05824`; its fastest run crosses
  `10/8/6/4/2/1L` at `5.863/7.838/9.779/11.726/14.201/15.604T`. It does so
  with coherent wakes and zero residence above 90% of either angle limit, but
  with head path `13.091--13.178L`, peak planar force/yaw moment
  `0.03579--0.03634/0.01770--0.01794`, and anterior/posterior residence above
  90% rate of about `17.76--17.81/8.12--8.24%`.
- The sampled protection mechanisms do not justify scalar tuning. The
  predictive barrier reduces path and peak load to `12.528L` and
  `0.03001/0.01495`, but regresses to `17.418T/1.93044L/-0.04522`. The
  load-aware prefill captures at `16.258T/1.83377L`, slightly lengthens path to
  `13.191L`, and changes peak load and greater-than-90%-rate residence only to
  `0.03500/0.01755` and `17.49/7.85%`; sub-`2L` yaw rises from `0.0943` in the
  fastest baseline to `0.1282 rad/T`. Productive thrust and deliberate turn
  load therefore cannot be treated as generic overload on this release.
- The assigned-parent guidance and inherited logs add a complementary result:
  unconditionally preserving negative carrier-work reversal reduced path,
  peaks, and sub-`2L` yaw to `12.269L`, `0.03050/0.01564`, and
  `0.0244 rad/T`, but slowed capture to `17.413T/1.94829L`. This supports a
  response-conditioned authority handoff, not global reversal preservation.

## One-candidate policy hypothesis

Start from the evaluated redirect-priority controller and preserve its
corrected body-frame target geometry, course redirect, distance/closing
relief, joint-state oscillator, half-cycle steering, posterior handoff,
carrier/steering decomposition, and bounded two-acceleration contract. While
the body-frame course redirect lacks same-sign measured yaw response, retain
the evaluated common scale on the full carrier so steering has priority. As
aligned yaw response appears, continuously restore only the negative-work
carrier components that reverse each joint; keep positive-work carrier and
target-conditioned steering unchanged. This is an observation-driven release
from burst redirect into the traveling bend, with no clock, hidden stage,
load threshold, terminal gate, or scalar gait tune.

Expected signature: retain the redirect baseline's early milestone and
capture class while moving path, peak load, rate residence, and terminal yaw
toward the reversal-preserving result. Falsify the mechanism if capture or
either coherent wake view is lost; if timing or distance integral regresses
toward the `17.41T/1.95L` class without a material path/load/rate benefit; or
if joint margin, commands, terminal slip/yaw, path, force, or moment exceed
the sampled redirect-priority envelope. The candidate CFD result occurs only
after this worker exits and is not claimed here as evidence.

bookshelf_consulted: true
source_domain: fish C-start burst redirection, sensor-modulated robotic-fish CPG control, and slender-body reactive traveling-wave propulsion
source_mechanism: prioritize strong curvature until measured directional response appears, then release into coordinated anterior-to-posterior rhythmic propulsion
transferable_invariant: use observed signed turn response to hand authority continuously from directional steering back to phase-coherent joint reversal
nontransferable_details: species-specific C-start kinematics, published gains and cadence, full-body waveforms, dimensional load scales, exact vortex phase, and task-specific routes
policy_translation: while normalized body-frame course error is unfulfilled, scale the full two-joint carrier; as recent yaw aligns with the bounded turn request, restore only negative carrier-work reversal while leaving steering residuals unchanged
falsification: reject if early progress or capture regresses without lower path, load, rate residence, and terminal yaw, or if wake coherence, joint margin, or the bounded action contract deteriorates
