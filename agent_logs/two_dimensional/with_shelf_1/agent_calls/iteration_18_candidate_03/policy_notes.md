# Candidate diagnosis and hypothesis

## Evidence read before editing

- The shared prewarm sheet shows the fish held in the upper-right while four
  staggered cylinders develop interacting vortex streets across the route to
  the second-row target. The four sampled released sheets are byte-identical,
  so they are deterministic replications of one initial wake, not evidence of
  phase robustness and not a visual success/failure comparison.
- In the released sheet the policy is self-propelled: it makes a sharp
  targetward redirect, leaves a strong body-scale wake of its own, then holds a
  coherent leftward and downward traverse through the developed crossflow to
  first capture. It neither collides nor exits and reaches `0.74651L` in
  `34.7105`, with mean distance `1.62283L` and displacement
  `(-10.923,-4.166)L`.
- The same successful samples carry `0.24023` RMS relative crossflow and
  `68.96/1036.40` force/moment RMS while using `46985.9/1353.65` total/mean
  command energy. Assigned-parent guidance says the route controller still
  touches joint-speed and command limits. Thus capture and route topology are
  already useful; the remaining falsifiable opportunity is to unload the
  phase-selective redirect without weakening persistent target steering.
- Inherited results bound that opportunity. Replacing bearing-window response
  with direct heading rate arrives `0.0385` sooner but raises force/moment RMS
  to `91.30/1389.74` and worsens mean distance. A previous-action pressure gate
  instead worsens arrival to `35.0185`, mean distance to `1.63314L`, total
  energy to `47340.0`, and force/moment RMS to `69.66/1037.65`, despite a small
  crossflow reduction. These are negative evidence against another generic
  response or saturation proxy. No sampled failure keyframe is present, so no
  visual cause is claimed for those inherited failures or regressions.

## One-mechanism candidate

Keep the proven state-feedback carrier, raw-bearing mean steering and reserve,
course-slip damping, coherent speed release, and response-gated optional burst.
Extend the already sign-calibrated target-assisting moment credit to unload
only a bounded fraction of the *base half-cycle asymmetry*. The continuous
mean steering remains untouched, opposing hydrodynamic moment receives no
credit, and at least most of the route-compactness asymmetry remains active.
This tests whether useful wake-induced yaw can substitute for some
phase-selective effort without cancelling the wake or adding another limit
proxy.

Expected evidence after evaluation: retain `target_reached` and the coherent
redirect/upstream route while materially reducing force/moment RMS or mean
command energy. Falsify the mechanism if capture is lost, mean distance or
arrival regresses materially, limit contact is unchanged without a load
benefit, or target-assisting moment credit erases the redirect.

bookshelf_consulted: true
source_domain: biological Karman-gait load reduction and sensor-modulated robotic-fish CPG control
source_mechanism: reduce active rhythmic steering when measured hydrodynamic response already assists the requested maneuver
transferable_invariant: useful fluid-induced yaw can earn bounded actuation relief while target geometry continues to own the route request
nontransferable_details: species kinematics, published gains, exact vortex phase, single-cylinder synchronization, and source-task routes
policy_translation: use normalized body-frame bearing and moment sign to smoothly release only a capped share of base half-cycle asymmetry; preserve mean steering, posterior carrier, and opposing-moment authority
falsification: reject if capture or route compactness is lost, or if force/moment RMS and effort do not improve without new limit contact
