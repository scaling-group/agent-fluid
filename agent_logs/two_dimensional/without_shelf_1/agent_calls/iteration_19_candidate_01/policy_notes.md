# Wake-policy diagnosis and candidate hypothesis

## Evidence read before editing

- The four supplied examples are not four control experiments. Their released
  keyframe sheets are byte-identical and their policies differ only in
  comments. Every example reaches the target after `88.129` release units with
  mean/final/minimum distance `2.736/0.747/0.747L`, head displacement
  `(-10.925,-4.435)L`, progress `0.940`, and the same effort and load metrics.
  They establish one deterministic successful anchor and no local gain
  gradient.
- The shared prewarm sheet shows the held fish outside the four developed,
  mutually interacting cylinder streets. The released sheet then shows the
  fish self-propelling diagonally from the far upper-right, entering the mixed
  wake corridor, making a broad bend, and turning through the target circle
  without collision or domain exit. This is not passive advection: mean head
  velocity in x is about `-0.124`, more upstream than mean local flow
  `-0.092`, while the net y displacement nearly supplies the required
  diagonal correction.
- The successful route remains dynamically expensive. Diagnostics report
  posterior angle exactly at `45 deg`, both joint rates at `260 deg/time`, both
  commands at the candidate `1650 deg/time^2` ceiling, RMS relative crossflow
  `0.289`, RMS force `445`, and RMS moment `4597`. The sharp body curvature in
  the last two keyframes agrees with those maxima. Consequently this rollout
  validates capture, not actuator desaturation or load robustness.
- No informative failure keyframe is present in the sampled batch. The
  inherited failure boundary is therefore the comparison: weakening or
  gating the static posterior request lost propulsion without changing the
  upper hook, global opposition boost `0.55` collapsed approach, and
  bearing-rate or lateral-velocity damping did not remove saturation. Those
  mechanisms should remain untouched.

## Single candidate hypothesis

Keep the complete sampled controller and increase only `cross_track_gain` from
`0.18` to `0.20`. At the initial roughly `1.9L` body-frame lateral target
offset, the bounded cross-track term is already active but this change adds
only about `0.015` to the normalized steering request; it is a local
perturbation rather than a new route or a global posterior-gain increase. The
falsifiable expectation is an earlier, tighter diagonal correction that lowers
arrival time or distance integral while preserving first-crossing capture.
Reject the increment if capture is lost, the broad hook grows, or force/moment
loads rise without a shorter route. Because the formal CFD run occurs only
after this worker exits, this file records a hypothesis rather than claiming
an improvement.
