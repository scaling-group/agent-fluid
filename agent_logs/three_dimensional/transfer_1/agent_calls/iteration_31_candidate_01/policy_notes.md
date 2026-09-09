# Step 31 target-policy diagnosis

## Evidence read before the edit

- All four sampled rollouts are direct-uniform still-water runs with
  `U_infinity=(0,0,0)`, no cylinders, and capture at `0.7480--0.7494L` after
  `18.199--18.601T`. Their combined sheets show released-swimmer advance, an
  organized alternating top-down vorticity street, bilateral oblique Lambda2
  structures, and an active beat at capture. The useful behavior is a
  self-propelled traveling bend, not advection, coasting, or a prewarm artifact.
- The assigned parent's outer-bearing rescue is the informative failure. Its
  two visual rows retain the same active carrier and finite three-dimensional
  wake, but the trajectory turns onto the recurrent lower branch, reaches only
  `1.5629L`, and exits at `32.0815T` with final distance `10.3858L`. Thus its
  direct body-frame bearing residual did not repair terminal geometry; it is
  not a coefficient to widen or tune.
- The sampled exact speed-reserve bytes capture in all three available solver
  examples while preserving the wake, whereas inherited guidance records two
  additional exact-byte lower exits, so the baseline evidence remains `3/5`
  rather than robust. The distinct fixed spatial transfer also captures, but
  arrives later and does not improve clipping or speed-limit residence.
- One inherited burden-conditioned allocation rollout provides a more useful
  mechanism test: it captures at `0.7474L` and `18.3040T` without changing raw
  achieved course, total steering authority, or the propulsive carrier. Its
  transfer is sparse and requires unsafe intercept geometry, greater posterior
  outward speed/action burden, steering that would worsen that burden, and
  anterior margin. This is a single success, so an exact-policy repeat is more
  informative than another terminal observation or gain.

## Candidate hypothesis

Use the evaluated burden-conditioned allocator as the sole candidate. Preserve
the exact speed-reserve oscillator, posterior lag, achieved-course error,
response/intercept gates, steering magnitude, and carrier relief. Only during
an unsafe terminal intercept, transfer a bounded part of the steering residual
from tail to head when normalized previous action and joint speed show that the
tail is more outward-burdened and the head has margin. The head/tail steering
shares keep the same sum.

Expected result: reproduce capture near the inherited allocator's `18.304T`
while retaining both coherent wake views and the sampled speed/load/actuator
envelope. Falsify the mechanism on any exact-repeat miss, lower-branch exit,
weaker wake, delayed arrival beyond the repeat-backed range, or failure to
improve useful posterior burden. A lone additional threshold crossing still
does not establish general robustness.

bookshelf_consulted: true
source_domain: Lighthill elongated-body propulsion and sensor-modulated robotic-fish turning
source_mechanism: preserve posterior traveling-wave thrust while assigning bounded steering where observed actuator state retains usable authority
transferable_invariant: keep the posteriorly lagged propulsive bend active and condition spatial steering allocation on normalized outward actuator burden
nontransferable_details: published gains, dimensional cadence, species-specific kinematics, full-body waves, exact vortex phase, and task-specific routes
policy_translation: retain normalized body-frame achieved-course and intercept feedback, and transfer only the steering residual from a more outward-burdened posterior joint to an anterior joint with margin
falsification: reject if exact repeat capture, wake coherence, far-field closure, arrival, loads, or actuator-envelope behavior worsens, or if the same lower-pass topology survives
