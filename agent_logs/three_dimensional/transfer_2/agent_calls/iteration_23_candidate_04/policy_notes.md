# Joint-rate-governed response-handoff candidate

## Visual and diagnostic evidence before the policy edit

- All four sampled rollouts satisfy the frozen contract: direct uniform
  `U_infinity=(0,0,0)` initialization, no cylinders or prewarm, stable moving-
  window transport, and `capture` termination. They arrive in
  `19.1620--19.3545T` with distance integrals of `2.06924--2.07892L`; this is
  refinement of a proven capture scaffold, not recovery of propulsion or
  semantic success.
- Both rows of the combined keyframe sheets for the strongest response-aware
  repeat (`solver_bf9554cfba28`) and the informative weaker redirect-reserve
  candidate (`solver_d6f4924b438d`) were inspected from release through
  capture. The top-down rows show self-propulsion from quiescent water, a
  coherent alternating wake, broadly direct progress, and a continuous late
  hook into the capture circle. The oblique rows show compact three-dimensional
  Lambda2 structures convecting behind the fish without passive advection,
  collision, wake breakup, or instability. Their useful difference is path and
  actuator use, not success or wake class.
- The redirect-reserve candidate is a concrete negative mechanism result. It
  slightly lowers mean anterior/posterior command to `18.23/17.37 rad/T^2`
  from `18.45--18.46/17.53--17.56` for the two byte-identical response-aware
  samples, but greater-than-90%-bound residence changes only to
  `35.50%/33.74%` from `35.69--35.99%/33.79--33.96%`. More importantly,
  greater-than-99%-rate residence remains `8.22%/4.35%` versus
  `8.33--8.35%/4.35--4.36%`, both joints still touch `260 deg/T`, path grows
  to `12.370L` from `12.304/12.309L`, and arrival/integral regress to
  `19.3325T/2.07854L` from `19.1620--19.3380T/2.06924--2.07622L`. Peak planar
  force/yaw moment remains in the same `0.02537/0.01352` class. Reserving raw
  command only during unresolved redirect is therefore not an evidenced cure
  for the recurring rate-envelope contact.
- The distance-only handoff likewise touches both rate limits and spends
  `8.24%/4.43%` above 99% of them, while taking a longer `12.416L` path. The
  rate contact is common to the capture scaffold rather than introduced by the
  response gate. Preserve the response-aware route, approach, and posterior
  allocation mechanisms while changing how observed joint phase speed is
  regulated.

## One-candidate hypothesis

Preserve the complete response-aware capture policy and add one compact
actuator-feedback mechanism: normalize each observed joint velocity by the
parameter-owned rate envelope and continuously suppress acceleration that
would increase phase speed after an onset fraction, adding only a bounded
opposing brake as the envelope is approached. This is a state-derived phase-
speed governor, not a change to oscillator cadence, steering gain, gait
handoff, actuator limits, or environment. It is odd under reflected joint
state, uses no time or route memory, and is inactive through the interior of
the sampled gait.

Expected signature: retain capture, the response-aware `12.30--12.31L` path
class, early distance milestones, late-hook topology, and coherent two-view
wake while materially reducing the repeated `8.2--8.4%/4.3--4.4%` near-rate-
limit residence without increasing near-bound acceleration residence or the
sampled `~0.0254/~0.0136` force/moment class. Falsify if capture, progress,
path, approach slip, wake coherence, joint margin, command residence, or loads
regress, or if exact rate-envelope contact remains without a compensating
trajectory or effort improvement; if falsified, restore the response-aware
handoff and test a gait-frequency/phase mechanism only on held-out evidence.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and bounded biological swimming cadence
source_mechanism: regulate rhythmic joint phase speed from measured joint-state feedback while preserving task-directed steering and the established traveling bend
transferable_invariant: use normalized observed phase speed to reduce outward rhythmic acceleration near an actuator envelope instead of relying on hard clipping to shape the gait
nontransferable_details: published gains, dimensional frequencies, species-specific envelopes, robot motor limits, full-body waveforms, clock phase, exact vortex phase, world coordinates, and task-specific routes
policy_translation: under the two-joint acceleration contract, apply a smooth odd-symmetric rate governor to each raw acceleration using its measured joint velocity and parameter-owned normalized onset and envelope, leaving the existing body-frame response-aware controller unchanged away from the envelope
falsification: reject if near-rate-limit residence does not materially decrease together with preserved capture, milestones, short path, command headroom, joint margin, stable loads, and coherent top-down and oblique wakes
