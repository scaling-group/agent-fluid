# Candidate-specific wake-policy notes

## Evidence diagnosis

- The only sampled rollout is the common drive-only seed; no inherited
  `logs/optimize` notes or successful finite comparison are present in this
  fresh lineage. Its diagnostics confirm direct uniform still-water
  initialization (`U_infinity=0`), no cylinders, and no prewarm snapshot.
- In the top-down sheet the seed develops a coherent alternating wake and
  translates about `0.93L` left, so the gait is self-propulsive rather than
  passive advection. It does not steer toward the body-frame target: after a
  small improvement from `12.328L` to `12.078L` at `6.358T`, the fish curls
  upward and exits at `8.547T`, with center `y` increasing by `1.20L` and final
  distance worsening to `12.380L`. The oblique Lambda2 row corroborates a
  three-dimensional tail wake along that wrong-way curved path; it does not
  show an external wake to reject.
- The reconstructed target bearing starts at `+0.155 rad`, crosses near zero
  around `4T`, and grows to roughly `-1.17 rad` after the uncontrolled curl.
  Meanwhile absolute heading rate reaches `2.79 rad/T`, both joint speeds
  reach the `260 deg/T` limit, and pre-clamp requested accelerations reach
  `59.9/75.4 rad/T^2`. Joint angles remain below `27 deg`. This separates the
  missing capability from weak propulsion: the seed has drive and wake
  formation, but no target-coupled mean turn.

## Policy hypothesis

Preserve the seed oscillator, posterior lag, period, amplitude, and damping.
Add one compact steering mechanism: map normalized body-frame `bearing`
through `tanh` to a bounded acceleration residual shared by both joints, with
slightly less posterior share. The `6 rad/T^2` bound is small relative to the
sampled carrier's requested acceleration peaks, while the smooth saturation
can establish mean curvature without replacing the observed propulsive wave.
The first CFD test should check turn sign and topology before adding rate,
flow, load, or approach scheduling.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG turning and fish mean-curvature turning
source_mechanism: sensor-driven tail-beat bias superimposed on a continuing propulsive rhythm
transferable_invariant: persistent normalized body-frame target error should create a bounded mean bend while joint-state feedback preserves the traveling wave
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, exact vortex phase, and source-task routes
policy_translation: apply a smooth bounded bearing-driven acceleration residual to the two joints without adding clock time or altering the seed oscillator
falsification: reject the transfer if the first turn has the wrong sign, minimum distance does not improve, the coherent wake or leftward propulsion collapses, or speed/acceleration saturation becomes more persistent

