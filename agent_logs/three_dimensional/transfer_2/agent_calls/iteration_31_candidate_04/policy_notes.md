# Command-matched redirect-response candidate

## Evidence and visual diagnosis before editing

- All four sampled episodes satisfy the frozen release contract: direct
  uniform `U_infinity=(0,0,0)` initialization, no prewarm or cylinders,
  stable moving-window transport, and `capture`. There is no termination
  failure in this cohort, so the response-residual rollout is treated as the
  informative trajectory regression rather than as grounds to invent a new
  route.
- I inspected both rows of all four combined keyframe sheets from release to
  capture. The strongest-score response-released sample
  `solver_0e3ccca5bc77` starts in blank still water, builds a compact
  alternating top-down caudal wake, follows a continuous target-directed arc,
  and retains coherent oblique Lambda2 structures behind the body. The
  response-residual sample `solver_f997a0c1ad0f` remains self-propelled and
  coherent but has a visibly longer late hook. None shows advection, collision,
  domain exit, wake collapse, or instability, so the propulsive traveling wave
  and target scaffold should be preserved.
- The two byte-identical prefill repeats capture at `16.071/16.088T`, with
  distance integrals `1.82366/1.82203L`, head paths `13.166/13.129L`, peak
  planar-force coefficients `0.03427/0.03575`, and anterior residence above
  99% of the rate envelope `12.01/11.93%`. Compared with the full-carrier
  redirect at `16.044T/1.82409L`, the response-released reversal therefore
  stays within the earlier repeat timing/integral spread and does not establish
  a repeatable path, load, or rate benefit. The response-residual redirect is
  worse in control terms despite its finite score: `16.247T`, `13.363L` head
  path, mean commands `17.34/15.82 rad/T^2`, sub-`2L` mean absolute yaw
  `0.269 rad/T`, and terminal absolute yaw `0.589 rad/T`.
- Replaying the logged body-frame observations through the sampled policy
  signals identifies a structural cause rather than a scalar-gain issue. In
  the two prefill repeats, the bounded route turn and velocity-course redirect
  have opposite signs in `18.8--19.1%` of redirect-active approach rows,
  concentrated before `4L`. Across those mismatched rows the present
  route-aligned response is identically zero on average, while the measured
  yaw is aligned with the actual redirect with mean normalized response
  `0.843--0.858` and exceeds `0.05` in at least `99.5%` of rows. Thus the
  current gate can label a successfully executing redirect as unfulfilled.

## One-candidate policy hypothesis

Keep the prefilled response-released controller's corrected body-frame target
geometry, distance/closing drive relief, course redirect, half-cycle steering,
posterior handoff, carrier/steering decomposition, rate gate, and bounded
two-acceleration contract. Separate two measured response meanings: retain
route-aligned yaw for the route-conditioned posterior wave handoff, but use
redirect-aligned yaw to release the velocity-course redirect's carrier
priority and blend the negative-work reversal handoff continuously from route
response to redirect response as redirect authority grows. Thus a negligible
redirect preserves the prefill's ordinary route-turn behavior. This changes no
gain and adds no clock, stage, load threshold, slip residual, or terminal gate;
it makes each state-feedback handoff congruent with the command being assessed.

Expected signature: preserve the direct-quiescent coherent capture class and
early progress while avoiding unnecessary carrier suppression when yaw already
follows an opposing middle-field course correction. Falsify the mechanism if
capture or either wake view is lost; if the `6/4L` milestones, capture timing,
or distance integral regress outside repeat variation; or if head path,
sub-`2L` yaw/slip, mean command, rate residence, joint margin, force, or moment
exceeds the sampled full-carrier/response-released envelope. The new CFD result
arrives only after this worker exits and is not claimed here as evidence.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and fish C-start burst redirection
source_mechanism: release a bounded directional burst when measured motion follows that burst, while retaining a coupled posterior-lag propulsive rhythm
transferable_invariant: judge a state-feedback authority handoff using signed response aligned with the specific command whose authority is being released
nontransferable_details: published gains and cadence, species-specific burst kinematics, full-body waveforms, dimensional load scales, exact vortex phases, and task-specific routes
policy_translation: use normalized recent yaw times the bounded velocity-course redirect for redirect fulfillment; retain target-route-aligned yaw for posterior allocation and weak-redirect reversal release, then blend reversal release toward redirect-aligned yaw with bounded redirect authority
falsification: reject if command matching fails to improve middle-field progress or trajectory quality beyond repeat variation, or if capture, wake coherence, bounded action, joint margin, rate residence, load, or terminal yaw/slip deteriorates
