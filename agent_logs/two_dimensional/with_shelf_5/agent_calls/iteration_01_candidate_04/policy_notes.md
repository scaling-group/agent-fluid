# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

The assigned parent is the deliberately target-blind two-joint oscillator, and
there are no inherited candidate-specific optimize logs in this fresh lineage.
The sole sampled rollout (`solver_0ce0f9203505`) is therefore both the best
finite example and the informative failure available for this first proposal.

The shared prewarm sheet shows four developed, interacting vortex streets and
the held fish starting well above and to the right of the target. In the
released sheet the fish initially points broadly along the target-bearing
down-left diagonal, but its oscillatory bend grows into a tight full-body curl.
It then rotates away from the target corridor and plunges toward the lower
boundary; it never enters the useful region around the second cylinder row.
This is self-propelled motion in the wrong lateral direction, not passive
advection toward the target and not a near-capture failure.

The numerical evidence agrees: the rollout terminates `left_domain` after only
`50.1269` released time, with head displacement `(-3.545, -13.300)L`, minimum
distance `8.615L`, final distance `12.123L`, and progress only `0.0243`. The
mean velocity is `(-0.0725, -0.2633)`, and both joint accelerations reach the
`1800 deg/time^2` envelope. RMS relative crossflow (`0.1747`), lateral force
(`21.94`), and moment (`541.70`) are substantial, but this rollout supplies no
evidence that their instantaneous sign should command a turn.

## Policy hypothesis

Add one controller mechanism: convert normalized body-frame target bearing
into a smooth bounded mean-curvature bias shared by both joint equilibria,
while retaining the parent state-feedback oscillator and posterior lag for
propulsion. Center the oscillatory head state around the requested bias and
apply the tail bias separately from the lagged oscillatory component so that
steering does not erase the traveling bend. Do not yet add wake-phase, force,
moment, coordinate, or time feedback.

Expected evidence is sustained motion along the target-bearing diagonal,
longer survival than the seed, and better minimum/mean distance without a
persistent hard-limit curl. Falsify the mechanism if the fish again exits on
the lower side, if target-bearing error does not visibly close, or if the bias
causes more saturation while destroying streamwise propulsion.

bookshelf_consulted: true
source_domain: biological and robotic-fish direction control
source_mechanism: bounded mean-curvature or tail-beat bias superposed on a propulsive rhythm
transferable_invariant: persistent body-frame target error should shift mean curvature while posterior phase lag continues to carry propulsion
nontransferable_details: published gains, species-specific envelopes, clocked CPG phase, exact vortex phases, and task-specific routes
policy_translation: map body-frame bearing through a bounded nonlinearity to separate anterior and posterior joint-equilibrium biases around the existing joint-state oscillator
falsification: reject if the same wrong-lateral domain exit persists, target approach does not improve, or steering destroys the traveling bend or increases saturation
