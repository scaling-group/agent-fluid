# Target-qualified sideslip-response candidate

## Evidence diagnosis before editing

All four sampled solver evaluations and the assigned-parent evaluation use
direct uniform still-water initialization (`U_infinity=(0,0,0)`) without
prewarm or cylinders, and all terminate in capture.  The strongest sampled
finite result is the translation-consistent steering-side policy
`solver_8e7135ef9173` (`0.748338L`, about `26.246T`, score `-0.616147`).  The
prefilled posterior wave-shape policy reaches `0.748829L` at about `26.296T`,
and the informative carrier-relief comparison reaches `0.748792L` only after
about `26.362T`.

The combined sheets were inspected from release through termination.  Their
top-down rows show genuine self-propulsion, a regular alternating wake, and
the same late curved crossing of the capture circle; their oblique rows retain
compact three-dimensional Lambda2 structures with no wake breakup, boundary
interaction, imposed advection, or numerical instability.  The visually
nearly identical paths agree with the diagnostics: the sampled policies have
zero angle, rate, and acceleration contacts, peak planar force near `0.01883`,
and peak yaw moment near `0.00979`.  The productive carrier and its coordinated
safety envelope should therefore be preserved.

The assigned parent's completed translation-consistent response-magnitude
test also preserves capture and the same coherent two-view wake, but regresses
to `0.749383L` and score `-0.616890`.  Together with the sampled side-selector,
conflict-allocation, posterior-modulation, and carrier-relief results, this is
concrete evidence against another observer-blend threshold, response-gain, or
terminal waveform retune.

A different body-frame response defect survives.  Reconstructing velocity in
the fish frame from the sampled trajectories gives the strongest policy a
mean/RMS normalized lateral slip of about `0.161/0.191` inside `1.1L`, with a
terminal slip of `0.172`; the prefilled policy terminates at `0.299`.  The
correction opposing that slip agrees with the target-course steering side in
about `88%` of the strongest policy's sub-`1.1L` samples.  Thus the shallow,
transverse late crossing can test translational course response directly,
without treating a folded bearing-rate magnitude as the missing signal.

## Policy hypothesis

Preserve the prefilled traveling bend, redirect, positive line-of-sight
response, capture-gated posterior wave shape, coordinated acceleration
projection, and joint viability guards.  Add one target-qualified sideslip
response: normalize body-frame lateral velocity by translational speed, form
the bounded correction that opposes it, and admit that correction only when it
agrees with both target-course steering and the established line-of-sight
side.  Let the slip observer fill only unused magnitude in the existing
navigation half-cycle via a maximum, so neither its gain nor its maximum
authority increases.  Low-speed states remain suppressed by the existing
course-observability weight, and disagreement is an exact pass-through.

This should change the course response earlier than the repeatedly equivalent
terminal edits while retaining the propulsive carrier.  Reject it if capture
or wake coherence is lost, actuator contacts or force/moment exposure return,
the fish persistently aligns to its drift rather than the target, or the result
again lies in the milliscale-equivalent shallow-hook cluster.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish direction tracking and wake-disturbance rejection
source_mechanism: preserve a rhythmic propulsive carrier while bounded sensor feedback rejects lateral drift only when it conflicts with the requested route
transferable_invariant: separate target-course demand from measured body-frame sideslip and correct only the component whose direction agrees with route closure
nontransferable_details: published feedback gains, robot or species kinematics, dimensional speeds and frequencies, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame lateral velocity and target-course agreement to fill unused capacity in the existing anterior navigation half-cycle while leaving the two-joint carrier and command envelope unchanged
falsification: reject on lost capture or coherent wake, increased limit/load exposure, drift-following away from the target, or another milliscale-equivalent trajectory

## Non-CFD verification after editing

- The returned parameter schema exactly matches every direct `params.FIELD`
  reference.  A deterministic grid of 6,561 mirrored state pairs produced
  finite two-joint commands within `30 rad/T^2` with reflection error below
  numerical tolerance.  A target/slip-agreement state changes the anterior
  command by about `0.475 rad/T^2`; a disagreement state is exactly identical
  to the prefilled policy.
- Replaying the policy on reconstructed pre-step states from the inherited
  prefill trace matches its recorded commands within `0.00170 rad/T^2`.  On
  those frozen states the candidate changes 152 of 4,773 audited commands,
  including 116 by more than `0.05 rad/T^2`; activation begins near `1.44T`,
  the largest change is about `0.367 rad/T^2`, and the peak command remains
  `29.72585 rad/T^2`.  This establishes bounded, material activation only; it
  is not same-worker CFD evidence of improvement.
- The required check-runner was invoked, but its pinned `gpt-5.4-mini` model is
  unavailable on this account.  Its exact three commands were run directly:
  the material guidance/notes check, Julia policy contract, and solver
  editable-boundary check all pass.  The guidance checker initially exposed a
  duplicate identical assigned-parent marker in the rendered `README.md`; the
  duplicate was removed and the checker then passed.
