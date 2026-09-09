# Wake-policy candidate notes

## Evidence read before editing

- No inherited `logs/optimize` directory was present in the assigned parent;
  the parent policy, parent guidance, sampled guidance, and sampled evaluation
  artifacts are the available provenance for this candidate.
- The shared prewarm sheet shows the fish held at the upper-right while four
  developed, mutually interacting vortex streets extend downstream. This is a
  common initial condition, not candidate-specific behavior.
- All four sampled released episodes reach the target, so no failure keyframe
  is available. The useful comparison is the best finite parent
  (`solver_afd5d60a9317`) against the distinct worst-load success
  (`solver_8bc29ff8cd39`). Both visibly execute the same self-propelled sharp
  redirect and coherent diagonal leftward/upstream traverse, entering the
  merged-wake region only late; neither shows a collision or domain-exit
  precursor.
- The response-only siblings reach in `34.8205`, with mean distance
  `1.6270L`, total/mean command energy `47151.5/1354.1`, relative-crossflow
  RMS `0.24143`, and force/moment RMS `77.09/1142.74`. Restricting assisting
  moment credit to a targetward anterior half-cycle regresses arrival to
  `34.8535` and raises loads to `82.35/1231.74`. The assigned parent's
  combined assisting-moment and joint-speed-pressure release instead reaches
  in `34.7105`, with mean distance `1.6228L`, energy `46985.9/1353.6`,
  crossflow `0.24023`, and loads `68.96/1036.40`. It is the only sampled
  topology that improves all of those measures, although the samples cannot
  isolate its two release signals causally.
- Every sampled policy still touches `4.537856` joint speed and `30.0`
  acceleration on both joints. The remaining evidence-backed opportunity is
  actuation relief localized to the extra response-gated redirect burst, not
  another signed wake residual or a change to the proven propulsive carrier.

## Candidate hypothesis

Add a one-step, normalized acceleration-pressure observation from
`previous_action`. Smoothly combine it with the parent's joint-speed pressure
and use it only to release the surplus `redirect_burst_asymmetry`. Preserve the
carrier, raw-bearing mean steering and reserve, course-slip residual, and base
half-cycle asymmetry. This should remove surplus redirect work when the prior
command shows that the acceleration envelope has already been consumed,
without withdrawing the persistent authority responsible for capture.

Success for the later CFD evaluation is target capture with the same coherent
leftward route and a meaningful reduction in command effort, load, or limit
contact without a material arrival/mean-distance regression. Falsify the
hypothesis if capture is lost, the route stops progressing upstream, the
acceleration-pressure gate merely reproduces the parent, or load/effort relief
does not compensate for worse arrival or distance.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and burst redirect/release
source_mechanism: gate strong turning asymmetry by observed error and response, then release surplus burst while retaining the propulsive rhythm
transferable_invariant: persistent route authority and transient redirect authority should have separate roles, and observed actuator response may withdraw only the transient surplus
nontransferable_details: published gains, clocked CPG phase, species-specific bends, exact vortex phase, dimensional frequency, cylinder coordinates, and task routes
policy_translation: combine normalized prior-command acceleration pressure with joint-speed pressure to schedule only extra half-cycle asymmetry in the two-joint body-frame feedback policy
falsification: reject if target capture or coherent upstream propulsion is lost, or if the later rollout shows no meaningful effort/load/limit benefit for any route cost
