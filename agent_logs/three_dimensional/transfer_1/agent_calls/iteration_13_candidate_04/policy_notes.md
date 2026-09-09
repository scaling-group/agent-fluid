# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled rollouts and the assigned parent's completed step-12
  rollout report direct uniform initialization in still water with
  `U_infinity=[0,0,0]`, no cylinders, and no prewarm snapshot. Their finite
  translation and wakes are therefore self-propelled rather than ambient
  advection or reused-flow artifacts.
- Both rows of the combined keyframe sheets were inspected from release to
  termination. The two achieved-course response-release samples retain a
  coherent alternating top-down vortex street and compact oblique Lambda2
  structures through capture at `0.74934L` and `0.74796L`. The bearing and
  achieved-course yaw-rate cascades also retain propulsion but remain above
  the target, reach only `3.00310L` and `3.11353L`, and exit through the left
  boundary. This separates the useful target-versus-achieved-course route
  topology from the repeatedly ineffective yaw-rate-cascade realization.
- The sampled actuator-reserve capture crosses at `18.205T`, earlier than the
  LOS-only capture at `18.6065T`, while retaining `53.7/53.7 deg` sub-`4L`
  joint excursion and a coherent terminal wake. Its sub-`4L` returned-action
  clipping is `71.6%/74.6%`, modestly below the LOS-only capture's
  `72.6%/75.5%`; speed-limit residence remains about `10.6%/10.7%` and
  terminal force/moment RMS rises slightly. Thus the evidence supports the
  semantic capture and preservation of the carrier, but not a claim that
  saturation or loads are solved.
- The assigned parent's latest adverse-moment phase reallocation is a concrete
  negative result. It retains a strong alternating wake and about
  `52.9/52.1 deg` sub-`4L` excursion, yet misses at `1.78417L`, clips on
  `73.3%/75.2%` of terminal rows, and exits through the same lower boundary.
  Instantaneous yaw moment is therefore too beat-sensitive to use as a direct
  half-cycle allocator in this topology; adding that residual to the sampled
  reserve controller is unsupported.

## Candidate mechanism and falsification

Transfer the sampled `dogfish3d_intercept_guarded_speed_reserve_v1` policy
unchanged. It preserves the normalized body-frame target-versus-achieved-
course outer loop, phase-compensated yaw/LOS response release, projected-pass
veto, posterior-lagged traveling bend, and additive two-joint steering. Its
single actuator-reserve mechanism uses normalized joint speed and previous
applied acceleration to soften only carrier acceleration that is still
outward when both speed and action are near their envelopes. Restoring carrier
acceleration and the steering residual remain intact. This is an exact-policy
reproducibility test, not a scalar gain edit or a claim that the current
workspace has already been evaluated.

Expected test: reproduce capture while preserving far-field closure, terminal
joint excursion, and both visible wake rows. The exact transfer is preferred
to another unevidenced combination because the current cohort contains two
captures but the assigned parent contains a sequence of coherent lower-exit
misses from energy recovery, slip curvature, cadence relief, collision
corridors, posterior-lag transfer, and adverse-moment phase allocation.

Falsification: treat the reserve mechanism as provisional if this exact replay
does not capture, returns to the lower-exit topology, weakens the alternating
wake, reduces terminal excursion, materially raises force/moment load, or
increases action/speed saturation. If it fails, later workers should not tune
the reserve thresholds around one capture; they should test a separately
normalized yaw/slip response or a different joint-space steering allocation.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and reactive traveling-wave swimming
source_mechanism: preserve a rhythmic posterior-lagged carrier while state feedback withdraws only actuation that is unusable at a measured envelope boundary
transferable_invariant: retain the traveling bend and bounded steering reserve by softening only outward saturated carrier effort, never the restoring carrier or steering residual
nontransferable_details: published CPG gains, dimensional cadence, species or robot kinematics, prescribed duty ratios, exact vortex phases, source-specific envelope thresholds, and task-specific routes
policy_translation: in the terminal body-frame intercept regime, use normalized joint speed and previous acceleration to gate each joint's outward carrier component while leaving restoring carrier acceleration and two-joint steering intact
falsification: reject as robust if exact replay loses capture, weakens terminal wake or excursion, raises loads or saturation, or returns to the lower-exit topology
