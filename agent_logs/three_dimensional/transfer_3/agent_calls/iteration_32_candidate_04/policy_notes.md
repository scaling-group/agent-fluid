# Candidate diagnosis and policy hypothesis

All four sampled episodes satisfy the evidence contract: direct uniform
initialization in still water (`U_infinity=(0,0,0)`), no cylinders, finite
capture, and both keyframe views present. The top-down rows show body-attached
alternating vorticity developing into a coherent downstream street; the
oblique rows independently show alternating three-dimensional Lambda2 packets
behind a body-led target approach. Local-flow RMS is only
`0.01808--0.01816U`, while body-speed RMS is `0.7048--0.7077U`, so these are
self-propelled captures rather than moving-window advection. No failed episode
is present in the assigned sample; the most informative adverse comparison is
therefore the lowest-scoring completed ablation.

The strongest finite sample is the plain actuator-consistent phase policy at
score `-0.132185`, capture `18.6725T`, action RMS `24.70/28.77 rad/T^2`,
acceleration-limit occupancy `40.71%/75.46%`, and force/moment RMS
`0.01331/0.00693`. Its exact-policy companion also captures at `18.6725T`
(score `-0.133625`) but spans `42.15%/76.11%` occupancy and
`0.01350/0.00703` load RMS, establishing nontrivial same-hash variation.
The prefilled raw helpful-moment allocator captures at `18.6560T`, only
`0.0165T` earlier, with `40.74%/75.74%` occupancy and
`0.01328/0.00691` loads. The carrier-demodulated moment residual is slower at
`18.6890T` and scores `-0.135248`; although its sampled occupancy/load is low,
inherited exact-policy evidence says that benefit did not replicate. All four
wake sheets remain visually coherent, so instantaneous moment allocation has
not produced a distinct route or wake mechanism here.

Policy hypothesis: remove the unreplicated raw-moment relief and recover the
exact actuator-consistent posterior-phase controller. This preserves the
normalized LOS C-bend, traveling carrier, persistent same-side phase
recruitment, reflection equivariance, and feasible-action projection while
removing a physical-response path whose apparent timing edge is smaller than
same-policy variability. The candidate is a controlled robustness recovery,
not scalar gain tuning. It is falsified if a repeat loses capture, weakens the
alternating wake in either view, leaves the inherited `18.6725--19.0080T`
capture band, exceeds `76.11%` posterior acceleration-limit occupancy, or
exceeds `0.01350/0.00703` force/moment RMS. Its conclusions are limited to
direct-uniform still water near `0.018U` local-flow RMS; external-wake
rejection remains untested.

bookshelf_consulted: true
source_domain: wake interaction and adaptive swimming
source_mechanism: separate slow target-route feedback from a minimal bounded physical-response residual
transferable_invariant: preserve a coherent propulsive route and retain fast force, flow, or moment feedback only when repeated histories show joint progress and load benefit
nontransferable_details: Karman-gait phase locking, external-vortex timing, published gains, species kinematics, and task-specific routes
policy_translation: retain normalized body-frame LOS and joint-state phase feedback, but remove the unreplicated instantaneous yaw-moment allocator from the two-joint command
falsification: reject the recovery if replicated capture, wake coherence, or the inherited occupancy and load bounds are lost
