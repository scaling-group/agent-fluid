# Wake-policy candidate notes

## Prior-evidence diagnosis

The only sampled rollout is the common naive seed, so it is simultaneously the
best finite example available and the informative failure; no successful or
near-capture comparator is present in this fresh lineage. The shared prewarm
sheet shows the fish held above and downstream of four developed, interacting
vortex streets. After release, the episode sheet shows a coherent traveling
bend and substantial self-propelled motion, but the path does not correct
toward the target. It initially reduces distance from about `12.82L` to
`8.61L`, then yaws into a steep downward trajectory and exits the lower domain
after only `50.13` released time units. This agrees with the metrics: head
displacement is `(-3.55L, -13.30L)` although the target displacement is about
`(-12L, -4.5L)`, final distance returns to `12.12L`, mean local crossflow is
large and downward (`-0.241U`), and RMS moment is `541.7`. The seed already
reaches the acceleration cap and has a posterior lag, so scalar drive increases
would not supply the missing task-direction feedback and could worsen the same
exit topology.

## Candidate hypothesis

Preserve the evidenced propulsive oscillator and posterior lag, and add one
bounded mean-curvature mechanism driven by the dimensionless body-frame target
bearing. Apply the same-sign bias to both joint accelerations, with lower
posterior steering share, so the oscillator remains a traveling bend rather
than becoming a static curl. A smooth `tanh` map should give weak corrections
near alignment and bounded authority after wake-induced heading loss. This
candidate is falsified if it retains the steep lower-boundary exit, reverses
the correct initial turn, loses the seed's leftward propulsion, or replaces the
oscillation with persistent acceleration saturation. The formal CFD result is
not available to this worker and is not claimed here.

bookshelf_consulted: true
source_domain: robotic-fish CPG direction tracking and mean-curvature turning
source_mechanism: sensor-driven bounded offset superposed on a propulsive rhythm
transferable_invariant: persistent body-frame target error should bias mean curvature while retaining posterior-lagged oscillation
nontransferable_details: published gains, duty ratios, species kinematics, dimensional frequencies, exact vortex phases, and source-task routes
policy_translation: map dimensionless body-frame bearing smoothly to bounded same-sign acceleration biases at the two joints while preserving the seed oscillator and lag
falsification: reject if target progress or leftward displacement degrades, the same lower-domain exit remains, or steering creates sustained saturation instead of a useful curved trajectory
