# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts report `uniform_direct` initialization with zero
  background velocity, reach the `100T` horizon, and remain numerically stable.
  Their top-down mid-plane rows show sustained alternating red/blue shedding;
  their oblique Lambda2 rows show a coherent three-dimensional wake following
  the freely swimming body. The fish is therefore self-propelled rather than
  advected, and propulsion failure does not explain the miss.
- `solver_6eb170b0d70a` is the strongest finite mechanism even though its scalar
  score is not the highest: its compact return loop reaches `1.241L`, enters
  `1.25L` for about `0.47T`, and finishes at `2.082L`. At its minimum it still
  moves at `0.669U` with target-ray/course error `1.692 rad`, and the anterior
  oscillator is active (`phi_dot1=-0.260 rad/T`, normalized phase-plane
  activity `0.110`) with small unclipped commands. Across samples inside `3L`,
  its median anterior activity is `0.699` and only `1.4%` is below `0.12`.
- The assigned parent `solver_b5de8ff4a388` replaces the course-hold C-turn's
  lateral redirect direction with a rear-crossing selector. Its top-down and
  oblique sheets instead show the same broad powered orbit as the weaker
  restart/release descendants: minimum/final distance regress to
  `2.366/3.502L`, while the joints settle near a common negative C-bend with
  almost zero velocity and command. Inside `3L`, normalized anterior activity
  is below `0.12` for `92.0%` of samples. The one-sided restart
  (`solver_2cc56ad90762`) and equilibrium release (`solver_a6820a0af3d7`) also
  remain quiet for `88.4%` and `85.4%`, reaching only `2.369L` and `2.215L`.
  This cross-check makes low alternating activity a discriminator, but those
  failures show that a directional nudge or mean-shift is not an established
  remedy.

## Policy hypothesis

Restore the sampled `solver_6eb170b0d70a` terminal course-hold scaffold exactly
and add one new mechanism: a bounded, low-activity phase-plane energy regulator
on the anterior oscillator. It is active only under the existing target-behind
terminal response gate, multiplies the measured anterior joint velocity, and
therefore adds energy in whichever half-cycle is already occurring without
selecting a stroke side or moving either steering equilibrium. Posterior lag
and wave target remain unchanged. This should preserve the evidenced first
recovery and coherent traveling wake, prevent the brief terminal activity dip
from becoming a parked C-bend, and give the `1.241L` return enough continuing
alternation to cross `0.75L` or improve its near-target/final statistics.

Reject the mechanism if it changes the first recovery, leaves a quiet common
C-bend, degrades anterior-to-posterior wave propagation, raises clamp or load
residence, or fails to improve near-target and final-distance behavior. The
new CFD outcome is not available to this worker and is not claimed here.

bookshelf_consulted: true
source_domain: classical traveling-wave propulsion and robotic-fish CPG control
source_mechanism: state-feedback limit-cycle energy restoration while retaining a lagged posterior traveling wave
transferable_invariant: steering should not replace the nonzero alternating phase-plane motion that sustains a posteriorly lagged propulsive wave
nontransferable_details: published oscillator gains, species-specific envelopes and frequencies, full-body kinematics, exact wake phase, and prescribed routes
policy_translation: use normalized anterior joint position and velocity about the existing body-frame steering equilibrium; under the existing terminal geometry gate, add bounded velocity-aligned energy only when phase-plane activity is low, while leaving mean curvature and posterior lag unchanged
falsification: reject if the first recovery moves, the common quiet bend persists, the traveling wave or wake coherence degrades, command/load residence rises, or minimum and final target distances do not improve
