# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- All four sampled evaluations satisfy the direct-uniform still-water contract:
  `U_infinity=(0,0,0)`, no cylinders, no prewarm, and inertial moving-window
  transport. All capture, so the discriminating evidence is route efficiency,
  actuator/load exposure, and wake structure rather than termination alone.
- Both rows of every combined keyframe sheet were inspected from release to
  capture. The top-down views show genuine self-propulsion, an orderly
  alternating traveling wake, and the same late target-side hook. The oblique
  Lambda2 views retain a compact coherent three-dimensional wake. No sample
  shows passive advection, wake collapse, a boundary event, instability, or a
  moving-window rotation artifact; the images therefore do not support another
  carrier-gain or terminal-waveform edit.
- The assigned course-priority parent is duplicated by
  `solver_e07c5232a21a` and `solver_c526bc14a636`: both capture at
  `0.748591L`, `26.2405T`, with mean distance `2.518917L` and score
  `-0.616154`. The translation-side sample captures at `0.748338L`,
  `26.2460T`, with mean distance `2.518971L`. These are effectively the same
  route family and confirm the inherited negative result for further response
  arbitration and terminal scalar tuning.
- The upstream posterior course-slip sample (`solver_fb7bddf12f80`) is the one
  useful separation. It captures `0.077--0.083T` earlier, lowers mean distance
  to `2.509866L`, improves the score to `-0.607211`, and improves distance at
  `8/16/24T` to `10.4512/6.1888/1.8102L` from the translation-side sample's
  `10.4619/6.2320/1.8911L`. Its terminal crossing remains shallow
  (`0.748361L`) and its sheet retains the same coarse late-hook topology, so
  this is evidence for earlier course acquisition, not added capture clearance.
- That improvement has a bounded cost: maximum joint angle/rate/action remain
  below the hard envelope (`0.7690 rad`, `4.5134 rad/T`, `29.7231 rad/T^2`),
  but peak planar force rises from `0.018834` to `0.019441` and peak yaw moment
  from `0.009789` to `0.009868`. The inherited force-commutated anterior
  residual also failed to improve the common route. Together these observations
  support preserving the successful posterior allocation while testing whether
  measured hydrodynamic response can redistribute it across the beat, not
  adding another anterior residual or simply increasing its scalar strength.

## Policy hypothesis

Start from the sampled upstream course-slip policy. Preserve its target/course
geometry, traveling-bend carrier, translation-consistent line-of-sight response,
posterior capture term, and all feasibility guards. Add one compact response
mechanism to the evidenced upstream posterior vectoring: route geometry still
chooses the side and magnitude envelope, while normalized body-frame
velocity/force cross response smoothly shifts a small fraction of that same
tail-vectoring authority from hydrodynamically helpful phases to adverse
phases. Zero force reproduces the sampled vectoring exactly, the modulation is
bounded about unity, and all existing startup, course-slip, closing, redirect,
and late-distance gates remain in force.

The falsifiable expectation is to retain the earlier course acquisition and
capture while lowering mean distance or arrival time without exceeding the
sampled `0.019441/0.009868` force/moment exposure or changing the coherent wake.
Reject the mechanism if it loses capture, returns to the `2.519L` mean-distance
cluster, raises loads or actuator exposure, or only changes the milliscale
terminal crossing. A rejection would close force-commutated steering through
both anterior and posterior allocations for this still-water carrier; later
workers should then test a slower course-response observation rather than tune
the force scale or tail-vectoring amplitude.

bookshelf_consulted: true
source_domain: Lighthill elongated-body reactive propulsion and wake-interaction feedback control
source_mechanism: preserve the posterior traveling-wave thrust mechanism while separating slow route selection from fast hydrodynamic-response modulation
transferable_invariant: target geometry selects the route, while bounded measured fluid response redistributes posterior authority toward phases that are failing to rotate the translational course correctly
nontransferable_details: published gains, dimensional frequencies, species envelopes, robot linkage geometry, exact vortex phases, and prescribed routes
policy_translation: use normalized body-frame velocity-to-target geometry for course side and a bounded velocity-cross-force signal to modulate the already evidenced posterior target shift outside the late approach corridor
falsification: reject on lost or slower capture, loss of coherent three-dimensional propulsion, return to the prior mean-distance cluster, any actuator contact, or force and moment above the sampled posterior-vectoring envelope

## Non-CFD implementation audit after the policy edit

- The candidate differs from the sampled course-slip policy only by two owned
  response parameters and the bounded force-response factor on its existing
  posterior target shift. With zero body-frame force, a deterministic
  `20,000`-state comparison reproduces the sampled policy exactly. Across the
  same finite-state stress grid, `4,401` states exercise the new response,
  maximum command separation is `0.6522 rad/T^2`, every command is finite and
  within `30 rad/T^2`, and paired lateral reflections have zero numerical
  command error.
- Reconstructing policy inputs from all `4,757` rows of the sampled
  posterior-vectoring trace changes `1,799` post-guard command pairs, including
  `1,321` above `0.01 rad/T^2`. Activation spans about
  `0.044--21.780T` and `12.340--3.002L`, then becomes exactly inactive inside
  the inherited `3L` late corridor. Maximum reconstructed command separation
  is `0.4954 rad/T^2`, while peak candidate command remains the sampled
  `29.7231 rad/T^2`. This verifies bounded, material, upstream activation; it
  is not CFD evidence of improvement.
- The prescribed check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unavailable on this account. Its three exact checks were therefore run
  directly. The guidance check first exposed a duplicated assigned-parent
  marker in the rendered `README.md`; removing the duplicate repaired it.
  Guidance semantics, the lightweight Julia policy contract/schema, and the
  solver editable-boundary check then pass. No formal CFD was run.
