# Redirect-response-aligned common-carrier governor

## Evidence and visual diagnosis before editing

All four sampled rollouts satisfy the experiment contract: direct uniform
quiescent initialization, zero background velocity, no prewarm snapshot, no
cylinders, and capture. Their top-down sheets show alternating vorticity shed
behind a moving fish rather than background advection, while the oblique
Lambda2 sheets show an organized three-dimensional traveling wake through the
target-directed bend and capture. No sample exhibits wake breakup or numerical
instability. The assigned parent (`solver_3fdd63b3fbda`) is the strongest
finite result: redirect-priority carrier allocation advances every
`10/8/6/4/2/1L` milestone to `5.863/7.838/9.779/11.726/14.201/15.604T`,
captures at `16.044T`, lowers the scored distance integral to `1.82409L`, and
raises score to `0.05824`. The uncancelled-work comparison captures at
`17.688T/1.96419L/-0.07859`, so the improvement is far larger than the small
repeat spread recorded in inherited logs.

The visual and trajectory evidence also show the parent's boundary. Its broad
arc is the widest sampled head path (`13.178L`, versus `12.170--12.528L` for
the other three), and its peak planar force/yaw-moment coefficients rise to
`0.03579/0.01770`. Anterior/posterior residence above 99% of the rate envelope
is `12.24/1.37%`, versus `4.23/0.00%` for the predictive barrier. Thus the
parent validates response-conditioned redirect priority as a progress
mechanism, not as a load or rate protector.

The inherited parent hypothesis says carrier authority should return when the
observed heading response appears. However, the implementation requests
priority using signed `redirect_command` (velocity-course error plus LOS lead)
but tests response using the separate `turn_command` (LOS bearing plus yaw
brake). Reconstructing those normalized body-frame signals from the parent
trajectory shows opposite command signs in 23 of 30 redirect-active samples
above 98% of the joint-rate envelope. In those samples, the existing
unfulfilled-response gate averages about `0.932`; aligning response with the
actual redirect command would average about `0.033`. This is a semantic
controller mismatch, not evidence for another scalar gain edit.

## Candidate hypothesis

Preserve the assigned parent's gait, targeting scaffold, carrier/steering
decomposition, common phase-preserving rate governor, and all parameter values.
Make one mechanism-level correction: release redirect priority from the signed
yaw response to `redirect_command`, the command whose steering residual is
being prioritized, rather than from response to `turn_command`. When course
correction and LOS steering agree, behavior is unchanged. When they oppose,
an achieved course redirect can release rhythmic carrier authority while the
existing outward-work term still protects the rate envelope. This implements
the inherited C-start response handoff without time, route memory, coordinates,
or a new scalar schedule.

bookshelf_consulted: true
source_domain: biological C-start redirects and sensor-modulated robotic-fish CPG direction tracking
source_mechanism: apply bounded redirect curvature for a large observed direction error, then release rhythmic propulsion when the corresponding measured heading response appears
transferable_invariant: response-gated allocation must compare the measured response with the same signed body-frame redirect request whose authority it is releasing
nontransferable_details: species-specific C-start shapes, published gains and beat frequencies, exact tail phase, full-body kinematics, and task-specific routes
policy_translation: replace LOS-turn-times-yaw alignment only in the unfulfilled course-redirect carrier request with redirect-command-times-normalized-yaw alignment; preserve the two-joint carrier phase and all steering residuals
falsification: reject if CFD loses capture or coherent wake, fails to retain the parent's early milestone and `16.044T/1.82409L` class, widens the `13.178L` path, increases `0.03579/0.01770` peak load or near-rate residence, or merely returns to the `17.418--17.990T` guarded class without a material path/load benefit

The candidate's CFD result is prospective and must be judged by a later
worker; no outcome from the present edit is claimed here.
