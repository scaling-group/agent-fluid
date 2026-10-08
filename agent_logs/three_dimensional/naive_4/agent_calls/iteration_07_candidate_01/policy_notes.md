# Wake-policy candidate notes

## Pre-edit evidence diagnosis

- All four sampled rollouts satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite dynamics, and capture
  at `0.745-0.748L` after `16.258-16.291T`.
- In both the top-down vorticity and oblique Lambda2 rows, the fish is
  self-propelled along the same target-directed transit rather than advected.
  The anterior/posterior traveling bend leaves a coherent alternating wake by
  `4T`, strengthens through `12T`, and remains three-dimensionally coherent at
  capture. There is no visible wake-collapse, domain-exit, or instability
  topology to repair.
- The useful difference is confined to terminal actuation. The unmodified
  response-gated redirect captures at `16.291T` but ends at `1.109U` with both
  accelerations limited and terminal force/moment magnitudes about
  `0.031/0.016`. Redirect-priority acceleration allocation captures at
  `16.258T` and cuts whole-rollout posterior limiting from `60.4%` to `22.5%`,
  yet still ends at `1.120U` with high terminal loads. Selective approach
  damping preserves mean steering, captures at `16.258T` with the best sampled
  score (`-0.066121`), and ends at `1.047U`. The assigned parent's zero-bend
  joint hold captures at `16.269T`, ends at `1.024U`, and unloads terminal
  force/moment almost completely, but its score (`-0.066867`) is weaker than
  selective damping. Thus none of the approach laws materially brakes body
  translation over the short final interval; their evidenced benefit is joint
  and load unloading while capture is preserved.

## Policy hypothesis

Keep the assigned parent's captured transit and its distance-plus-closing gate
unchanged. During the gated hold, damp the anterior joint toward zero and damp
the posterior joint toward the already bounded target-versus-course mean
curvature instead of zero. This removes the oscillatory tail wave without
discarding terminal steering authority. It should retain the parent's low
terminal command/load behavior while matching the selective-damping variant's
earlier, lower-integral capture. Reject the mechanism if capture is lost, the
arrival is later than `16.269T`, terminal limiting/load returns toward the
unmodified redirect, or the top-down path/wake changes before the `1.2L`
approach neighborhood.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning and terminal capture control
source_mechanism: preserve a bounded mean-curvature steering channel while attenuating rhythmic propulsive drive near a reliable crossing
transferable_invariant: separate slow target-directed mean bend from the oscillatory traveling-wave component so drive relief does not erase steering
nontransferable_details: published oscillator gains, species-specific envelopes, exact tail phase, dimensional approach distances, and task routes
policy_translation: use normalized body-frame bearing, velocity-defined course, distance, closing speed, and joint state; inside the existing continuous approach gate, hold joint one at zero and joint two at the bounded mean tail tangent
falsification: reject if capture or early transit changes, arrival worsens, or posterior limiting and terminal hydrodynamic load rebound instead of remaining below the ungated redirect
