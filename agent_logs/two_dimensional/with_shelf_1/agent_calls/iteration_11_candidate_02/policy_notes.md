# Wake-policy candidate notes

## Evidence diagnosis

- Reviewed the common held-fish prewarm sheet and all four sampled released
  sheets before editing. The prewarm establishes the same developed,
  interacting four-cylinder streets for every candidate. The released sheets
  all show the same useful topology: a sharp targetward redirect from the
  upper-right release, sustained self-propelled upstream traversal across the
  wake, and direct entry into the `0.75L` target circle. None of the four
  sampled sheets supplies a failure image; the informative failure boundary is
  therefore inherited evidence, especially the predictive-bearing controller
  that put trend into persistent route steering and exited after `18.304` with
  negative progress, plus the wholesale slower carrier that became unstable
  with force/moment RMS `16749.8/290421`.
- The ungated response burst is the strongest finite arrival baseline:
  `34.821` release time, `1.6270L` mean distance, `47151` total command energy,
  and force/moment RMS `77.09/1142.74`. The assigned parent uses unsigned yaw
  magnitude to relieve half of only the extra burst and retains capture, but
  regresses to `34.997`, `1.6301L`, `47355`, and `71.92/1086.47`.
- The signed assisting-moment sibling is a more informative contrast. It
  relieves the extra burst only when yaw moment already agrees with the raw
  bearing request and reaches in `34.941` with `1.6290L` mean distance,
  `47298` total command energy, and `71.86/1064.16` force/moment RMS. It
  dominates the parent's unsigned gate on arrival, route, effort, and load.
  Conversely, the stronger unsigned inverse-square load gate reaches only at
  `35.035` and increases force/moment RMS to `78.35/1216.43`; absolute load
  alone is not a reliable reason to withdraw redirect authority.

## Policy hypothesis

Preserve the evidenced oscillator, course-slip correction, raw-bearing reserve,
base half-cycle asymmetry, and response-gated extra burst. Change only the
parent's burst-availability mechanism: use the smooth raw-bearing sign to
classify normalized `moment_z_L2` as assisting or opposing, and apply the
parent's bounded `0.50` relief only to assisting moment. Opposing moment leaves
all established redirect authority available; mean steering, base asymmetry,
and propulsion are never attenuated. This tests a semantic sign-discrimination
mechanism while preserving the parent's partial-relief bound, rather than
tuning the carrier or copying a published gain.

Expected evidence: retain target capture and the visible redirect-and-upstream
topology; improve on the parent's `34.997` arrival, `1.6301L` mean distance,
and `47355` total command energy without returning fully to the ungated
`77.09/1142.74` load pair. Falsify the mechanism if capture is lost, arrival or
mean distance is no better than the parent, or RMS force/moment is not below
the ungated response-burst baseline. A changed wake phase is still required
before claiming robustness.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish direction control and adaptive swimming in organized wakes
source_mechanism: use measured directional response to modulate a rhythmic maneuver while retaining the underlying propulsive oscillator
transferable_invariant: release optional redirect authority when a normalized body-frame response already assists the requested turn, while preserving authority against an opposing disturbance
nontransferable_details: published gains, clocked CPG phase, species-specific kinematics, exact vortex phase, single-cylinder synchronization, and task-specific routes
policy_translation: classify `moment_z_L2` with a smooth body-frame bearing sign and partially relieve only the extra half-cycle burst for assisting yaw; leave the mean route residual, base asymmetry, and carrier unchanged
falsification: reject if target capture or route topology is lost, if parent arrival and mean distance do not improve, or if load returns to or exceeds the ungated response-burst baseline
