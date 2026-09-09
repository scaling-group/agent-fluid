# Candidate diagnosis and hypothesis

## Visual and metric diagnosis

- Every sampled rollout and the inherited parent log report direct uniform
  still-water initialization with `U_infinity=(0,0,0)`. In both rows of the
  combined sheets the fish self-propels: the top-down view develops a sustained
  alternating vortex street and the oblique view shows compact three-dimensional
  Lambda2 structures attached to a long traveled path. There is no imposed-flow
  advection, wake collapse, collision, or numerical instability to repair.
- The alignment-gated carrier (`2.443L` minimum, `8.443L` mean), joint-phase
  counterbend (`2.512L`), assigned parent's response-released posterior S-bend
  (`2.536L`), and measured-yaw brake (`2.385L`, `8.436L` mean) look nearly
  identical at the `8T`, `16T`, `24T`, and terminal sheets: after a coherent
  diagonal approach, each rotates onto a powered near-vertical lower leg and
  exits the lower boundary near `31T`. Thus the small scalar spread does not
  represent a different useful trajectory.
- The inherited posterior-authority reallocation sharpened the minimum only
  from `2.385L` to `2.375L`, but worsened mean distance from `8.436L` to
  `8.460L` and retained the same `left_domain` termination. At minimum distance
  its wrong-way measured yaw was about `2.330 rad/T`, versus `2.185 rad/T` for
  the brake, while both retained roughly `0.7U` translational speed. Redirecting
  one selected posterior half-cycle therefore did not create the sustained
  course change needed for capture.

## Policy hypothesis

Preserve the alignment-gated traveling-wave carrier and its far-field behavior.
During the already evidenced close, poorly closing, large-direction-error
regime, trade a bounded part of the anterior oscillator's angle envelope for
additional target-signed mean curvature. Release this reserve continuously when
the body-frame bearing window shows corrective response. Unlike prior tests,
this changes the slow anterior turning action while leaving the posterior mean
free of another same-sign C-bend, brake, or half-cycle reallocation. The reduced
local oscillation amplitude keeps the combined anterior mean-plus-wave target
inside the `45 deg` joint envelope. The hypothesis is falsified by degraded
far-field progress or wake coherence, increased actuator-limit residence, a
minimum no better than `2.385L`, or the same powered lower-exit trajectory.

bookshelf_consulted: true
source_domain: biological rapid-start turning and closed-loop robotic-fish CPG control
source_mechanism: response-released burst redirect with bounded rhythm modulation
transferable_invariant: temporarily exchange oscillatory joint envelope for target-signed curvature when large body-frame error persists, then restore the propulsive rhythm when measured geometry corrects
nontransferable_details: species-specific C-start shape, published gains, dimensional frequency, clocked CPG phase, exact vortex phase, and prescribed routes
policy_translation: use normalized distance, full body-frame target direction, closing speed, bearing-window response, and measured anterior joint state to shift only the anterior oscillator equilibrium while reducing its local amplitude
falsification: reject if cruise wake or far-field progress degrades, saturation rises, closest approach does not beat the measured-yaw brake, or the lower-exit topology remains unchanged
