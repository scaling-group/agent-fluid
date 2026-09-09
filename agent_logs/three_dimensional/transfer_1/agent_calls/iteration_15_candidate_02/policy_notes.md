# Wake-policy candidate diagnosis

## Evidence read before editing

- All four sampled evaluations report direct uniform still-water initialization
  with `U_infinity=[0,0,0]`, no cylinders, and no prewarm. The combined sheets
  for the strongest finite score (`solver_6b0e320e2f55`) and the lowest-scoring
  sampled capture (`solver_5c1f6245a363`) were inspected in both rows. From
  `4T` onward they show a long alternating top-down vortex street and compact
  alternating oblique Lambda2 structures through crossing, with no wake
  collapse, collision, or numerical instability. Translation is therefore
  self-propelled rather than ambient advection.
- The assigned parent bytes are exactly reproduced by
  `solver_6b0e320e2f55`, `solver_5fd3c75ceead`, and
  `solver_2d0a4a628957`. All three capture at `18.2050--18.6010T` while
  sustaining mean speed near `0.698--0.701L/T`; their action-clamp fractions
  remain about `68.5--68.7%/70.6--71.0%`, joint-speed-limit residence about
  `10.5--10.7%/11.4--11.7%`, and force/moment peaks comparable. The
  projected-intercept guard plus selective carrier reserve is thus a
  repeat-supported propulsion and route mechanism even though actuator
  saturation remains high.
- The fourth sample adds a continuous normalized signed projected-miss turn
  inside `2L` and also captures, at `18.5405T`, with a coherent terminal wake,
  mean speed `0.696L/T`, action clamping `68.5%/71.0%`, and force/moment peaks
  within the exact-parent spread. It is positive evidence that the geometric
  error substitution preserves the useful topology, but one evaluation does
  not establish repeatability or superiority over the three parent captures.
- Two inherited total-command speed-feasibility edits provide a concrete
  boundary. Reversing outward terminal commands reduced speed-limit residence
  but missed at `1.3877L`; the assigned parent's softer outward projection
  then missed at `1.5963L`. Both exited the lower boundary with coherent wakes.
  Envelope optimization that directly alters the combined carrier-plus-turn
  action is therefore unsafe here, and lower clamp residence is not a semantic
  improvement when capture is lost.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: robotic-fish sensor-modulated direction tracking and adaptive prey-capture control
source_mechanism: preserve a rhythmic propulsive carrier while sensed interception geometry shapes a bounded corrective residual
transferable_invariant: after broad acquisition, normalized signed predicted miss can supply a continuous near-target steering error without prescribing a route or suppressing propulsion
nontransferable_details: published gains, dimensional cadence, robot or species kinematics, exact gait and vortex phase, learned routes, and task-specific paths
policy_translation: retain the two-joint traveling bend, achieved-course acquisition, intercept veto, and carrier reserve; inside two body lengths smoothly replace range-sensitive course pursuit with a bounded body-frame target-velocity cross-product divided by achieved speed
falsification: reject if an exact repeat loses capture, projected miss grows after activation, the alternating terminal wake weakens or coasts, early closure changes, force or yaw-moment peaks rise, or saturation falls only by losing crossing speed

## Candidate policy hypothesis

Materialize the sampled signed projected-miss controller as the single
candidate, without scalar gain tuning or another actuator governor. Outside
`2L` it retains the assigned parent's evaluated guidance and actuation path.
Inside `2L`, a smooth distance gate blends the existing course request toward
the signed perpendicular miss of the achieved velocity line, normalized by
achieved speed and bounded by `tanh`. This directly expresses which side of
the capture disk the current course will pass, while the existing absolute
projected-miss/approach guard still controls yaw-response release.

The next CFD evaluation is a deliberate exact-mechanism repeat: capture with
the evidenced coherent wake and comparable loads supports keeping signed
projected miss as a reusable terminal error; a miss rejects the single sampled
capture as insufficiently robust. No outcome from this unevaluated repeat is
claimed here.
