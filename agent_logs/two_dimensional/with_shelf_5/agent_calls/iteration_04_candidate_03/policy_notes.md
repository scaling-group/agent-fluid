# Multi-wake candidate diagnosis and hypothesis

## Evidence-first diagnosis

- The shared prewarm sheet shows the common held fish above/right of four
  staggered cylinders while four developed, interacting vortex streets fill
  the target corridor; this is common initial-condition evidence, not a policy
  difference.
- All four sampled released sheets terminate at the target and show the same
  useful topology: the fish self-propels left/down on a broad target-directed
  arc, completes its main redirect before entering the strongest merged wake,
  and encounters the organized wake only on the final approach. This is not
  passive advection: for the prefill, mean body velocity is
  `(-0.1168,-0.0469)`, versus mean local flow `(-0.0394,-0.0752)`, leaving a
  substantial streamwise relative component. The route therefore depends on
  the existing traveling-bend carrier and bounded `8 deg` bearing bias.
- The strongest sampled score (`-2.119281`) and the prefill (`-2.120251`) have
  identical `93.032` arrival time, joint maxima, rate/acceleration caps, and
  visually indistinguishable trajectories. Range-gated amplitude relief,
  terminal lateral-error steering, and terminal bearing-rate lead changed
  score by less than `0.001`, while command effort stayed near `9.05e4`, RMS
  force near `95.5`, and RMS moment near `1147`. The amplitude and sensor
  blends therefore did not produce a meaningfully different terminal motion.
- Every sampled success reaches both `260 deg/time` joint-rate caps and
  `1800 deg/time^2` acceleration caps. Changing only the Van der Pol amplitude
  cannot reliably change the stiff restoring command after clipping. The
  inherited slow/narrow carrier plus global yaw-rate damping instead ended in
  unstable dynamics with RMS force/moment about `16457/157725`, so an ungated
  derivative residual is specifically contraindicated.
- No sampled solver failure keyframe is present inside this Phase 2 workspace.
  The visual comparison is therefore the strongest finite sample against the
  prefill/worst finite sample, cross-checked with the inherited unstable score
  and the assigned-parent failure lessons; external artifact paths were not
  followed outside the workspace.

## Policy hypothesis

Keep the proven `0.55`-period, `28 deg` traveling-bend carrier and bounded
target-bearing mean curvature exactly unchanged outside a normalized approach
gate. Inside the approach, introduce one new mechanism: smoothly asymmetric
half-cycle timing inferred from centered head-joint state. Prolong the half
cycle bending toward the requested turn and shorten the opposite half cycle,
with a small bounded duty modulation. Unlike another oscillator-amplitude or
bearing gain, this changes the state-feedback phase progression directly while
preserving an alternating traveling bend. It should make the final wake-region
redirect measurably different without a global rate derivative or a fixed
route. The evaluation should reject it if capture is lost or delayed, if the
pre-gate route changes, if the terminal path remains indistinguishable, or if
joint saturation and force/moment loads worsen materially.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and asymmetric flapping control
source_mechanism: sensor-conditioned half-cycle duty asymmetry for turning
transferable_invariant: preserve the propulsive rhythm while using observed turn demand and oscillator state to make the useful half-cycle last slightly longer than the opposing half-cycle
nontransferable_details: published gains, clock phase, robot geometry, species kinematics, dimensional beat frequency, and task-specific routes
policy_translation: use normalized distance and body-frame bearing to gate a bounded local-frequency asymmetry, and infer beat side only from centered head-joint angle before applying the same local frequency to the two-joint traveling-bend feedback
falsification: reject if commands differ outside the range gate, capture is delayed or lost, the terminal trajectory remains meaningfully unchanged, or saturation and force/moment loads increase
