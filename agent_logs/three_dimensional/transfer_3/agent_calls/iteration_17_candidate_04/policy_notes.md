# Response-released envelope-reallocation candidate

## Visual diagnosis recorded before the policy edit

- Every sampled and inherited rollout used direct uniform initialization in
  still water with `U_infinity=(0,0,0)`, no cylinders, and no prewarm. I
  inspected the combined top-down mid-plane vorticity and oblique Lambda2 rows
  for the strongest sampled capture, its byte-identical inherited failure, and
  the assigned parent's newest cue-union failure. All three fish translate
  against quiescent water while leaving an alternating mid-plane street and
  compact tail-associated three-dimensional vortices. The two failures keep
  an energetic wake through the target pass; they are route-control failures,
  not advection, wake collapse, or numerical instability.
- The acceleration-feasible response-gated policy captures in two sampled
  evaluations at `19.2335T` and `19.2830T`, scores `-0.17657` and `-0.18218`,
  with local-flow RMS near `(0.0175,0.0042)U`. Yet an inherited evaluation of
  the byte-identical file passes `1.877L` high at the target x station, reaches
  only `1.845L`, and exits left at `28.875T` with score `-9.77873`. Its local
  flow remains small, `(0.0198,0.0064)U`, while force/moment RMS rises to about
  `0.0157/0.0081`; an exact winner rematerialization is therefore not a robust
  policy lesson.
- The assigned parent's cue-union candidate also retains a coherent wake but
  crosses the target x station `1.320L` high, reaches only `1.196L`, and exits
  left at `30.355T` with score `-10.7292`. At the first `5L` crossing, offline
  body-frame replay gives bearing magnitudes `0.209/0.214 rad` for the two
  captures, versus `0.761 rad` for the byte-identical failure and `0.544 rad`
  for the cue-union failure. In both failures the bounded target yaw demand is
  already `+0.5 rad/T` and the large-bearing anterior recruitment weight is
  near one. Another OR trigger cannot add authority after that saturation.
- The successful sheets keep a nearly straight alternating street into the
  capture circle. The failed sheets continue left on a high trajectory and
  only curl substantially after the pass. Since propulsion remains strong and
  raw posterior acceleration is already at its physical limit for roughly
  three quarters of the sampled capture rows, more drive or another posterior
  scalar gain is not supported. The missing capability is a bounded change in
  how the existing anterior motion envelope is used when route error stays
  severe.

## Policy hypothesis recorded before editing

Start from the strongest sampled acceleration-feasible response-gated C-bend.
Preserve its normalized body-frame bearing/LOS request, phase-conditioned
posterior steering, `28 degree`/`0.55T` traveling carrier, distributed mean
curvature, and explicit physical acceleration projection.

Add one response-released envelope-reallocation mechanism. Severe normalized
bearing smoothly recruits an extra same-sign anterior mean bend, while the
same angular amount is removed from the centered anterior oscillation
amplitude. This suppresses the counter-turn half-cycle without increasing the
evidenced same-side peak joint angle. The added mean bend is multiplied by the
existing bounded LOS target-yaw request, so it vanishes or reverses when LOS
response cancels or reverses the turn demand; it is neither a fixed bias nor a
clocked burst. The posterior target remains relative to the resulting centered
anterior wave, preserving a two-joint traveling bend.

The expected semantic improvement is to turn the inherited high branch before
the target x station while leaving the low-error sampled capture topology and
far-field carrier substantially unchanged. Falsify the mechanism if it loses
capture, repeats a more-than-`1L` high pass, creates the earlier short tight-turn
exit associated with undamped half-cycle steering, weakens the coherent wake,
or increases applied limit occupancy or force/moment load. A single later
capture would not establish repeatability; compare the result against both the
two sampled captures and the byte-identical failure.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish asymmetric flapping and biological burst-redirect turning
source_mechanism: preserve rhythmic propulsion while observed route error reversibly trades a counter-turn half-cycle for bounded mean curvature, then releases as directional response meets demand
transferable_invariant: a saturated mean-turn controller can obtain more directional authority from the existing motion envelope by reducing motion that opposes the requested turn, without increasing the evidenced peak envelope
nontransferable_details: published gains, duty ratios, species-specific C-start shapes, robot linkage geometry, dimensional frequency, exact vortex phase, and task-specific routes
policy_translation: use normalized body-frame bearing to recruit envelope reallocation and the bounded bearing-plus-LOS target-yaw request to set its sign and response release; apply it only to the anterior oscillator center/amplitude while retaining posterior feedback and the two-joint acceleration projection
falsification: reject if the high-pass topology remains, a short overturning exit returns, sampled capture is lost, the wake weakens, or saturation and hydrodynamic loads increase

## Validation status

- The mandated checker reports PASS for the material guidance update and PASS
  for the solver edit boundary. A separate deterministic schema audit finds
  all 26 direct `params.FIELD` references in `target_policy_params()`.
- Frozen-trace algebra replay gives mean burst recruitment `0.075/0.086` on
  the two sampled captures versus `0.483` on the byte-identical high-pass
  failure. Across those three traces the effective anterior amplitude remains
  at least `20.55 degrees`, the combined center remains below `13.04 degrees`,
  and every translated command remains inside the owned acceleration bound.
  The construction is reflection-equivariant because lateral reflection flips
  bearing, target yaw, both mean bends, joint state, and returned actions while
  leaving the absolute recruitment weights and amplitude unchanged.
- The checker's lightweight Julia probe cannot start because this environment
  has no `julia` executable. This is an unavailable runtime check, not a pass.
  No CFD evaluation was run and no outcome for this candidate is claimed.
