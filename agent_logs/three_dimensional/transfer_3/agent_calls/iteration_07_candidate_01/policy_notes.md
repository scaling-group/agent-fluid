# Distributed course-bend candidate

## Evidence read before the policy edit

- Every sampled and inherited evaluation used direct uniform still-water
  initialization (`U_infinity=(0,0,0)`), no cylinders, and no prewarm. The
  observed translation and wakes are self-generated; every completed policy
  still terminates by leaving the virtual domain rather than capture.
- In both rows of the combined sheet, `solver_adc862529891` sustains a long
  alternating top-down vortex street and compact oblique Lambda2 structures.
  It is the best sampled finite score (`-7.550`, minimum `5.658L`), but its
  center rises from `14.00L` to the upper exit at `15.20L` by `16.77T`. This
  is productive propulsion with poor course regulation, not advection or wake
  collapse.
- The closest sampled policies preserve the same coherent carrier and improve
  forward approach, but not the trajectory class. Two-joint yaw projection
  with raw slip reaches `4.158L`; additionally projecting gait-correlated
  lateral recoil reaches `4.128L`. Both then pass roughly `4.2L` above the
  target and exit through the left boundary near `29.6T` with final distance
  about `9.05L`. Thus lateral phase separation changes the minimum by only
  `0.030L` and produces no semantic improvement.
- The inherited preserved-carrier half-cycle policy is a direct negative test
  of asymmetric steering on the `28 degree`, `0.55T` gait. Its combined sheet
  shows a tight turn and only a short translational wake; it reaches merely
  `11.994L`, then exits the upper boundary at `8.657T` with final distance
  `12.141L`. A `0.90--1.10` posterior half-cycle scale therefore converts the
  useful carrier into excessive turn instead of solving the near-miss. Later
  workers should not repeat posterior half-cycle asymmetry on this carrier
  without first demonstrating a much smaller, response-released actuation.
- The remaining actuator in the two best near-misses is a posterior-only mean
  equilibrium. Beat-averaged reconstruction of `solver_4c50eba7cd00` shows
  its requested bend reversing as course alignment changes while the intact
  gait continues almost horizontally. This supports retaining the normalized
  phase-separated course/yaw feedback but testing where the slow curvature is
  applied, rather than another scalar change to its gains.

## Policy hypothesis recorded before editing

Use one new control mechanism: a bounded whole-body C-bend that releases with
the existing observed course/yaw response. Preserve the completed policy's
joint-state carrier and its normalized body-frame target, phase-separated
lateral velocity, and phase-separated yaw residual exactly. Interpret the
same bounded total-bend request as an equilibrium shared by both joints:
shift the anterior state-feedback oscillator about a small fraction of the
bend and place the remaining fraction in the posterior equilibrium, while
forming the posterior traveling wave from the centered anterior state. This
keeps total mean curvature and all steering gains unchanged, but gives the
anterior body surface controlled turning authority instead of asking the
posterior joint alone to provide both thrust and course correction.

Expected evidence is the same long alternating wake and strong world-minus-x
translation, an initial negative-yaw/down-course response, and a closest-path
center materially below the `13.7--14.0L` band of the sampled near-misses.
Reject the mechanism if the anterior center shift weakens the carrier, creates
persistent command saturation or a tight boundary-seeking turn, repeats the
left exit without improving the `4.128L` minimum and final distance, or has
the wrong initial yaw sign. The new candidate's CFD result is not yet
available and is not claimed here.

bookshelf_consulted: true
source_domain: biological burst redirect and closed-loop robotic-fish direction control
source_mechanism: a target-driven whole-body bend is released as observed directional response appears, leaving the traveling wave as the cruise carrier
transferable_invariant: persistent direction error may distribute bounded curvature across the body, but that curvature must withdraw or reverse with measured course/yaw response while rhythmic propulsion remains state-driven
nontransferable_details: C-start timing, published gains, clock-driven phase, species kinematics, body envelopes, exact vortex phases, and task-specific routes
policy_translation: retain normalized body-frame course and phase-separated yaw feedback; split its bounded total bend between the equilibria of the two observed joints and form the posterior wave from the centered anterior state
falsification: reject if initial yaw polarity is wrong, the alternating carrier weakens, a tight upper/lower exit replaces translation, or the same above-target left exit recurs without beating the sampled `4.128L` closest approach and improving final distance
