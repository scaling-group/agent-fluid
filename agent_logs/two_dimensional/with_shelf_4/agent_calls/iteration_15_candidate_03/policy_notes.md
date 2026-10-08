# Wake-policy candidate notes

## Evidence diagnosis

- The four assigned solver samples are semantic and visual repeats of the
  progress-qualified half-cycle scaffold. Their prewarm and released keyframe
  sheets have identical hashes, and every rollout reaches the target in
  `137.357` released time with `4.184L` mean distance, `90228` total command
  energy, and `0.12955/14.75/303.02` RMS relative crossflow/force/moment.
  Treat them as a calibrated deterministic control, not four distinct policy
  mechanisms.
- The shared prewarm sheet shows the same developed, interacting four-cylinder
  streets already reaching the held fish. In the released sheet the fish keeps
  an alternating bend, becomes self-propelled upstream, enters the interacting
  wake corridor, and captures without collision or instability. The visible
  route nevertheless begins with a broad hook away from the direct approach
  before closing becomes sustained; the diagnostic maximum absolute lateral
  target offset is `4.305L`.
- The anterior acceleration already reaches `30.846 rad/time^2`, close to the
  `1800 deg/time^2` envelope, while the successful wave remains comfortably
  inside angle and velocity limits. This argues against a global oscillator or
  steering-gain increase.
- Inherited completed variants provide the informative failures absent from
  the sampled keyframe set. Bearing-divergence gating of moment rejection,
  route transfer to posterior acceleration headroom, and yaw-power gating all
  preserve capture but delay it to `149.490`, `196.317`, and `205.519`; direct
  crossflow and lateral-target residuals likewise delay capture. The candidate
  therefore preserves the direct moment residual, posterior lag, instantaneous
  bearing ownership, and zero-mean phase-dependent steering.

## Policy hypothesis

Add one bounded response-gated burst mechanism to the existing anterior
half-cycle asymmetry. When absolute normalized bearing is large and the
windowed target distance is opening rather than closing, increase the existing
half-cycle steering authority by at most 20%. As soon as positive translation
appears, the boost decays continuously to zero. This tests whether the initial
hook is insufficient route response without moving route control into the
tail, attenuating disturbance rejection, adding a route/flow residual, or
changing the cruise gait.

Expected evidence is preserved target capture and alternating propulsion with
a shorter initial hook, earlier arrival, and lower mean distance. Reject the
mechanism if it loses capture, deepens the midcourse detour, increases
saturation or force/moment/effort, or merely changes body yaw without improving
closing.

bookshelf_consulted: true
source_domain: biological burst turning and sensor-modulated robotic-fish CPG control
source_mechanism: response-gated burst redirect expressed through asymmetric propulsive half-cycles
transferable_invariant: increase bounded turning authority only while large target error lacks measured translational response, then release it continuously when response appears
nontransferable_details: species curvature, burst duration, dimensional gains, prescribed CPG phase, exact wake phase, and world-frame route
policy_translation: use body-frame bearing and normalized window closing speed to boost only the anterior state-encoded half-cycle asymmetry while retaining the posterior traveling wave and direct moment residual
falsification: reject if the 137.357-unit capture topology or alternating wave is lost, or if arrival and mean distance fail to improve without worse saturation, effort, force, or moment
