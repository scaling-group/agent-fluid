# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled rollouts confirm direct-uniform still water with no prewarm.
  Three are byte-identical copies of the assigned candidate and capture at
  `0.7477L` after `16.6375T` with score `-0.11967`. The unique sampled variant
  subtracts anterior beat yaw using the mean-removed carrier coordinate rather
  than raw joint angle; it retains capture, arrives one integration step sooner
  at `16.6320T`, and has the best sampled score, `-0.11831`.
- In both combined visual sheets, the top-down row progresses from no wake at
  release to a regular alternating lateral vortex train by `6T`, then carries
  the fish along a direct left/down approach through capture. The oblique row
  likewise develops tail-connected three-dimensional vortex packets from a
  quiescent field; there is no visible passive advection, wake breakup, domain
  exit, or late course reversal. The duplicated parent is therefore a useful
  finite baseline rather than an informative failure; the inherited parent
  logs supply the contrast: a `3.254L` upper-exit miss preceded capture, while
  a later incompatible child again left the domain after reaching only
  `4.968L`.
- The capture carrier still spends about `3.15T` below normalized anterior
  phase radius `0.55`, advancing only about `0.135L`; radius `0.9` is not
  reached until about `4.18T`. Once established, it closes briskly and captures.
  Peak joint angles remain `0.550/0.560 rad`, peak planar force/moment are about
  `0.0369/0.0186`, and at least 95% acceleration-limit residence is already
  about `30.6%/50.7%`. This supports localized startup recruitment, not a
  global amplitude, frequency, or acceleration increase.

## Policy hypothesis

Preserve the full traveling-wave carrier, posterior half-cycle steering, and
joint-phase-demodulated yaw-response route that now demonstrably capture.
Adopt the slightly better sampled mean-removed phase coordinate, then add one
new mechanism: smoothly recruit extra anterior oscillator drive only while its
normalized joint-state phase radius is below a parameter-owned release radius.
The gate is derived from `q1`, `q1_dot`, amplitude, and natural frequency, so
it is body-frame, reflection-equivariant, and clock-free. It becomes exactly
zero in the mature gait, leaving the demonstrated approach and terminal route
unchanged. The rollout should cross phase-radius `0.55` earlier and capture
sooner without increasing mature saturation or breaking the connected wake.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPGs and biological burst-to-cruise redirects
source_mechanism: recruit rhythmic drive from observed locomotor state, then release continuously into the established gait
transferable_invariant: transient authority should be gated by deficient observed oscillator development and vanish once the propulsive rhythm is established
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, exact vortex phase, and prescribed maneuver timing
policy_translation: form a normalized anterior joint phase radius and add bounded state-feedback anti-damping below a smooth release threshold while preserving the incumbent two-joint route controller
falsification: reject if phase-radius growth is not advanced, capture is lost or not earlier, the alternating tail-connected wake degrades, or joint/load-limit residence materially exceeds the incumbent envelope
