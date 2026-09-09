# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled solver rollouts and the assigned parent's inherited
  step-10 rollout report direct uniform initialization with zero background
  velocity, no cylinders, and no prewarm. Their translation is self-propelled.
- Both rows of the combined keyframe sheets were inspected for the sampled
  0.7493L capture, the prefilled 1.5454L mean-curvature failure, and the
  inherited 1.0509L intercept-guard failure. The capture sustains a coherent
  alternating top-down street and compact oblique Lambda2 structures through
  its 18.6065T crossing. Both failures also retain a substantial alternating
  wake through their closest passes and continue swimming afterward; neither
  failure is explained by ambient advection, wake collapse, or instability.
  The two broader sampled failures likewise self-propel but approach only
  3.0031L and 3.1135L, supporting preservation of the achieved-course route
  rather than more far-field route gain.
- The sampled capture and its exact-policy repeat establish that the original
  LOS-guarded release was fragile: identical policy bytes captured once but
  later missed at 1.7715L. The assigned parent's added projected-intercept
  guard materially sharpened the next completed pass to 1.0509L while
  preserving about 0.866L/T speed and a coherent wake, but it still exited the
  lower boundary and ended at 11.2048L. The guard is therefore useful
  provisional state discrimination, not a completed capture mechanism.
- At the inherited intercept-guard closest pass near 18.848T, the target is
  still about +0.979L laterally in the body frame, the target and achieved
  course angles are about +1.198 and -0.455 rad, projected miss is 1.047L,
  and the bounded turn command is already +1.0 with release vetoed. Direct
  acceleration is clamped on about 70.4% and 69.7% of trace rows. More route
  gain or a tighter release corridor cannot create unused authority here.
- Replacing terminal shared acceleration with posterior mean curvature did
  not solve that realization problem: the prefilled result regressed to a
  1.5454L pass at about 0.809L/T with the same lower-exit topology and roughly
  70.0% and 72.2% acceleration clamping. This is negative evidence against
  another static-curvature or scalar-only terminal edit.

## Candidate mechanism and falsification

Start from the evaluated intercept-guarded achieved-course controller, not
the prefilled mean-curvature regression. Preserve its traveling-bend carrier,
far-field course servo, yaw-response/LOS release logic, and projected
intercept veto. Add one terminal half-cycle steering realization: infer the
current beat side continuously from joint-1 angle plus normalized joint-1
velocity, then redistribute the already-bounded shared steering toward the
half-cycle whose bend agrees with the requested turn and away from the
opposing half-cycle. Blend this redistribution in only with the existing
terminal-response gate. It does not add a route, clock, mutable phase, carrier
attenuation, or a larger mean steering command.

Expected test: retain the inherited far-field trajectory and alternating 3D
wake while converting saturated terminal effort into a more useful turning
wave, crossing the 0.75L radius or at least improving the 1.0509L inherited
pass without increasing clamp fraction or hydrodynamic loads.

Falsification: reject the phase-selective realization if it changes closure
before the terminal gate, weakens the alternating wake, worsens the 1.0509L
pass, retains the same lower-exit topology without a materially different
useful trajectory, increases saturation or loads, or turns the fish away when
the intercept guard already reports a compatible approaching pass. Any new
capture remains provisional until an exact-policy repeat succeeds.

bookshelf_consulted: true
source_domain: robotic-fish CPG turning by asymmetric flapping and sensor-conditioned direction tracking
source_mechanism: preserve rhythmic propulsion while redistributing bounded turn effort between observed beat half-cycles
transferable_invariant: when turn sign is correct but direct mean steering saturates, use joint-state phase to favor the requested bending half-cycle without suppressing the traveling carrier
nontransferable_details: published gains, robot or species kinematics, dimensional cadence, duty ratios, exact vortex phase, and task-specific routes
policy_translation: retain the two-joint carrier and intercept-guarded course servo, but terminally weight its existing shared steering with a bounded joint-angle/velocity beat-side signal whose cycle-centered weight remains one
falsification: reject if far-field closure changes, the coherent wake weakens, the inherited 1.0509L pass does not improve, capture is not repeatable, or saturation and loads worsen
