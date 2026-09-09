# Wake-policy candidate notes

## Evidence inventory and visual diagnosis

- The assigned parent is the steering-prioritized allocator in `solver/`. Three
  sampled copies of that controller reproduce `target_reached` at `36.4705`
  release time with mean distance `1.68603L`, total/mean command energy
  `48700.1/1335.33`, RMS relative crossflow `0.23970`, and RMS force/moment
  `63.59/953.42`. This exact repetition is same-prewarm determinism, not
  wake-phase robustness.
- The shared prewarm sheet shows the held fish above and downstream of four
  fully developed, interacting vortex streets. The released sheets show the
  parent and sampled approach-scheduled child making the same sharp initial
  redirect, then self-propelling leftward across the wake to first capture.
  Neither sheet shows a collision, domain-edge drift, passive downstream
  advection, or a visibly distinct terminal loop.
- The approach-scheduled child releases only half-cycle asymmetry near the
  target. It still reaches the target and changes release time `36.4705 ->
  36.4540`, total command energy `48700.1 -> 48678.8`, relative crossflow
  `0.23970 -> 0.23913`, and RMS force/moment `63.59/953.42 -> 63.25/950.58`.
  The changes are small; mean distance slightly worsens `1.68603L ->
  1.68617L` and scalar score falls `0.188574 -> 0.188396`.
- Both the parent and the approach child hit exactly `4.537856` joint speed
  and `30.0` acceleration on both joints. Thus terminal asymmetry relief does
  not address the remaining limit contact. The sampled set contains no
  failure rollout or failure keyframe; the informative failure boundary comes
  only from inherited guidance: wholesale carrier replacement became unstable
  with force/moment RMS `16749.8/290421`, while wrong-sign curvature exited
  with negative progress. No inherited optimizer log directory was supplied.

## Candidate hypothesis

Keep the proven traveling-bend carrier, target-bearing steering sign,
course-slip residual, raw-bearing reserve schedule, half-cycle asymmetry, and
`30.0` acceleration envelope unchanged. Add one joint-state mechanism after
allocation: once absolute joint speed enters a soft band immediately below the
known actuator limit, smoothly attenuate only acceleration that would increase
that absolute speed. Braking acceleration remains unchanged. This should stop
commands from driving into the speed clamp without withdrawing bearing-owned
steering away from the limit or replacing the successful gait.

Falsify the candidate if it loses target capture, materially lengthens the
coherent redirect-and-upstream route, still reaches the joint-speed limit, or
does not improve at least one of command effort, force/moment load, or limit
contact. A same-prewarm success cannot establish changed-wake robustness.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation under physical actuation constraints
source_mechanism: modulate a rhythmic locomotion command with measured state instead of replacing the carrier or prescribing a clocked gait
transferable_invariant: preserve the useful traveling rhythm while feedback removes only the command component that pushes farther into an observed actuator boundary
nontransferable_details: published gains, robot geometry, oscillator timing, species kinematics, exact vortex phase, and task-specific routes
policy_translation: use normalized joint speed relative to candidate-owned soft-band parameters; smoothly attenuate only same-sign acceleration on each of the two joints, after body-frame bearing and slip feedback allocate steering
falsification: reject if capture or upstream propulsion is lost, if speed still reaches the hard cap, or if effort and force/moment metrics do not improve
