# Multi-wake policy candidate notes

## Evidence and visual diagnosis

- The shared prewarm sheet shows the fish held at the upper-right release pose
  while the four staggered cylinders develop interacting vortex streets. This
  is a common initial condition, not evidence for any candidate.
- The sampled `8 deg` mean-curvature carrier and three terminal variants all
  reach the target in about `93.0` released time. Their released sheets show
  the same broad redirect: the fish stays near the upper-right region through
  the middle frames, then follows a long curved approach into the target. The
  amplitude envelope, bearing-rate lead, and near-target duty asymmetry do not
  create a visibly different useful trajectory.
- The prefilled posterior half-cycle candidate is materially different. Its
  keyframes show an early target-directed redirect followed by a coherent
  traveling bend and a nearly direct leftward approach through the interacting
  wakes. It reaches in `43.9505`, versus `92.99--93.03` for the otherwise
  sampled carrier variants; mean distance falls from about `4.031L` to
  `2.139L`. It preserves target success and about `0.940` progress.
- The faster rollout raises mean command effort from about `972` to `1208`,
  but its shorter episode lowers total command energy from about `9.05e4` to
  `5.31e4`; aggregate RMS lateral force/moment are also lower
  (`49.44/701.26` versus roughly `95.5/1147`). Its relative crossflow RMS is
  higher (`0.211` versus `0.168`), so the evidence does not support cancelling
  crossflow indiscriminately.
- The informative inherited failure used a larger static curvature share but
  showed little traveling bend and exited right in `16.791` with negative
  progress and mean command effort only `24.98`. Its compact failure
  keyframes are not present in this workspace, so its topology is taken only
  from the inherited evidence bank and scalar log; no finer visual claim is
  made.

## Policy hypothesis

Retain the prefilled joint-state-gated posterior half-cycle steering, because
it is the only sampled change with a semantic and topological improvement.
Remove the near-target carrier-amplitude taper: factorial prior evidence shows
that taper alone left the `93.032` capture, actuator maxima, effort, and loads
effectively unchanged. This produces a clean one-mechanism candidate and tests
whether the fast route belongs to half-cycle steering rather than an
interaction with terminal amplitude scheduling. Do not add wake rejection:
the fastest successful route tolerates more relative crossflow while reducing
distance integral and aggregate loads.

Expected evidence: preserve the early redirect and approximately direct
approach, retain target capture, and remain closer to the `43.95` arrival class
than the `93.0` class. Reject the isolation hypothesis if capture is lost, the
trajectory reverts to the slow topology, or effort/load histories materially
worsen; that would show the amplitude envelope interacts with the half-cycle
mechanism despite its near-null effect on the parent carrier.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning control
source_mechanism: bounded asymmetric flapping strengthens the target-favored half-cycle while retaining a propulsive rhythm
transferable_invariant: separate rhythmic propulsion from steering by using observed oscillator side and body-frame target error to allocate more posterior action to the useful half-cycle
nontransferable_details: published gains, clock phase, robot morphology, species kinematics, prescribed frequencies, vortex phase, and task-specific routes
policy_translation: use normalized body-frame bearing for the bounded turn request and anterior joint state for the phase gate, then shift only the posterior joint target while preserving the empirically demonstrated state-feedback carrier
falsification: reject if the isolated half-cycle controller loses capture, returns to the approximately 93-time route, destroys the traveling bend, or raises effort or load without improved progress
